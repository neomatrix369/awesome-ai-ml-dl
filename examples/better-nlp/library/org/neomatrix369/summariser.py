# Import all necessary libraries

from nltk.corpus import stopwords
from nltk.cluster.util import cosine_distance
import numpy as np
import networkx as nx
import nltk as nltk

nltk.download('stopwords')


class Summariser:

    # Generate clean sentences
    def read_text(self, text):
        split_text = text.split(". ")

        sentences = []

        for sentence in split_text:
            sentences.append(sentence.replace("[^a-zA-Z]", " ").split(" "))
        
        sentences.pop()
        
        return sentences

    # Are the two sentences similar function?
    def sentence_similarity(self, firstSentence, secondSentence, stopwords=None):
        if stopwords is None:
            stopwords = []
     
        firstSentence = [word.lower() for word in firstSentence]
        secondSentence = [word.lower() for word in secondSentence]
     
        all_words = list(set(firstSentence + secondSentence))
     
        firstVector = [0] * len(all_words)
        secondVector = [0] * len(all_words)
     
        # build the vector for the first sentence
        for word in firstSentence:
            if word in stopwords:
                continue
            firstVector[all_words.index(word)] += 1
     
        # build the vector for the second sentence
        for word in secondSentence:
            if word in stopwords:
                continue
            secondVector[all_words.index(word)] += 1
     
        return 1 - cosine_distance(firstVector, secondVector)

    # Similarity matrix
    def build_similarity_matrix(self, sentences, stop_words):
        # Create an empty similarity matrix
        similarity_matrix = np.zeros((len(sentences), len(sentences)))
     
        for thisSentence in range(len(sentences)):
            for anotherSentence in range(len(sentences)):
                if thisSentence == anotherSentence: #ignore if both are same sentences
                    continue 
                similarity_matrix[thisSentence][anotherSentence] = self.sentence_similarity(sentences[thisSentence], sentences[anotherSentence], stop_words)

        return similarity_matrix

    # Generate Summary Method
    def generate_summary(self, text, top_sentences):
        stop_words = stopwords.words('english')
        summarise_text = []

        # Step 1 - Read text and tokenize
        sentences = self.read_text(text)

        # Step 2 - Generate Similary Martix across sentences
        sentence_similarity_martix = self.build_similarity_matrix(sentences, stop_words)

        # Step 3 - Rank sentences in similarity martix
        sentence_similarity_graph = nx.from_numpy_array(sentence_similarity_martix)
        scores = nx.pagerank(sentence_similarity_graph)

        # Step 4 - Sort the rank and pick top sentences
        ranked_sentence = sorted(((scores[i], s) for i, s in enumerate(sentences)), reverse=True)

        for i in range(top_sentences):
            summarise_text.append(" ".join(ranked_sentence[i][1]))

        # Step 5 - Return the summarised text
        return ". ".join(summarise_text), ranked_sentence