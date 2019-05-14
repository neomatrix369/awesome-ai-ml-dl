import pytextrank
import sys
import networkx as nx
import pylab as plt


class SummariserPyTextRank:

    def generate_summary(self, text_file, top_n_sentences):
        path_stage1 = "o1.json"

        # Stage 1: Perform statistical parsing/tagging on a document in JSON format
        with open(path_stage1, 'w') as f:
            for graf in pytextrank.parse_doc(pytextrank.json_iter(text_file)):
                f.write("%s\n" % pytextrank.pretty_print(graf._asdict()))
                
        # Stage 2: Collect and normalize the key phrases from a parsed document
        path_stage1 = "o1.json"
        path_stage2 = "o2.json"

        graph, ranks = pytextrank.text_rank(path_stage1)
        pytextrank.render_ranks(graph, ranks)

        with open(path_stage2, 'w') as f:
            for rl in pytextrank.normalize_key_phrases(path_stage1, ranks):
                f.write("%s\n" % pytextrank.pretty_print(rl._asdict()))

        # Stage 3: Calculate a significance weight for each sentence, using MinHash to approximate a Jaccard distance from key phrases determined by TextRank
        path_stage1 = "o1.json"
        path_stage2 = "o2.json"
        path_stage3 = "o3.json"

        kernel = pytextrank.rank_kernel(path_stage2)

        with open(path_stage3, 'w') as f:
            for sentence in pytextrank.top_sentences(kernel, path_stage1):
                f.write(pytextrank.pretty_print(sentence._asdict()))
                f.write("\n")

        # Stage 4: Summarize a document based on most significant sentences and key phrases
        path_stage2 = "o2.json"
        path_stage3 = "o3.json"

        key_phrases = ", ".join(set([p for p in pytextrank.limit_keyphrases(path_stage2, phrase_limit=12)]))
        sentence_iterator = sorted(pytextrank.limit_sentences(path_stage3, word_limit=150), key=lambda x: x[1])
        sentences = []

        for sentence_text, idx in sentence_iterator:
            sentences.append(pytextrank.make_sentence(sentence_text))

        summarised_text = " ".join(sentences)

        return summarised_text, key_phrases, graph

    def show_graph(self, graph):
        nx.draw(graph, with_labels=True) 
        plt.show()