"""
BetterNLP is a wrapper program/library that encapsulates a couple
of NLP libraries that are popular among the AI and ML communities.
"""
#
# Copyright 2019 Mani Sarkar
#
# Licensed under the Apache License, Version 2.0 (the "License")
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

### Please feel free to fork this work as long as you maintain the above
### license and provide citation.

import time
import struct
import pandas as pd      # $ pip install pandas

print("This version of Python is {} bits.".format(8 * struct.calcsize("P")))

### These two imports must stay here till we have installed them using
### pip install in the above block of code
### Note: you will see a number of 'pylint: disable...' across the
### code snippet to disable false positives or not relevant warnings
### thrown by pylint
# pylint: disable=C0413
import spacy             # $ pip install spacy
import textacy.extract   # $ pip install textacy

from org.neomatrix369.summariser_cosine          import SummariserCosine
from org.neomatrix369.summariser_pytextrank      import SummariserPyTextRank
from org.neomatrix369.summariser_tfidf           import SummariserTFIDF
from org.neomatrix369.summariser_tfidf_variation import SummariserTFIDFVariation


MINIMUM_NUM_OF_WORDS = 1
MINIMUM_OCCURRENCE_FREQUENCY = 1

def obfuscate(token, entity_type="PERSON"):
    """
      Obfuscates a given token depending on its type,
      default is PERSON type (internal function)

      Parameters
      ==========
      model:
          a trained NLP model
      text:
          the text to extract the entities from

      Return
      ======
      Extracted entities from the text using the passed in model
    """
    if token.string.strip() not in ['', '\n', '\t']:
        if token.ent_iob != 0 and token.ent_type_ == entity_type:
            return "[OBFUSCATED] "
        return token.string
    return ''


