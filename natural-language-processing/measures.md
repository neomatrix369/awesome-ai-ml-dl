**Quantitative Measures for modeling Code-switching and Code-Mixing across corpora!**

* **The Multilingual Index (M-index):**  
  
  
  It is developed from the Gini coefficient, is a word-count-based measure that quantifies the inequality of the distribution of language tags in a corpus of at least two languages. The M-index is calculated as follows:  

  
  
  - where k (> 1) is the total number of languages represented in the corpus,  
  - Pj is the total number of words in the language j over the total number of words in the corpus,  
  - and j ranges over the languages present in the corpus.    
  

* **CMI Index (Code-Mixing Index):**  
  
  
  At the utterance level, this amounts to finding the most frequent language in the utterance and then counting the frequency of the words belonging to all other languages present. If an utterance x only contains language-independent tokens, its code-mixing is zero; for other utterances,the level of mixing depends on the fraction of language-dependent tokens that belong to the matrix language (the most frequent language in the utterance) and on N, the number of tokens in x except the language-independent ones (i.e., all tokens that belong to any language Li)  
  
* **Language Entropy:**  


  The language entropy returns how many bits of information are needed to describe the distribution of language tags. Using the same conventions of notation as previously defined in M-Index, language entropy is calculated as:  



* **I-Index (Integration-Index):**    
  
  
  This metric describes the probability of switching within a text, it is simply a proportion of how many switch points exist relative to the number of language-dependent tokens in the corpus. In other words, it is the approximate probability that any given token in the corpus is a switch point. Given a corpus composed of tokens tagged by language {li} where j ranges from 1 to n, the size of the corpus, and i = j − 1, the I-index is calculated by the expression:   
  
  
