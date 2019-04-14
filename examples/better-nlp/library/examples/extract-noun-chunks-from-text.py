import sys
sys.path.insert(0, '..')

from org.neomatrix369.better_nlp import BetterNLP

betterNLP = BetterNLP()

model = betterNLP.load_nlp_model()
model = model["model"]

print("~~~~~ Started parsing...")

# Can be any factual text or any text to experiment with
generic_text = """Denis Guedj (1940 – April 24, 2010) was a French novelist and a professor of the History of Science 
at Paris VIII University. He was born in Setif. He spent many years devising courses and games to teach adults and children math. 
He is the author of Numbers: The Universal Language and of the novel The Parrot's Theorem. He died in Paris. """

chunks = betterNLP.extract_noun_chunks(model, generic_text)
chunks = chunks["noun_chunks"]

chunks = chunks.get("noun_chunks")
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
betterNLP.pretty_print(chunks)
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("\n")
print("...Finished parsing ~~~~~~\n")