class BetterNLP:
    """
      BetterNLP orchestrates all the NLP related functions
      contained in this source file
    """

    minimum_occurrence_frequency = MINIMUM_OCCURRENCE_FREQUENCY

    english_nlp_model = None

    model_loading_time = 0

    def load_nlp_model(self):
        """
        Loads the NLP model in a lazy manner, if it was called the first time,
        it would load the NLP model, remember it and return the reference to the model.
        Subsequent calls results in returning the reference to the remembered model.

        Parameters
        ==========
        <none>:
            Does not take in a parameter

        Return
        ======
        Returns an NLP model and meta data about the operation

        Note:
        Ensure you do the below two steps before loading
        the English NLP Model:

           $ python3 -m spacy download en_core_web_lg
           $ python3 -m spacy link en_core_web_lg en
        """
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

    # pylint: disable=R0201
    def token_entity_types(self):
        """
          Returns the legend of all the entity types,
          both abbreviations and their meaning

          Parameters
          ==========
          <none>:
              Does not take in a parameter

          Return
          ======
          A json object containing abbrevations and the meanings of each of the Entity types.
        """
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

    # pylint: disable=R0201
    def pretty_print(self, data, max_colwidth=500):
        """
          Pretty prints a dataframe,
          default max col width is 500

          Parameters
          ==========
          data:
              a valid dataframe or compatible Python datatype
          max_colwidth (optional, default: 500):
              the column width to observe when pretty
              printing the dataframe content

          Return
          ======
          Nothing, instead pretty-prints the data frame on the console
        """
        pd.set_option('display.max_colwidth', max_colwidth)
        print(pd.DataFrame(data))

    # pylint: disable=R0201
    def extract_entities(self, model, text):
        """
          Extract entities using the model,
          from the text passed in

          Parameters
          ==========
          model:
              a trained NLP model
          text:
              the text to extract the entities from

          Return
          ======
          Extracted entities from the text using the passed in model
          and meta data about the operation
        """
        start_time = time.time()
        # pylint: disable=E1102
        parsed_text = model(text)

        data = {
            "text": [each_entity.text for each_entity in parsed_text.ents \
                           if each_entity.text.strip() == each_entity.text],
            "label": [each_entity.label_ for each_entity in parsed_text.ents \
                           if each_entity.text.strip() == each_entity.text]
        }
        duration = time.time() - start_time

        result = {}
        result["parsed_text"] = parsed_text
        result["extracted_entities"] = data
        result["extract_entities_processing_time_in_secs"] = duration
        return result

    def parts_of_speech_tagging(self, model, text):
        """
          Extract the parts of speech using the model,
          from the text passed in

          Parameters
          ==========
          model:
              a trained NLP model
          text:
              the text to extract the entities from

          Return
          ======
          Parts of speech (as a json object) extracted from the text
          using the passed in model and meta data about the operation
        """
        # pylint: disable=E1121
        parsed_generic_text = self.extract_entities(model, text).get("parsed_text")

        start_time = time.time()
        parts_of_speech_tagging = \
             {
                 'token': [
                     token.text for token in parsed_generic_text
                 ],
                 'lemma': [
                     token.lemma_ for token in parsed_generic_text
                 ],
                 'parts-of-speech': [
                     token.pos_ for token in parsed_generic_text
                 ],
                 'tag': [
                     token.tag_ for token in parsed_generic_text
                 ],
                 'syntactic dependency': [
                     token.dep_ for token in parsed_generic_text
                 ],
                 'shape': [
                     token.shape_ for token in parsed_generic_text
                 ],
                 'is_alphanumeric': [
                     token.is_alpha for token in parsed_generic_text
                 ],
                 'is_stop_word': [
                     token.is_stop for token in parsed_generic_text
                 ]
             }
        duration = time.time() - start_time

        result = {}
        result["parsed_text"] = parsed_generic_text
        result["parts_of_speech"] = parts_of_speech_tagging
        result["parts_of_speech_processing_time_in_secs"] = duration
        return result

    def extract_noun_chunks(self, model, text):
        """
          Extract noun chunks using the model,
          from the text passed in

          Parameters
          ==========
          model:
              a trained NLP model
          text:
              the text to extract noun chunks from

          Return
          ======
          list of noun chunks and meta data about the operation
        """
        # pylint: disable=E1121
        parsed_generic_text = self.extract_entities(model, text)
        parsed_generic_text = parsed_generic_text.get("parsed_text")
        start_time = time.time()
        noun_chunks = textacy.extract.noun_chunks( \
                         parsed_generic_text, \
                         min_freq=self.minimum_occurrence_frequency)
        noun_chunks = map(str, noun_chunks)
        noun_chunks = map(str.lower, noun_chunks)

        set_of_noun_chunks = set(noun_chunks)

        data = {'Words belonging together (lowercase)':
                [each_noun_chunk for each_noun_chunk in
                 set_of_noun_chunks \
                         if len(each_noun_chunk.split(" ")) > \
                                   self.minimum_occurrence_frequency]}
        duration = time.time() - start_time

        result = {}
        result["parsed_text"] = parsed_generic_text
        result["noun_chunks"] = data
        result["noun_chunks_processing_time_in_secs"] = duration
        return result

    # pylint: disable=R0201
    def get_facts(self, facts, target_topic):
        """
          Extract facts for the target topic from
          the passed in data structure (internal function)

          Parameters
          ==========
          facts:
              list of facts (structured data)
          target_topic:
              name or type of the topic to use to find facts

          Return
          ======
          Facts extracted from the facts data structure based on the target_topic parameter
        """
        list_of_facts = []
        for each_fact_statement in facts:
            # pylint: disable=W0612
            subject, verb, fact = each_fact_statement
            list_of_facts.append(fact.text)

        result = {
            'Facts about ' + target_topic: list_of_facts
        }

        return result

    def extract_facts(self, model, text, target_topic):
        """
          Extract facts using the model,
          from the text passed in

          Parameters
          ==========
          model:
              a trained NLP model
          text:
              the text to extract facts from
          target_topic:
              name or type of the topic to use to find facts

          Return
          ======
          Facts extracted from the text, and meta data about the operation
        """
        start_time = time.time()
        # pylint: disable=E1121
        parsed_generic_text = (self.extract_entities(model, text)
                               .get("parsed_text"))
        facts = textacy.extract.semistructured_statements( \
                                parsed_generic_text, target_topic)

        list_of_facts = self.get_facts(facts, target_topic)

        duration = time.time() - start_time

        result = {}
        result["parsed_text"] = parsed_generic_text
        result["facts"] = list_of_facts
        result["extract_facts_processing_time_in_secs"] = duration
        return result

    def obfuscate_text(self, model, text):
        """
          Obfuscate the entities using the model,
          in the text passed in

          Parameters
          ==========
          model:
              a trained NLP model
          text:
              the text to obfuscate

          Return
          ======
          Returns obfuscated text with the indicated tokens redacted,
          and meta data about the operation
        """
        # pylint: disable=E1121
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
        """
          Summarise a block of text and return a gist
          of the original text along with metadata.

          Parameters
          ==========
          text:
              the text to extract to summarise
          method:
              sumarisation method to use, the 4 supported methods are:
                   SummariserCosine (cosine)
                   SummariserPyTextRank (pytextrank)
                   SummariserTFIDF (tfidf)
                   SummariserTFIDFVariation (tfidf-ignore-stopwords)
          top_n_sentences:
               top n number of sentences to pick from the
               list of candidate sentences sorted in descending order
               (highest to lowest scores)

          Return
          ======
          Extracted entities from the text using the passed in model and
          meta data about the operation
        """
        start_time = time.time()

        result = {}
        if method == "cosine":
            summariser = SummariserCosine()
            result["summarised_text"], result["ranked_sentences"] = \
                        summariser.generate_summary(text, top_n_sentences)
        elif method == "pytextrank":
            summariser = SummariserPyTextRank()
            result["summarised_text"], result["token_ranks"], \
                     result["key_phrases"], result["graph"] = \
                        summariser.generate_summary(text, top_n_sentences)
        elif method == "tfidf":
            summariser = SummariserTFIDF()
            result["summarised_text"], result["important_words"] = \
                        summariser.generate_summary(text, top_n_sentences)
        elif method == "tfidf-ignore-stopwords":
            summariser = SummariserTFIDFVariation()
            result["summarised_text"], result["scored_documents"] = \
                        summariser.generate_summary(text, top_n_sentences)

        duration = time.time() - start_time
        result["summarisation_processing_time_in_secs"] = duration

        return result

    def show_graph(self, graph, method="pytextrank"):
        """
          Return a graph of the vertices when using
          the SummariserPyTextRank summeriser, otherwise do nothing

          Parameters
          ==========
          graph:
              the graph object containing the vertices
          method:
              indicate the summarisation method the call is coming from
          Return:
              Nothing, just prints the graph onto the console
        """
        if method == "pytextrank":
            summariser = SummariserPyTextRank()
            summariser.show_graph(graph)
