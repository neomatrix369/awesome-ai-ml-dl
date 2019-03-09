from org.neomatrix369.better_nlp import BetterNLP

print("~~~~~~~ Started parsing...")

# Can be any factual text or any text to experiment with
generic_text = """Denis Guedj (1940 – April 24, 2010) was a French novelist and a professor of the History of Science at Paris VIII University. He was born in Setif. He spent many years devising courses and games to teach adults and children math. He is the author of Numbers: The Universal Language and of the novel The Parrot's Theorem. He died in Paris. """

target_topic = "Denis Guedj"
extracted_facts = BetterNLP().extract_facts(generic_text, target_topic)

print("Trying to gather details about " + target_topic)

number_of_facts_found = 0
for each_fact_statement in extracted_facts:
    number_of_facts_found =+ 1
    subject, verb, fact = each_fact_statement
    print(f" - {fact}")

if number_of_facts_found == 0:
    print("There were no facts on " + target_topic)

print("\n")
print("...Finished parsing ~~~~~~~\n")
