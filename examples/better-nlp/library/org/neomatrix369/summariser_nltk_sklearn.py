# Import all necessary libraries

from nltk.corpus import stopwords
import nltk

if len(punkt) == 0:
    nltk.download('punkt')
if len(wordnet) == 0:
    nltk.download('wordnet')

from nltk.tokenize import sent_tokenize, word_tokenize
from string import punctuation

import nltk
import string

from sklearn.feature_extraction.text import TfidfVectorizer
from nltk.stem.wordnet import WordNetLemmatizer

from collections import defaultdict
from heapq import nlargest
import operator


# Set stop-words
global stopwords
try:
    stopwords = set(stopwords.words('german') + stopwords.words('english') + list(punctuation))
    if len(stopwords) == 0:
        nltk.download('stopwords')
except LookupError:
    nltk.download('stopwords')

class SummariserNltkSklearn:


    def tokenize(self, text):
        tokens = nltk.word_tokenize(text)
        stems = []
        for item in tokens:
            stems.append(WordNetLemmatizer().lemmatize(item))
        return stems

    def generate_summary(self, text, top_n_sentences):
        # Create sentences
        sentences = sent_tokenize(text)

        tfidf = TfidfVectorizer(tokenizer=self.tokenize, 
                                stop_words=stopwords)
        tfs = tfidf.fit_transform([text])

        # Generate frequencies using TfIdf
        freqs = {}

        feature_names = tfidf.get_feature_names()
        for col in tfs.nonzero()[1]:
            freqs[feature_names[col]] = tfs[0, col]

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
        summarised_text=[]
        ctr=0
        for i in sorted(index_important_sentences):
            summarised_text.append(sentences[i])
            ctr=ctr+1
            if top_n_sentences == ctr:
                break

        return summarised_text, sorted_freqs