"""
BetterNLP is a wrapper program/library that encapsulates a couple
of NLP libraries that are popular among the AI and ML communities.

Summarisation method: Cosine Method
Credits to Wilame Lima Vallantin, the author of
Build a simple text summarisation tool using NLTK
(https://medium.com/@wilamelima/build-a-simple-text-summarisation-tool-using-nltk-ff0984fedb4f)
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

#### Start of the Utility function

import struct

print("This version of Python is {} bits.".format(8 * struct.calcsize("P")))

# pylint: disable=C0413
import numpy as np      # $ pip install numpy
import networkx as nx   # $ pip install network
import nltk             # $ pip install nltk
from nltk.corpus import stopwords
from nltk.cluster.util import cosine_distance

STOP_WORDS = []
try:
    STOP_WORDS = stopwords.words('english')
    if not STOP_WORDS:
        nltk.download('stopwords')
except LookupError:
    nltk.download('stopwords')

class SummariserCosine:
    """
      Summary text using the Cosine method, see blog post for further details
      https://medium.com/@wilamelima/build-a-simple-text-summarisation-tool-using-nltk-ff0984fedb4f
    """

    # Generate clean sentences
    # pylint: disable=R0201
    def read_text(self, text):
        """
          Read the passed in text (as string) and split each line,
          that ends with a period (.)
          Replace anything that isn't between
          a to z or A to Z with a space.

          Parameters
          ==========
          text:
             text string to split into individual sentences

          Return
          ======
          Returns a list of sentences split by spaces
        """
        split_text = text.split(". ")

        sentences = []

        for sentence in split_text:
            sentences.append(sentence.replace("[^a-zA-Z]", " ").split(" "))

        sentences.pop()

        return sentences

    # pylint: disable=R0201
    def extract_vector(self, sentence, all_words, stop_words):
        """
          Extract vectors from the sentences,
          skip or ignore stop words from the
          stock of stop words loaded from the nltk library.
          Vectors here mean frequency count of
          the words by index.

          Parameters
          ==========
          sentence:
             a text string representing a sentence
          all_words:
             a list of words including the words in the passed in sentence
          stop_words:
             list of stop words to ignore or not take into consideration

          Return
          ======
          A dictionary of words with frequency of occurence of it in
          the sentence (also called vector)
        """
        extracted_vector = [0] * len(all_words)

        # build the vector for the sentence
        for word in sentence:
            if word in stop_words:
                continue
            extracted_vector[all_words.index(word)] += 1

        return extracted_vector

    # Are the two sentences similar function?
    def sentence_similarity(self, first_sentence, second_sentence, stop_words=None):
        """
          Check if two sentences are similar based
          on their vector similarity
          (similar number of frequenting words between them)

          Parameters
          ==========
          first_sentence:
             a text string representing a sentence
          second_sentence:
             another text string representing a sentence
          stop_words:
             list of stop words to ignore or not take into consideration

          Return
          ======
          An decimal representation of the similarity between the
          two sentences (frequency similarity)
        """
        if stop_words is None:
            stop_words = []

        first_sentence = [word.lower() for word in first_sentence]
        second_sentence = [word.lower() for word in second_sentence]

        all_words = list(set(first_sentence + second_sentence))

        first_vector = self.extract_vector(first_sentence, all_words, stop_words)
        second_vector = self.extract_vector(second_sentence, all_words, stop_words)

        return 1 - cosine_distance(first_vector, second_vector)

    # Similarity matrix
    def build_similarity_matrix(self, sentences, stop_words):
        """
          Create an similarity matrix using the sentences,
          round-robbing across all the sentences.

          So we know which sentences are similar
          to which others.

          Parameters
          ==========
          first_sentence:
             a text string representing a sentence
          second_sentence:
             another text string representing a sentence
          stop_words:
             list of stop words to ignore or not take into consideration

          Return
          ======
          An decimal representation of the similarity between the
          two sentences (frequency similarity)
        """
        # Create an empty similarity matrix
        similarity_matrix = np.zeros((len(sentences), len(sentences)))

        for this_sentence_index, this_sentence in enumerate(sentences):
            for another_sentence_index, another_sentence in enumerate(sentences):
                if this_sentence == another_sentence: #ignore if both are same sentences
                    continue
                similarity_matrix[this_sentence_index][another_sentence_index] = \
                    self.sentence_similarity(this_sentence, another_sentence, stop_words)

        return similarity_matrix

    # Construct the summarised text from the ranked sentences
    # pylint: disable=R0201
    def summarise_text(self, ranked_sentences, top_n_sentences):
        """
          Rank all the similar sentences based on
          their similarities and then create the
          summarised text from the ranked sentences.

          Parameters
          ==========
          ranked_sentences:
             a list of sentences ranked by their score (descending order)
          top_n_sentences:
             number of sentences to consider from the top of the list

          Return
          ======
          A list of top n sentences ranked by their score (descending order)
        """
        summarised_text = []

        if top_n_sentences > len(ranked_sentences):
            top_n_sentences = len(ranked_sentences)

        for index in range(top_n_sentences):
            summarised_text.append(" ".join(ranked_sentences[index][1]))

        summarised_text = ". ".join(summarised_text)

        return summarised_text

    # Sort sentences to surface top ranked ones from the similarity matrix
    # pylint: disable=R0201
    def sort_sentences_to_surface_top_ranked_sentences(self, scores, sentences):
        """
          Sort the sentences to bring the
          top ranked sentences to the surface

          Parameters
          ==========
          scores:
             scores of each of the sentences in the list of sentences
          sentences:
             a list of sentences

          Return
          ======
          a sorted list of sentences based on their scores (highest to lowest)
        """
        return sorted(((scores[index], sentence) \
            for index, sentence in enumerate(sentences)), reverse=True)

    # Rank the sentences usng networkx's pagerank() function
    def rank_sentences(self, sentence_similarity_martix):
        """
          Using networkx's pagerank rank the sentences,
          generating a graph and scores for each sentence

          Parameters
          ==========
          sentence_similarity_martix:
            a matrix of sentence similarity (cross sentences)

          Return
          ======
          a sentence similarity graph and scores of the sentences in descending order
        """
        sentence_similarity_graph = nx.from_numpy_array(sentence_similarity_martix)
        scores = nx.pagerank(sentence_similarity_graph)
        return sentence_similarity_graph, scores

    # Generate Summary Method
    def generate_summary(self, text, top_n_sentences):
        """
          Generate a summary by processing a text
          through various steps, returning the summarised text
          and a list of ranked sentences from which the
          summary was prepared

          Parameters
          ==========
          text:
            raw text to summarise, usually a long string of text made up of multiple sentences
          top_n_sentences:
            number of sentences to pick from the list of sentences to form the summary

          Return
          ======
          A list sentences that will form the summarised text (top n sentences)
        """

        # Step 1 - Read text and tokenize
        sentences = self.read_text(text)

        # Step 2 - Generate Similary Martix across sentences
        sentence_similarity_martix = self.build_similarity_matrix(sentences, STOP_WORDS)

        # Step 3 - Rank sentences in similarity martix
        # pylint: disable=W0612
        sentence_similarity_graph, scores = self.rank_sentences(sentence_similarity_martix)

        # Step 4 - Sort the rank and pick top sentences
        ranked_sentences = self.sort_sentences_to_surface_top_ranked_sentences(scores, sentences)

        # Step 5 - Construct the summarised text
        summarised_text = self.summarise_text(ranked_sentences, top_n_sentences)

        return summarised_text, ranked_sentences
