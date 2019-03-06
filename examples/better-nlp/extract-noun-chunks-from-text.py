import spacy           # $ pip install spacy 
import time

MINIMUM_OCCURENCE_FREQUENCY = 1
MINIMUM_NUM_OF_WORDS = 1

print("Started parsing...")

startTime = time.time()
import textacy.extract # $ pip install textacy

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
generic_text = """Denis Guedj (1940 – April 24, 2010) was a French novelist and a professor of the History of Science at Paris VIII University. He was born in Setif. He spent many years devising courses and games to teach adults and children math. He is the author of Numbers: The Universal Language and of the novel The Parrot's Theorem. He died in Paris. """

parsed_generic_text = english_nlp_model(generic_text)

extracted_noun_chunks = textacy.extract.noun_chunks(parsed_generic_text, min_freq=MINIMUM_OCCURENCE_FREQUENCY)
extracted_noun_chunks = map(str, extracted_noun_chunks)
extracted_noun_chunks = map(str.lower, extracted_noun_chunks)

set_of_noun_chunks = set(extracted_noun_chunks)
if len(set_of_noun_chunks) == 0:
	print("Did not find words that belong together.")
else:	
	print("A list of words that belong together (in lowercase):")

[print(each_noun_chunk) for each_noun_chunk in set_of_noun_chunks if len(each_noun_chunk.split(" ")) > MINIMUM_NUM_OF_WORDS]

endTime = time.time()

print("\n")
print("...Finished parsing\n")
print("Time taken to process the generic text: {} seconds".format(endTime-startTime))