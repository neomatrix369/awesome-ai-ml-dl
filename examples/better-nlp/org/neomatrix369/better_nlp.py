import spacy             # $ pip install spacy
import time
import textacy.extract   # $ pip install textacy


MINIMUM_NUM_OF_WORDS = 1
MINIMUM_OCCURRENCE_FREQUENCY = 2


class BetterNLP:

    MINIMUM_NUM_OF_WORDS = 1
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
        return self.english_nlp_model(text)

    def extract_nouns_chunks(self, text):
        parsed_generic_text = BetterNLP().extract_entities(text)
        chunks = textacy.extract.noun_chunks(parsed_generic_text, min_freq=self.minimum_occurrence_frequency)
        chunks = map(str, chunks)
        return map(str.lower, chunks)


