from org.neomatrix369.better_nlp import BetterNLP

print("Started parsing...")

# Can be any factual text or any text to experiment with
generic_text = """Denis Guedj (1940 – April 24, 2010) was a French novelist and 
a professor of the History of Science at Paris VIII University. He was born 
in Setif. He spent many years devising courses and games to teach adults 
and children math. He is the author of Numbers: The Universal Language and 
of the novel The Parrot's Theorem. He died in Paris. 
"""

obfuscated_text = BetterNLP().obfuscate_text(generic_text)

print("Obfuscated generic text: ", "".join(obfuscated_text))
print("...Finished parsing\n")

