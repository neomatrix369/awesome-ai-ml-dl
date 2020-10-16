**Named Entity Recognition** 🤔

Considering recent increases in computing power and decreases in the costs of data storage, data scientists and developers can build large knowledge bases that contain millions of entities and hundreds of millions of facts about them. These knowledge bases are key contributors to intelligent computer behavior. Surprisingly, Named Entity Recognition operates at the back of many popular technologies such as smart assistants (Siri, Google Now), machine reading, and deep interpretation of natural language. This post gives you a brief introduction to Named Entity Recognition and uses cases related.

**1. Introduction**  


NER is an information extraction technique to identify and classify named entities in text. In detail, it’s a process where an algorithm takes a string of text (sentence or paragraph) as input and identifies relevant nouns (mainly people, places, and organizations…) that are mentioned in that string. NER has a wide variety of use cases in the business like, when you are writing an email and mention time or attaching a file, Gmail offers to set a calendar notification or remind you to attach the file in case you are sending the email without an attachment. Other applications of NER include: extracting important named entities from legal, financial, and medical documents, classifying content for news providers, improving the search algorithms, and etc. 

**1.1 Language**  

NER research works are not just in English. But there are also many other kinds of research talking about problems in other languages, for example, German, Spain, Dutch, Japanese, Chinese, Arabic and many more languages ​​that have occurred in the last 15 years.  


**1.2 Entity Types**  

Text formats can be news, science, official, informal or domain topics like sports, business, finance, etc..
Most studies are conducted in 3 major categories: “persons”, “locations” and “organization”. But there are many other categories listed below in use.  

📌 “Locations” can be divided into many different parts, such as city, state, country.  
📌 “Persons” may be divided according to their occupation. That is the name of People in whatever profession, such as politician, entertainer  
📌 “Timex” is the type of “time” and “date”  
📌 “Numex”  
📌 “Money”  
📌 “Percent”  

**2. NER Methods** 

**2.1 Classical Approaches:** ⭐ 

Mostly rule-based. For further read, follow this [video](https://www.youtube.com/watch?v=LFXsG7fueyk) by Sentdex that uses the NLTK package in python for NER.  

**2.2 Machine Learning Approaches:** ⭐

There are two main methods in this category:  

**A-** Multi-class classification Task where named entities are our labels so we can apply different classification algorithms. The problem here is that identifying and labeling named entities require a thorough understanding of the context of a sentence and sequence of the word labels in it, which this method ignores that.  
**B-** Another method in this category is the Conditional Random Field (CRF) model. It is a probabilistic graphical model that can be used to model sequential data such as labels of words in a sentence. The CRF model can catch the features of the present and past names in an arrangement however it can’t comprehend the setting of the forward labels; this shortcoming plus the extra feature engineering involved with training a CRF model makes it less appealing to be adopted by the industry.  


**2.3 Deep Learning Approaches:**  ⭐

Before discussing details about Deep Learning approaches (state-of-the-art) to NER, we need to analyze proper and clear metrics to evaluate the performance of our models. Generally, we use accuracy while training a neural network in different epochs as an evaluation metric. However, in the case of NER, we might be dealing with important financial, medical, or legal documents and accurate identification of named entities in those documents determines the success of the model. In other words, false positives and false negatives have a business cost in a NER task. Therefore, our principal metric to evaluate our models will be the F1 score because we need a balance between precision and recall.  

**3 Evaluation Metrics of NER**  

**3.1 CoNLL: Computational Natural Language Learning**  

“Precision is the percentage of named entities found by the learning model that is correct. Recall is the percentage of named entities present in the corpus that are found by the model. A named entity is correct only if it is an exact match of the corresponding entity in the data file.”  
The Language-Independent Named Entity Recognition task introduced at CoNLL-2003 measures the performance of the systems in terms of precision, recall, and f1-score.  


**3.2 Automatic Content Extraction (ACE)**  

The ACE challenges use a more complex evaluation metric which includes a weighting schema, Check References for deeper understanding.
Replicating experiments and baselines from ACE are a little complex since all the datasets and results are not open and free, so I guess this challenge results and experiments will fade away with time.  

**3.4 Message Understanding Conference (MUC)**  

The MUC-5 Scoring System is evaluation software that aligns and scores the templates produced by the information extraction systems under evaluation in comparison to an "answer key" created by humans . The Scoring System produces comprehensive summary reports showing the overall scores for the templates in the test set ; these may be supplemented by detailed score reports showing scores for each template individually. To understand the scoring categories, see [this](https://www.aclweb.org/anthology/M93-1007.pdf)

Below is a summary table with meaning of each scoring category!
![scoring](https://github.com/neomatrix369/awesome-ai-ml-dl/blob/master/natural-language-processing/formulae/scoring.png)


**4 Use Cases of NER**  

**4.1 Classification and Detection of Fake News**  

News and publishing houses generate large amounts of online content on a daily basis and managing them correctly is very important to get the most use of each article. Named Entity Recognition can automatically investigate entire articles and expose which are the major people, organizations, and places discussed in them. Knowing the relevant tags for each article helps in automatically classifying the articles in defined hierarchies and enable smooth content discovery.

**4.2 Efficient Search Algorithms**  

Let’s suppose you are intending to design an internal search algorithm for an online publisher that has millions of articles. If for every search query the algo ends up searching all the words in millions of articles, the process will take hell lot of time! Instead, if NER can be run once on all the articles and the relevant entities (tags) associated with each of those articles are stored separately, this could speed up the search process incredibly! With this approach, a search term will be matched with only the small list of entities discussed in each article leading to faster search execution.

**4.3 Customer Support**  

There are a number of ways to make the process of customer feedback procedure smooth and easy by using NER. Let’s take an example to understand the process. If you are handling the customer support department of an electronic store with multiple branches worldwide, you go through a number mentions in your customers’ feedback. 

**5 Conclusion**  

Named Entity Recognition has been developing continuously for over 15 years. The novel use is to extract different types of information (name, date, time, location) from the text. In addition, there are more than 20 languages and more than 200 types of entities. Most researches are interested in specific information on topic types such as news articles, web page information, etc...This provides an overview of techniques for creating a NERC system, from manual rule-based assignments to providing good and accurate results. But it comes with the time it takes to set the rules like, Supervised learning requires a large corpus that has been labeled, Semi-supervised and unsupervised learning allows for rapid recognition of entities without having to have a large labeled corpus.

**References:**  
📌 To know more about NER Deep learning approaches - Refer to https://www.depends-on-the-definition.com/introduction-named-entity-recognition-python/  
📌 More details about LSTMs can be found [here](http://colah.github.io/posts/2015-08-Understanding-LSTMs/)
📌 An implementation of the MUC evaluation metrics can be found:
* https://github.com/jantrienes/nereval
* [“Automatic Content Extraction 2008 Evaluation Plan (ACE08)”](http://www.eng.utah.edu/~cs6961/papers/ACE-2008-description.pdf)
* [“The Automatic Content Extraction (ACE) Program Tasks, Data, and Evaluation”](https://pdfs.semanticscholar.org/0617/dd6924df7a3491c299772b70e90507b195dc.pdf) 
* http://www.aclweb.org/anthology/M93-1007  


📌 Useful wrapper program/libraries:  **Better NLP** Find about the library [here](https://github.com/neomatrix369/awesome-ai-ml-dl/tree/master/examples/better-nlp)  

📌 Other NLP libraries out there:   
* StanfordNLP  
* Vowpal Wabbit  
* Pytext  



