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

    def __init__(self):
        self.english_nlp_model = None

    @staticmethod
    def load_nlp_model():
        start_time = time.time()
        # Ensure you do the below two steps before loading the English NLP Model:
        #
        # 	$ python3 -m spacy download en_core_web_lg
        # 	$ python3 -m spacy link en_core_web_lg en
        #
        nlp_model = 'en_core_web_lg'
        print("Loading model {}...".format(nlp_model))
        english_nlp_model = spacy.load(nlp_model)
        end_time = time.time()
        print("Time taken to load the {} model: {} seconds\n".format(nlp_model, end_time-start_time))
        return english_nlp_model

    @staticmethod
    def token_legend():
        return ['GPE = Geographic Point Entity', 'FAC = ', 'DATE = calendar date',
                'NORP = Noun or Pronoun',
                'PERSON = name of a person (proper noun)',
                'ORG = Organisation']

    def extract_entities(self, text):
        if self.english_nlp_model is None:
            self.english_nlp_model = self.load_nlp_model()
        start_time = time.time()
        parsed_text = self.english_nlp_model(text)
        end_time = time.time()
        print("Time taken to process the generic text: {} seconds".format(end_time - start_time))
        print("\n")
        return parsed_text

    def extract_nouns_chunks(self, text):
        parsed_generic_text = self.extract_entities(text)
        start_time = time.time()
        chunks = textacy.extract.noun_chunks(parsed_generic_text, min_freq=self.minimum_occurrence_frequency)
        chunks = map(str, chunks)
        end_time = time.time()
        print("Time taken to process the generic text: {} seconds".format(end_time - start_time))
        print("\n")
        return map(str.lower, chunks)

    def extract_facts(self, text, target_topic):
        start_time = time.time()
        parsed_generic_text = self.extract_entities(text)
        end_time = time.time()
        print("Time taken to process the generic text: {} seconds".format(end_time - start_time))
        print("\n")
        return textacy.extract.semistructured_statements(parsed_generic_text, target_topic)

    def obfuscate_text(self, text):
        start_time = time.time()
        parsed_generic_text = self.extract_entities(text)

        for each_entity in parsed_generic_text.ents:
            each_entity.merge()

        end_time = time.time()
        print("Time taken to process the generic text: {} seconds".format(end_time - start_time))
        print("\n")
        return map(obfuscate, parsed_generic_text)
