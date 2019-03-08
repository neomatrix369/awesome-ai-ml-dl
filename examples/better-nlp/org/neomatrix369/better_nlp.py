import spacy  # $ pip install spacy
import time


class BetterNLP:
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
        return ['GPE = ', 'FAC = ', 'DATE = calendar date',
                'NORP = Noun or Pronoun',
                'PERSON = name of a person (proper noun)',
                'ORG = Organisation']

