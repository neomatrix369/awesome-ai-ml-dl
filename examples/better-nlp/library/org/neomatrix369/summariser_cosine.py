# Import all necessary libraries

from nltk.corpus import stopwords
from nltk.cluster.util import cosine_distance
import numpy as np
import networkx as nx
import nltk as nltk

nltk.download('stopwords')


class SummariserCosine:

    # Generate clean sentences
    def read_text(self, text):
        split_text = text.split(". ")

        sentences = []

        for sentence in split_text:
            sentences.append(sentence.replace("[^a-zA-Z]", " ").split(" "))
        
        sentences.pop()
        
        return sentences

    def extract_vector(self, sentence, all_words, stopwords):
        extracted_vector = [0] * len(all_words)

        # build the vector for the sentence
        for word in sentence:
            if word in stopwords:
                continue
            extracted_vector[all_words.index(word)] += 1

        return extracted_vector

    # Are the two sentences similar function?
    def sentence_similarity(self, firstSentence, secondSentence, stopwords=None):
        if stopwords is None:
            stopwords = []

        firstSentence = [word.lower() for word in firstSentence]
        secondSentence = [word.lower() for word in secondSentence]
     
        all_words = list(set(firstSentence + secondSentence))

        firstVector = self.extract_vector(firstSentence, all_words, stopwords)
        secondVector = self.extract_vector(secondSentence, all_words, stopwords)

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

    # Construct the summarised text from the ranked sentences
    def summarise_text(self, ranked_sentences, top_n_sentences):
        summarised_text = []

        if top_n_sentences > len(ranked_sentences):
           top_n_sentences = len(ranked_sentences)

        for index in range(top_n_sentences):
            summarised_text.append(" ".join(ranked_sentences[index][1]))
        
        summarised_text = ". ".join(summarised_text)

        return summarised_text

    # Pick top ranked sentences from the similarity matrix
    def pick_top_ranked_sentences(self, scores, sentences):
        return sorted(((scores[index], sentence) for index,sentence in enumerate(sentences)), reverse=True)

    # Rank the sentences usng networkx's pagerank() function
    def rank_sentences(self, sentence_similarity_martix):
        sentence_similarity_graph = nx.from_numpy_array(sentence_similarity_martix)
        scores = nx.pagerank(sentence_similarity_graph)
        return sentence_similarity_graph, scores

    # Generate Summary Method
    def generate_summary(self, text, top_n_sentences):
        stop_words = stopwords.words('english')

        # Step 1 - Read text and tokenize
        sentences = self.read_text(text)

        # Step 2 - Generate Similary Martix across sentences
        sentence_similarity_martix = self.build_similarity_matrix(sentences, stop_words)

        # Step 3 - Rank sentences in similarity martix
        sentence_similarity_graph, scores = self.rank_sentences(sentence_similarity_martix)

        # Step 4 - Sort the rank and pick top sentences
        ranked_sentences = self.pick_top_ranked_sentences(scores, sentences)

        # Step 5 - Construct the summarised text
        summarised_text = self.summarise_text(ranked_sentences, top_n_sentences)

        return summarised_text, ranked_sentences