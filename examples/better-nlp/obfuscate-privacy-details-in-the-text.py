import spacy  # $ pip install spacy 
import time

def obfuscate(token, entityType="PERSON"):
	if token.string.strip() not in ['', '\n', '\t']:
	    if token.ent_iob != 0 and token.ent_type_ == entityType:
	        return "[OBFUSCATED] "
	    else:
	        return token.string
	else:
		return ''

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

for each_entity in parsed_generic_text.ents:
	each_entity.merge()

obfuscated_text = map(obfuscate, parsed_generic_text)
print("Obfuscated generic text: ", "".join(obfuscated_text))

endTime = time.time()

print("\n")
print("...Finished parsing\n")
print("Time taken to process the generic text: {} seconds".format(endTime-startTime))