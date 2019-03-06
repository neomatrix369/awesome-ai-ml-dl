import spacy  # $ pip install spacy 
import time

print("Started parsing...")

startTime = time.time()
# Ensure you do the below two steps before loading the English NLP Model:
#
# 	$ python3 -m spacy download en_core_web_lg
# 	$ python3 -m spacy link en_core_web_lg en
#
nlpModel = 'en_core_web_lg'
print("Loading model {}...".format(nlpModel))
english_nlp_model = spacy.load(nlpModel)
endTime = time.time()
print("Time taken to load the {} model: {} seconds\n".format(nlpModel, endTime-startTime))

startTime = time.time()
# Can be any factual text or any text to experiment with
generic_text = """Denis Guedj (1940 – April 24, 2010) was a French novelist and 
a professor of the History of Science at Paris VIII University. He was born 
in Setif. He spent many years devising courses and games to teach adults 
and children math. He is the author of Numbers: The Universal Language and 
of the novel The Parrot's Theorem. He died in Paris. 
"""

parsed_generic_text = english_nlp_model(generic_text)

token_types_legend = ['GPE = ', 'FAC = ', 'DATE = calendar date', 
                      'NORP = Noun or Pronoun', 
                      'PERSON = name of a person (proper noun)', 
                      'ORG = Organisation']

[print(f"{each_entity.text} ({each_entity.label_})") for each_entity in parsed_generic_text.ents if each_entity.text.strip() == each_entity.text]

print("\nToken types legend: ", token_types_legend)
endTime = time.time()

print("\n")
print("...Finished parsing\n")
print("Time taken to process the generic text: {} seconds".format(endTime-startTime))