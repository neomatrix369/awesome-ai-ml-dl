from org.neomatrix369.better_nlp import BetterNLP

print("~~~~~ Started parsing...")

# Can be any factual text or any text to experiment with
generic_text = """Denis Guedj (1940 – April 24, 2010) was a French novelist and a professor of the History of Science at Paris VIII University. He was born in Setif. He spent many years devising courses and games to teach adults and children math. He is the author of Numbers: The Universal Language and of the novel The Parrot's Theorem. He died in Paris. """

chunks = BetterNLP().extract_nouns_chunks(generic_text)

print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
set_of_noun_chunks = set(chunks)
if len(set_of_noun_chunks) == 0:
	print("Did not find words that belong together.")
else:
	print("A list of words that belong together (in lowercase):")

[print(each_noun_chunk) for each_noun_chunk in set_of_noun_chunks if len(each_noun_chunk.split(" ")) > BetterNLP.minimum_occurrence_frequency]
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")

print("\n")
print("...Finished parsing ~~~~~~\n")

