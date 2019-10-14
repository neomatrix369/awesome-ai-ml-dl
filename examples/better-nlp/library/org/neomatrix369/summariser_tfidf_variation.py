"""
BetterNLP is a wrapper program/library that encapsulates a couple
of NLP libraries that are popular among the AI and ML communities.

Summarisation method: a variation of TDIDF (ignores stopwords)
Credits to the Shivangi Sareen for the posts:
- Summarise Text with TFIDF in Python 1
https://towardsdatascience.com/tfidf-for-piece-of-text-in-python-43feccaa74f8
- Summarise Text with TFIDF in Python 2
https://medium.com/@shivangisareen/summarise-text-with-tfidf-in-python-bc7ca10d3284
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

### https://github.com/neomatrix369/awesome-ai-ml-dl/blob/master/examples/better-nlp/
### or https://bit.ly/better-nlp
### Kaggle kernel: https://www.kaggle.com/neomatrix369/better-nlp-class-notebook

### Please feel free to fork this work as long as you maintain the above
### license and provide citation.

import struct
print("This version of Python is {} bits.".format(8 * struct.calcsize("P")))

# pylint: disable=C0413
import re
import math

from nltk.tokenize import word_tokenize, sent_tokenize


class SummariserTFIDFVariation:
    """ Summary text using the TFIDF method, does not remove stopwords"""


    # pylint: disable=R0201
    def remove_string_special_characters(self, sentence):
        """
            Removes special characters from within a string

            Parameters
            ==========
                s(str): single input string.

            Return
            ======
                stripped(str): A string with special characters removed
        """
        # Replace special character with ' '
        stripped = re.sub('[A\\w\\s]', '', sentence)
        stripped = re.sub('_', '', stripped)
        # Change any whitespace to one space
        stripped = re.sub('\\s+', '', stripped)
        # Remove start and end white spaces
        return stripped.strip()

    # pylint: disable=R0201
    def convert_sentences_into_documents(self, text_sentences):
        """
          Split the text into sentences and consider each sentence as a document,
          calculate the total word count of each sentence.

          Parameters
          ==========
          text_sentences:
            raw text to summarise, usually a long string of text made up of multiple sentences

          Return
          ======
          List of dictionary (doc id, words in the sentence) extracted from the sentence text
        """
        documents = []
        i = 0
        for sentence in text_sentences:
            i += 1
            num_of_words_in_the_sentence = len(word_tokenize(sentence))
            temp = {'doc_id' : i,
                    'doc_length' : num_of_words_in_the_sentence}

            documents.append(temp)
        return documents

    # pylint: disable=R0201
    def create_word_frequency_dictionary(self, sentences):
        """
          Create a frequency dictionary for each word in each document.

          Parameters
          ==========
          sentences:
            raw text to summarise, usually a long string of text made up of multiple sentences

          Return
          ======
          List of dictionary (doc id, dictionary of word frequency) extracted from the sentence text
        """
        i = 0
        word_frequency_dictionary = []
        for sentence in sentences:
            i += 1
            freq_dict = {}

            for word in word_tokenize(sentence):
                word = word.lower()
                if word in freq_dict:
                    freq_dict[word] += 1
                else:
                    freq_dict[word] = 1
                temp = {'doc_id' : i,
                        'freq_dict': freq_dict}

            word_frequency_dictionary.append(temp)

        return word_frequency_dictionary

    # pylint: disable=R0201
    def compute_document_tf_scores(self, documents, word_frequency_dictionaries):
        """
          tf = (frequency of the term in the doc
                  divided
                  by the total number of terms in the doc)

          Parameters
          ==========
          documents:
            texts stored as documents (with id and dictionary meta data)
          word_frequency_dictionaries:
            dictionary of word frequencies

          Return
          ======
          List of TF scores of the documents (based on the TF score calculation)
          along with the documents that are scored
        """
        scores = []
        for dictionary in word_frequency_dictionaries:
            doc_id = dictionary['doc_id']
            for k in dictionary['freq_dict']:
                frequency_of_terms_in_document = dictionary['freq_dict'][k]
                total_terms_in_the_doc = documents[doc_id-1]['doc_length']
                score = frequency_of_terms_in_document/total_terms_in_the_doc
                temp = {
                    'doc_id' : doc_id,
                    'TF_score' : score,
                    'key' : k
                }
                scores.append(temp)

        return scores

    def compute_document_idf_scores(self, documents, word_frequency_dictionary):
        """
          idf = ln(total number of docs divided by
                     number of docs with the term in it)
          ln() = natural log of

          Parameters
          ==========
          documents:
            texts stored as documents (with id and dictionary meta data)
          word_frequency_dictionaries:
            dictionary of word frequencies

          Return
          ======
          List of IDF scores of the documents (based on the IDF score calculation)
          along with the documents that are scored
        """
        scores = []
        counter = 0
        for dictionary in word_frequency_dictionary:
            counter += 1
            for k in list(dictionary['freq_dict'].keys()):
                total_documents = len(documents)
                total_docs_with_term_in_it = \
                     sum([k in dictionary['freq_dict'] \
                             for dictionary in word_frequency_dictionary])
                score = math.log(total_documents / total_docs_with_term_in_it)

                temp = {'doc_id' : counter,
                        'IDF_score' : score,
                        'key' : k}

                scores.append(temp)

        return scores

    def compute_document_tfidf_scores(self, tf_scores, idf_scores):
        """
          computes the product of TF and IDF scores
          for each document (sentence) for documents that match
          by key and doc_id

          Parameters
          ==========
          tf_scores:
            TF scores of the sentences of the text to summarise
          idf_scores:
            TF scores of the sentences of the text to summarise

          Return
          ======
          List of TFIDF scores of the documents (based on the TFIDF score calculation)
          along with the documents that are scored
        """
        scores = []
        for j in idf_scores:
            for i in tf_scores:
                if j['key'] == i['key'] and j['doc_id'] == i['doc_id']:
                    temp = {'doc_id' : j['doc_id'],
                            'TFIDF_score' : i['TF_score'] * j['IDF_score'],
                            'key' : i['key']}
            scores.append(temp)
        return scores

    def compute_sentence_scores(self, tfidf_scores, sentences, documents):
        """
          The score of a sentence is calculated by adding
          the TFIDF scores of the words that make up the sentence for
          the document that represents that sentence

          Parameters
          ==========
          tfidf_scores:
            TFIF scores of the sentences of the text to summarise
          sentences:
            Raw sentences of the text to summarise
          documents:
            Raw sentences as documents of the text to summarise

          Return
          ======
          List of dictionary of sentences with their scores and doc id
        """

        sentence_info = []
        for document in documents:
            # pylint: disable=W0105
            """Loop through each document(sentence) and calculates their 'score'"""
            score = 0
            # pylint: disable=W0612
            for index, value in enumerate(tfidf_scores):
                dictionary = value
                if document['doc_id'] == dictionary['doc_id']:
                    score += dictionary['TFIDF_score']

            temp = {'doc_id' : document['doc_id'],
                    'sent_score' : score,
                    'sentence' : sentences[document['doc_id'] - 1]}

            sentence_info.append(temp)

        return sentence_info

    def filter_sentences_by_score(self, sentence_info, top_n_sentences):
        """
          Filter sentences after summing their scores,
          only select sentences that meet a criteria.
          Types of criteria:
             - top n sentences (scores sorted in descending order)
             - sentence score >= average
                    --- suitable for average or smaller sized documents
             - sentence score >= average + (1.5 * stddev)
                    --- for medium sized documents
             - sentence score >= average + (3 * stddev)
                    --- for large documents

          The current functionality checks for the first type of condition.
          These sentences joined together make up the summary.

          Parameters
          ==========
          sentence_info:
            list of dictionary of sentences with their scores
          top_n_sentences:
            number of sentences to pick from the top scored sentences (descending order)

          Return
          ======
          List of top n sentences from the scored list of sentences that form the summary
          and also the whole list of sorted sentences
        """
        summary = []

        # pylint: disable=W0105
        """
            Sort the sentences by its score in descending order
            and pick the top n sentences from the list
        """
        sorted_sentence_info = sorted(sentence_info, key=lambda k: -k['sent_score'])
        counter = 0
        if top_n_sentences > len(sorted_sentence_info):
            top_n_sentences = len(sorted_sentence_info)

        for sentence in sorted_sentence_info:
            if counter < top_n_sentences:
                summary.append(sentence['sentence'])
                counter = counter + 1
            else:
                break

        return ' '.join(summary), sorted_sentence_info

    def generate_summary(self, text, top_n_sentences):
        """
          Get the text, clean it by removing special characters,
          get the frequency of the words and create a dictionary,
          compute the TF scores of sentences,
          compute the IDF scores of sentences,
          compute the combined TF-IDF scores of sentences,

          Iterate through sentences to create a summary based on a threshold point.
          Sentences with scores less than that don't make the summary.

          Parameters
          ==========
          text:
            raw text that needs summarisation
          top_n_sentences:
            number of sentences to pick from the top scored sentences (descending order)

          Return
          ======
          List of top n sentences from the scored list of sentences that form the summary
          and also the whole list of sorted sentences
        """
        tokenised_text_sentences = sent_tokenize(text)
        clean_tokenised_text_sentences = [
            self.remove_string_special_characters(sentence) for sentence in tokenised_text_sentences
        ]
        documents = self.convert_sentences_into_documents(clean_tokenised_text_sentences)

        word_frequency_dictionaries = \
            self.create_word_frequency_dictionary(clean_tokenised_text_sentences)
        document_tf_scores = \
            self.compute_document_tf_scores(documents, word_frequency_dictionaries)
        document_idf_scores = \
            self.compute_document_idf_scores(documents, word_frequency_dictionaries)

        document_tfidf_scores = \
            self.compute_document_tfidf_scores(document_tf_scores, document_idf_scores)
        sentences_info = \
            self.compute_sentence_scores(document_tfidf_scores, tokenised_text_sentences, documents)
        summarised_text, sorted_sentence_info = \
            self.filter_sentences_by_score(sentences_info, top_n_sentences)
        return summarised_text, sorted_sentence_info
