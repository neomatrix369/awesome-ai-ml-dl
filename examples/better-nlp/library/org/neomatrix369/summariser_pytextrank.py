import pytextrank
import sys
import networkx as nx
import pylab as plt


class SummariserPyTextRank:

    def perform_statistical_parsing_tagging(self, text_file, paragraph_output):
        with open(paragraph_output, 'w') as f:
            for paragraph in pytextrank.parse_doc(pytextrank.json_iter(text_file)):
                f.write("%s\n" % pytextrank.pretty_print(paragraph._asdict()))

    def collect_and_normalise_key_phrases(self, paragraph_output, key_phrases_output):
        graph, token_ranks = pytextrank.text_rank(paragraph_output)
        pytextrank.render_ranks(graph, token_ranks)

        with open(key_phrases_output, 'w') as f:
            for relationship in pytextrank.normalize_key_phrases(paragraph_output, token_ranks):
                f.write("%s\n" % pytextrank.pretty_print(relationship._asdict()))

        return graph, token_ranks

    def calculate_sentence_significance(self, paragraph_output, key_phrases_output, top_sentences_output, top_n_sentences):
        kernel = pytextrank.rank_kernel(key_phrases_output)

        with open(top_sentences_output, 'w') as f:
            counter = 0 
            for sentence in pytextrank.top_sentences(kernel, paragraph_output):
                if counter < top_n_sentences:
                    f.write(pytextrank.pretty_print(sentence._asdict()))
                    f.write("\n")
                else:
                    return

                counter = counter + 1

    def summarise_text(self, key_phrases_output, top_sentences_output):
        key_phrases = ", ".join(set([phrase for phrase in pytextrank.limit_keyphrases(key_phrases_output, phrase_limit=12)]))
        sentence_iterator = sorted(pytextrank.limit_sentences(top_sentences_output, word_limit=150), key=lambda x: x[1])
        sentences = []

        for sentence_text, idx in sentence_iterator:
            sentences.append(pytextrank.make_sentence(sentence_text))

        return " ".join(sentences), key_phrases

    def generate_summary(self, text_file, top_n_sentences):
        paragraph_output = "paragraph_output.json"
        key_phrases_output = "key_phrases_output.json"
        top_sentences_output = "top_sentences_output.json"

        # Stage 1: Perform statistical parsing/tagging on a document in JSON format
        self.perform_statistical_parsing_tagging(text_file, paragraph_output)

        # Stage 2: Collect and normalize the key phrases from a parsed document
        graph, token_ranks = self.collect_and_normalise_key_phrases(paragraph_output, key_phrases_output)

        # Stage 3: Calculate a significance weight for each sentence, using MinHash to approximate a Jaccard distance from key phrases determined by TextRank
        self.calculate_sentence_significance(paragraph_output, key_phrases_output, top_sentences_output, top_n_sentences)

        # Stage 4: Summarize a document based on most significant sentences and key phrases
        summarised_text, key_phrases = self.summarise_text(key_phrases_output, top_sentences_output)

        return summarised_text, token_ranks, key_phrases, graph

    def show_graph(self, graph):
        nx.draw(graph, with_labels=True) 
        plt.show()