**Quantitative Measures for modeling Code-switching and Code-Mixing across corpora!** 💡  


Below work is the extension to the [introduction to code-mixing and code-switching](https://github.com/UmaGunturi/awesome-ai-ml-dl/blob/master/natural-language-processing/code-mixing.md), before starting to read this, it is recommended to read the previous part for better understanding of Code-Mixing!  

As described in [introduction to code-mixing and code-switching](https://github.com/UmaGunturi/awesome-ai-ml-dl/blob/master/natural-language-processing/code-mixing.md), in developing technologies for code-switched speech, it would be desirable to be able to predict the extent of the language mixing and the  regularity with which it might occur. Below are few metrics that allow for the classification and visualization of multilingual corpora according to the ratio of languages represented, the probability of switching between them etc. Applying these metrics to corpora of different languages and genres, we find that they display distinct probabilities and periodicities of switching. We should note that all of these measures are language-independent and can be used to compare corpora across language combinations.

⭐ **The Multilingual Index (M-index):**  
  
  
  It is developed from the Gini coefficient, is a word-count-based measure that quantifies the inequality of the distribution of language tags in a corpus of at least two languages. The M-index is calculated as follows:  

  ![m_index](https://github.com/UmaGunturi/awesome-ai-ml-dl/blob/master/natural-language-processing/formulae/m_index.png)  
  
  - where k (> 1) is the total number of languages represented in the corpus,  
  - Pj is the total number of words in the language j over the total number of words in the corpus,  
  - and j ranges over the languages present in the corpus.    
  

⭐ **CMI Index (Code-Mixing Index):**  
  
   ![cu_metric](https://github.com/UmaGunturi/awesome-ai-ml-dl/blob/master/natural-language-processing/formulae/cu_metric.png)   
   

  At the utterance level, this amounts to finding the most frequent language in the utterance and then counting the frequency of the words belonging to all other languages present. If an utterance x only contains language-independent tokens, its code-mixing is zero; for other utterances,the level of mixing depends on the fraction of language-dependent tokens that belong to the matrix language (the most frequent language in the utterance) and on N, the number of tokens in x except the language-independent ones (i.e., all tokens that belong to any language Li)  
  
⭐ **Language Entropy:**  


  The language entropy returns how many bits of information are needed to describe the distribution of language tags. Using the same conventions of notation as previously defined in M-Index, language entropy is calculated as:  
  
  ![lang_entropy](https://github.com/UmaGunturi/awesome-ai-ml-dl/blob/master/natural-language-processing/formulae/lang_entropy.png)  


⭐ **I-Index (Integration-Index):**    
  
  
  This metric describes the probability of switching within a text, it is simply a proportion of how many switch points exist relative to the number of language-dependent tokens in the corpus. In other words, it is the approximate probability that any given token in the corpus is a switch point. Given a corpus composed of tokens tagged by language {li} where j ranges from 1 to n, the size of the corpus, and i = j − 1, the I-index is calculated by the expression:  
  
   ![i_index](https://github.com/UmaGunturi/awesome-ai-ml-dl/blob/master/natural-language-processing/formulae/i_index.png)  
   
  
🌍 **Resources**  

❌Disclaimer: This list is not intended to be exhaustive, nor to cover every single topic in Code-Mixing and Code-Switching. There are plenty of amazing resources available and this is rather a pick of the most recent impactful works in the past few years/months mostly influenced by what I read. Here are a few picks for you:  

📌https://pdfs.semanticscholar.org/25a5/cf5c7dc2269cf67d98b2fb46317a4d16b581.pdf?_ga=2.55487915.165814036.1592417776-1121702791.1588953899    
📌https://amitavadas.com/Code-Mixing.html   
📌https://github.com/AtmaHou/Task-Oriented-Dialogue-Research-Progress-Survey  
📌https://symbiosiscollege.edu.in/assets/pdf/elearning/tyba/English/code-switching-2.pdf   
📌http://www.lrec-conf.org/proceedings/lrec2014/pdf/922_Paper.pdf  
📌https://www.aclweb.org/anthology/W18-3210.pdf    
📌https://arxiv.org/pdf/1810.00662.pdf   
 
  
  
