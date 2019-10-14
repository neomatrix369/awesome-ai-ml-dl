"""
BetterNLP is a wrapper program/library that encapsulates a couple
of NLP libraries that are popular among the AI and ML communities.

Summarisation method: TF-IDF
Credits: to the author of
https://towardsdatascience.com/understand-text-summarization-and-create-your-own-summarizer-in-python-b26a9f09fc70
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
from string import punctuation
from collections import defaultdict
from heapq import nlargest
import operator

print("This version of Python is {} bits.".format(8 * struct.calcsize("P")))

# pylint: disable=C0413
import nltk
from nltk.corpus import stopwords
from nltk.tokenize import sent_tokenize, word_tokenize
from nltk.stem.wordnet import WordNetLemmatizer
nltk.download('punkt')
nltk.download('wordnet')
from sklearn.feature_extraction.text import TfidfVectorizer

# Set stop-words
STOP_WORDS = None
try:
    STOP_WORDS = set(stopwords.words('german') + stopwords.words('english') + list(punctuation))
    if not STOP_WORDS:
        nltk.download('stopwords')
except LookupError:
    nltk.download('stopwords')

class SummariserTFIDF:
    """
        Summarise text using the TF-IDF method, using
        the Nltk and Sklearn libraries
    """

    # pylint: disable=R0201
    def tokenize(self, text):
        """
          Tokenise the text passed in using nltk
          Return the list of stems of the words in
          the sentences in the text

          Parameters
          ==========
          text:
            raw text to summarise, usually a long string of text made up of multiple sentences

          Return
          ======
          A list of tokens (word stems) from the original text.
        """
        tokens = nltk.word_tokenize(text)
        stems = []
        for item in tokens:
            stems.append(WordNetLemmatizer().lemmatize(item))
        return stems

    def get_frequencies(self, text):
        """
          Generate frequencies of the words
          in the text using the TF-IDF method.

          Parameters
          ==========
          text:
            raw text to summarise, usually a long string of text made up of multiple sentences

          Return
          ======
          A dictionary of frequencies of the stem words in the text
        """
        tfidf = TfidfVectorizer(tokenizer=self.tokenize,
                                stop_words=STOP_WORDS)
        tfs = tfidf.fit_transform([text])

        # Generate frequencies using TfIdf
        freqs = {}
        feature_names = tfidf.get_feature_names()
        for col in tfs.nonzero()[1]:
            freqs[feature_names[col]] = tfs[0, col]

        return freqs

    def generate_summary(self, text, top_n_sentences):
        """
          Create a summary from the text, based on the
          top n sentences in the text.
          Top n sentences are determined by using the
          TF-IDF method.

          Parameters
          ==========
          text:
            raw text to summarise, usually a long string of text made up of multiple sentences
          top_n_sentence:
            number of top sentences to pick from to form the summary

          Return
          ======
          A list of sentences to form the summary text and also a
          list of sorted frequencies of the stem words from the text
        """
        freqs = self.get_frequencies(text)

        # Create sentences
        sentences = sent_tokenize(text)
        important_sentences = defaultdict(int)
        for i, sentence in enumerate(sentences):
            for token in word_tokenize(sentence.lower()):
                if token in freqs:
                    important_sentences[i] += freqs[token]

        # Choose 20% of the text to show
        number_sentences = int(len(sentences) * 0.2)

        # Create an index with the most important sentences
        index_important_sentences = nlargest(number_sentences,
                                             important_sentences,
                                             important_sentences.get)

        # Sort frequencies
        sorted_freqs = sorted(freqs.items(), key=operator.itemgetter(1), reverse=True)

        # Create summary
        summarised_text = []
        ctr = 0
        for i in sorted(index_important_sentences):
            summarised_text.append(sentences[i])
            ctr = ctr + 1
            if top_n_sentences == ctr:
                break

        return summarised_text, sorted_freqs
