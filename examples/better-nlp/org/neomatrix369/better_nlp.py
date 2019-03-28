import spacy             # $ pip install spacy
import time
import textacy.extract   # $ pip install textacy


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
        nlp_model = 'en_core_web_lg'

        if self.english_nlp_model is None: 
            print("Loading model {}...".format(nlp_model))
            start_time = time.time()
            self.english_nlp_model = spacy.load(nlp_model)
            self.model_loading_time = time.time() - start_time
            time_label = "model_loading_time_in_secs"    
        else:
            time_label = "model_loading_time_saved_in_secs"
        
        result = {}
        result[time_label] = self.model_loading_time
        result["model_name"] = nlp_model
        result["model"] = self.english_nlp_model
        return result

    def token_legend():
        return ['GPE = Geographic Point Entity', 'FAC = ', 
                'DATE = calendar date',
                'NORP = Noun or Pronoun',
                'PERSON = name of a person (proper noun)',
                'ORG = Organisation']

    def extract_entities(self, model, text):
        start_time = time.time()
        parsed_text = model(text)
        duration = time.time() - start_time

        result = {}
        result["parsed_text"] = parsed_text
        result["extract_entities_processing_time_in_secs"] = duration
        return result

    def extract_nouns_chunks(self, model, text):
        parsed_generic_text = self.extract_entities(model, text)
        parsed_generic_text = parsed_generic_text.get("parsed_text")
        start_time = time.time()
        noun_chunks = textacy.extract.noun_chunks(parsed_generic_text, min_freq=self.minimum_occurrence_frequency)
        noun_chunks = map(str, noun_chunks)
        noun_chunks = map(str.lower, noun_chunks)
        duration = time.time() - start_time

        result = {}
        result["parsed_text"] = parsed_generic_text
        result["noun_chunks"] = noun_chunks
        result["noun_chunks_processing_time_in_secs"] = duration
        return result

    def extract_facts(self, model, text, target_topic):
        start_time = time.time()
        parsed_generic_text = self.extract_entities(model, text)
        parsed_generic_text = parsed_generic_text.get("parsed_text")
        facts = textacy.extract.semistructured_statements(parsed_generic_text, target_topic)
        duration = time.time() - start_time

        result = {}
        result["parsed_text"] = parsed_generic_text
        result["facts"] = facts
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