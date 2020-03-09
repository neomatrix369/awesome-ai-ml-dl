"""
BetterNLP is a wrapper program/library that encapsulates a couple
of NLP libraries that are popular among the AI and ML communities.

Summarisation method: PyTextRank or Vertex ranking algorithm summarisation technique
Credits to the author of
https://medium.com/@aneesha/beyond-bag-of-words-using-pytextrank-to-find-phrases-and-summarize-text-f736fa3773c5
(Notebook: https://github.com/DerwenAI/pytextrank/blob/master/example.ipynb)

Another resource to take a look at
https://www.analyticsvidhya.com/blog/2018/11/introduction-text-summarization-textrank-python/
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
import networkx as nx
import pylab as plt
# Although pylint complains about not being able to import pytextrank
# which has been the cases but doing the above resolves it and we are
# able to import the package - sort of false positive
# pylint: disable=E0401
import pytextrank

import os

class SummariserPyTextRank:
    """
        Summarise text using the PyTextRank library
    """

    # pylint: disable=R0201
    def perform_statistical_parsing_tagging(self, text_file, paragraph_output):
        """
            Perform statistical parsing and tagging of
            sentences in the text (aka JSON document)

            Parameters
            ==========
            text_file:
               file containing the input text (as JSON) to perform
               statistical parsing and tagging on
            paragraph_output:
               output file into which the results are written (as a JSON file)

            Return
            ======
            Nothing, writes results to a text file (as JSON)
        """
        with open(paragraph_output, 'w') as temp_file:
            for paragraph in pytextrank.parse_doc(pytextrank.json_iter(text_file)):
                temp_file.write("%s\n" % pytextrank.pretty_print(paragraph._asdict()))

    # pylint: disable=R0201
    def collect_and_normalise_key_phrases(self, paragraph_output, key_phrases_output):
        """
            Collect and normalise key phrases from the sentences in
            the paragraph (in the JSON doc)
            Rank them using PyTextRank, return a graph and ranked tokens

            Parameters
            ==========
            paragraph_output:
               tagged and parsed JSON document as text file
            key_phrases_output:
               output text file (JSON) into which key phrases are stored

            Return
            ======
            Returns a graph (object) and ranked tokens (dictionary)
        """

        graph, token_ranks = pytextrank.text_rank(paragraph_output)
        pytextrank.render_ranks(graph, token_ranks)

        with open(key_phrases_output, 'w') as temp_file:
            for relationship in pytextrank.normalize_key_phrases(paragraph_output, token_ranks):
                temp_file.write("%s\n" % pytextrank.pretty_print(relationship._asdict()))

        return graph, token_ranks

    # pylint: disable=R0201
    def calculate_sentence_significance(self, paragraph_output, key_phrases_output, \
                                        top_sentences_output, top_n_sentences):
        """
            Calculate the significance of each sentence based on the ranking.
            Ranking is determined by the top n sentences (filter)

            Parameters
            ==========
            paragraph_output:
               tagged and parsed JSON document as text file
            key_phrases_output:
               text file (JSON) into which key phrases are stored
            top_sentences_output:
                text file (JSON) into which top scored sentences are written
            top_n_sentences:
               top n sentences to return based on scores

            Return
            ======
            Nothing, writes top n sentences into a text file (JSON) by the
            name specified in top_sentences_output
        """

        kernel = pytextrank.rank_kernel(key_phrases_output)

        with open(top_sentences_output, 'w') as temp_file:
            counter = 0
            for sentence in pytextrank.top_sentences(kernel, paragraph_output):
                if counter < top_n_sentences:
                    temp_file.write(pytextrank.pretty_print(sentence._asdict()))
                    temp_file.write("\n")
                else:
                    return

                counter = counter + 1

    # pylint: disable=R0201
    def summarise_text(self, key_phrases_output, top_sentences_output):
        """
            Summarise the text filtered by the top n sentences count.
            Put summary sentences together along with the key phrases
            which helped to determine the summary sentences.

            Parameters
            ==========
            key_phrases_output:
               text file (JSON) into which key phrases are stored
            top_sentences_output:
               text file (JSON) into which top scored sentences are written

            Return
            ======
            Nothing, writes top n sentences into a text file (JSON)
            by the name specified in top_sentences_output
        """

        phrases = pytextrank.limit_keyphrases(key_phrases_output, phrase_limit=12)
        key_phrases = ", ".join([phrase for phrase in phrases])

        sentence_iterator = sorted(pytextrank.limit_sentences( \
                 top_sentences_output, word_limit=150), key=lambda x: x[1])
        sentences = []
        for sentence_text in sentence_iterator:
            sentences.append(pytextrank.make_sentence(sentence_text[0]))

        return " ".join(sentences), key_phrases

    # pylint: disable=R0201
    def generate_summary(self, text_file, top_n_sentences):
        """
            Generate a summarise filtered by the top n sentences count.
            Performing the steps from ranking the sentences to selecting
            and putting them together based on the significance.
            Significance is determined by the key phrases in each sentence.

            Return a summarised text, ranked tokens, key phrases in sentence,
            and a graph showing how the tokens are related.

            Parameters
            ==========
            text_file
                text file (JSON) containing the source text (sentences)
            top_n_sentences:
                top n sentences (numeric)

            Return
            ======
            Returns dictionaries containing summarised text, token ranks,
            key phrases, and an object containing the graph
        """
        working_directory = os.path.dirname(text_file)
        if not working_directory:
            working_directory = os.path.abspath(os.path.curdir)
            text_file = os.path.join(working_directory, text_file)

        paragraph_output = os.path.join(working_directory, "paragraph_output.json")
        key_phrases_output = os.path.join(working_directory, "key_phrases_output.json")
        top_sentences_output = os.path.join(working_directory, "top_sentences_output.json")

        # Stage 1: Perform statistical parsing/tagging on a document in JSON format
        self.perform_statistical_parsing_tagging(text_file, paragraph_output)

        # Stage 2: Collect and normalize the key phrases from a parsed document
        graph, token_ranks = self.collect_and_normalise_key_phrases( \
                                        paragraph_output, key_phrases_output)

        # Stage 3: Calculate a significance weight for each sentence,
        # using MinHash to approximate a Jaccard distance from key phrases
        # determined by TextRank
        self.calculate_sentence_significance(paragraph_output, \
                   key_phrases_output, top_sentences_output, top_n_sentences)

        # Stage 4: Summarize a document based on most significant sentences and key phrases
        summarised_text, key_phrases = self.summarise_text( \
                   key_phrases_output, top_sentences_output)

        return summarised_text, token_ranks, key_phrases, graph

    # pylint: disable=R0201
    def show_graph(self, graph):
        """
            Draw a networkx graph from the graph vector generated by pytextrank
            by ranking the tokens (based on key phrases)

            Parameters
            ==========
            graph:
                graph object to draw on the console

            Return
            ======
            the graph object is drawn on the console
        """

        nx.draw(graph, with_labels=True)
        plt.show()
