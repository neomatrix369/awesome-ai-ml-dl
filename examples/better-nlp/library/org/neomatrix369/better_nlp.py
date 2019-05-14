import spacy             # $ pip install spacy
import time
import textacy.extract   # $ pip install textacy
import pandas as pd      # $ pip install pandas

from org.neomatrix369.summariser_cosine import SummariserCosine
from org.neomatrix369.summariser_pytextrank import SummariserPyTextRank

MINIMUM_NUM_OF_WORDS = 1
MINIMUM_OCCURRENCE_FREQUENCY = 1


def obfuscate(token, entity_type="PERSON"):
    if token.string.strip() not in ['', '\n', '\t']:
        if token.ent_iob != 0 and token.ent_type_ == entity_type:
            return "[OBFUSCATED] "
        else:
            return token.string
    else:
        return ''


class BetterNLP:

    minimum_occurrence_frequency = MINIMUM_OCCURRENCE_FREQUENCY

    english_nlp_model = None

    model_loading_time = 0
    
    def load_nlp_model(self):
        # Ensure you do the below two steps before loading the English NLP Model:
        #
        # 	$ python3 -m spacy download en_core_web_lg
        # 	$ python3 -m spacy link en_core_web_lg en
        #
        nlp_model = 'en'

        if self.english_nlp_model is None: 
            print("Loading model '{}'...".format(nlp_model))
            start_time = time.time()
            self.english_nlp_model = spacy.load(nlp_model)
            self.model_loading_time = time.time() - start_time
            model_loading_method = "directly, first time"
        else:
            print("Loading model '{}' from cache...".format(nlp_model))
            model_loading_method = "from cache"

        result = {}
        result["model_loading_time_in_secs"] = self.model_loading_time
        result["model_loading_method"] = model_loading_method
        result["model_name"] = nlp_model
        result["model"] = self.english_nlp_model
        return result

    def token_entity_types(self):
        return {
            'Entity type':[
                'PERSON',
                'NORP',
                'FAC',
                'ORG',
                'GPE',
                'LOC',
                'PRODUCT',
                'EVENT',
                'WORK_OF_ART',
                'LAW',
                'LANGUAGE',
                'DATE',
                'TIME',
                'PERCENT',
                'MONEY',
                'QUANTITY',
                'ORDINAL',
                'CARDINAL'
            ],
            'Description':[
                'People, including fictional',
                'Nationalities or religious or political groups',
                'Buildings, airports, highways, bridges, etc',
                'Companies, agencies, institutions, etc',
                'Countries, cities, states',
                'Non-GPE locations, mountain ranges, bodies of water',
                'Objects, vehicles, foods, etc. (Not services.',
                'Named hurricanes, battles, wars, sports events, etc',
                'Titles of books, songs, etc',
                'Named documents made into laws',
                'Any named language',
                'Absolute or relative dates or periods',
                'Times smaller than a day',
                'Percentage, including ”%“',
                'Monetary values, including unit',
                'Measurements, as of weight or distance',
                '“first”, “second”, etc',
                'Numerals that do not fall under another type'
            ]
        }
    
    def pretty_print(self, data, max_colwidth=500):
        pd.set_option('display.max_colwidth', max_colwidth)
        print(pd.DataFrame(data))

    def extract_entities(self, model, text):
        start_time = time.time()
        parsed_text = model(text)

        data = {
            "text": [each_entity.text for each_entity in parsed_text.ents if each_entity.text.strip() == each_entity.text],
            "label": [each_entity.label_ for each_entity in parsed_text.ents if each_entity.text.strip() == each_entity.text]
        }
        duration = time.time() - start_time

        result = {}
        result["parsed_text"] = parsed_text
        result["extracted_entities"] = data
        result["extract_entities_processing_time_in_secs"] = duration
        return result

    def parts_of_speech_tagging(self, model, text):
        parsed_generic_text = self.extract_entities(model, text).get("parsed_text")

        start_time = time.time()
        parts_of_speech_tagging = {'token': [token.text for token in parsed_generic_text], 
                'lemma': [token.lemma_ for token in parsed_generic_text],
                'parts-of-speech': [token.pos_ for token in parsed_generic_text],
                'tag': [token.tag_ for token in parsed_generic_text],
                'syntactic dependency': [token.dep_ for token in parsed_generic_text],
                'shape': [token.shape_ for token in parsed_generic_text],        
                'is_alphanumeric': [token.is_alpha for token in parsed_generic_text],
                'is_stop_word': [token.is_stop for token in parsed_generic_text]}
        duration = time.time() - start_time

        result = {}
        result["parsed_text"] = parsed_generic_text
        result["parts_of_speech"] = parts_of_speech_tagging
        result["parts_of_speech_processing_time_in_secs"] = duration
        return result                

    def extract_noun_chunks(self, model, text):
        parsed_generic_text = self.extract_entities(model, text)
        parsed_generic_text = parsed_generic_text.get("parsed_text")
        start_time = time.time()
        noun_chunks = textacy.extract.noun_chunks(parsed_generic_text, min_freq=self.minimum_occurrence_frequency)
        noun_chunks = map(str, noun_chunks)
        noun_chunks = map(str.lower, noun_chunks)

        set_of_noun_chunks = set(noun_chunks)

        data = {'Words belonging together (lowercase)': [each_noun_chunk for each_noun_chunk in set_of_noun_chunks if len(each_noun_chunk.split(" ")) > self.minimum_occurrence_frequency]}
        duration = time.time() - start_time

        result = {}
        result["parsed_text"] = parsed_generic_text
        result["noun_chunks"] = data
        result["noun_chunks_processing_time_in_secs"] = duration
        return result

    def extract_facts(self, model, text, target_topic):
        start_time = time.time()
        parsed_generic_text = self.extract_entities(model, text)
        parsed_generic_text = parsed_generic_text.get("parsed_text")
        facts = textacy.extract.semistructured_statements(parsed_generic_text, target_topic)

        list_of_facts=[]
        for each_fact_statement in facts:
            subject, verb, fact = each_fact_statement
            list_of_facts.append(fact.text)

        data = {
            'Facts about ' + target_topic: list_of_facts
        }

        duration = time.time() - start_time

        result = {}
        result["parsed_text"] = parsed_generic_text
        result["facts"] = data
        result["extract_facts_processing_time_in_secs"] = duration
        return result

    def obfuscate_text(self, model, text):
        parsed_generic_text = self.extract_entities(model, text)
        parsed_generic_text = parsed_generic_text.get("parsed_text")

        start_time = time.time()
        for each_entity in parsed_generic_text.ents:
            each_entity.merge()
        duration = time.time() - start_time
        
        result = {}
        result["parsed_text"] = parsed_generic_text
        result["obfuscate_text_processing_time_in_secs"] = duration
        result["obfuscated_text"] = map(obfuscate, parsed_generic_text)

        return result

    def summarise(self, text, method="cosine", top_n_sentences=5):
        start_time = time.time()

        result = {}
        if method == "cosine":
            summariser = SummariserCosine()
            result["summarised_text"], result["ranked_sentences"] = summariser.generate_summary(text, top_n_sentences)
        elif method == "pytextrank":
            summariser = SummariserPyTextRank()
            result["summarised_text"], result["key_phrases"], result["graph"] = summariser.generate_summary(text, top_n_sentences)

        duration = time.time() - start_time
        result["summarisation_processing_time_in_secs"] = duration

        return result

    def show_graph(self, graph, method="pytextrank"):
        if method == "pytextrank":
            summariser = SummariserPyTextRank()
            summariser.show_graph(graph)