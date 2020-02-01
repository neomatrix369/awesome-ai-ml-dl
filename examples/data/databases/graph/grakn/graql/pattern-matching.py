from fuzzywuzzy import fuzz
import pandas as pd
import sys
from pytictoc import TicToc

DEBUG_PERF=False
if DEBUG_PERF:
	timer = TicToc()

def _tic(name=""):
	if DEBUG_PERF:
	    print(f'--- {name}: ', end='')
	    timer.tic()

def _toc(name=""):
	if DEBUG_PERF:
	    print(f'--- {name}: ', end='')
	    timer.toc() 

### See https://en.wikipedia.org/wiki/Words_of_estimative_probability
words_of_probability_estimation = [
	["Very likely",         99, 100],    #           Certain: 100%: Give or take 0%
	### The General Area of Possibility 
	["Likely",              87,  99],    #     Almost Certain: 93%: Give or take 6%
	["Pretty likely",       63,  87],    #           Probable: 75%: Give or take about 12%
    ["50-50 chance",        40,  63],    # Chances About Even: 50%: Give or take about 10%
    ["Pretty unlikely",     12,  40],    #       Probably Not: 30%: Give or take about 10%
    ["Unlikely",             2,  12],    # Almost Certainly Not 7%: Give or take about 5%
    ["Very unlikely",        0,   2]     #           Impossible 0%: Give or take 0%
]

schema_queries_in_english = {
  'List the schema in this keyspace': [
    'Show me the schema',
    'List the schema',
    'List schema keyspace',
    'What is the schema here',
    'What is the schema',
    'What is the schema here?',
    'What is the schema?',
    'Schema?',
    'Schema please'
  ],

  'From 2018-09-10 onwards, which customers called the person with phone number +86 921 547 9004?': [
    'From a date onwards which customers called another person with phone number'
  ],
  'Since September 10th, which customers called the person with phone number +86 921 547 9004?': [
    'Since a date which customers called a person with phone number'
   ],

  'Get me the customers of company “Telecom” who called the target person with phone number +86 921 547 9004 from September 14th onwards.': [
    'Get customers of company Telecom who called target person with phone number from a date onwards'
  ],

  'Get me the customers of company “Telecom” who called the target person with phone number +86 921 547 9004 from September 10th onwards.': [
    'Get customers of company Telecom who called target person with phone number from a date onwards'
  ],

  'Who are the people aged under 20 who have received at least one phone call from a Cambridge customer aged over 50?': [
    'People aged under certain age received at least one phone call from a place customer from customer aged over certain age'
  ],

  'Who are the people who have received a call from a London customer aged over 50 who has previously called someone aged under 20?': [
    'Who people received call from customer of certain place aged over certain age also called by someone aged under certain age'
  ],

  'Get me the phone number of people who have received a call from a customer aged over 50 after this customer (potential person) made a call to another customer aged under 20.': [
    'Get phone number of people received calls from customer aged customer potential person who made calls to another customer aged under certain age'
  ],

  'Who are the common contacts of customers with phone numbers +7 171 898 0853 and +370 351 224 5176?': [
    'Who are common contacts of customers with certain phone numbers'
  ],

  'Who are the customers who 1) have all called each other and 2) have all called person with phone number +48 894 777 5173 at least once?': [
    'Who are customers called other persons phone number least once',
    'Who are customers one another phone',
    "called atleast once"
  ],

  'Get me the phone number of people who have received calls from both customer with phone number +7 171 898 0853 and customer with phone number +370 351 224 5176.': [
    'Get phone number of people received calls from customer of certain age'
  ],

  'How does the average call duration among customers aged under 20 compare those aged over 40?': [
    'How average call duration among customers aged compare aged',
    "how long did the call last"
  ],
}

def get_confidence_in_words(value):
	for each_slab in words_of_probability_estimation:
		if (value >= each_slab[1]) and (value <= each_slab[2]):
			return each_slab[0]

def add_result_to(results, query, query_asked):
	ratio = fuzz.partial_ratio(query, query_asked)
	confidence = get_confidence_in_words(ratio)
	results.append([query, ratio, confidence])
	return results

def get_potential_queries(query_asked):
	potential_queries = []
	for schema_query in schema_queries_in_english:
		potential_queries = add_result_to(potential_queries, schema_query, query_asked)
		for similar_query in schema_queries_in_english[schema_query]:
			potential_queries = add_result_to(potential_queries, similar_query, query_asked)
	return potential_queries

def print_formatted_results(dataframe):
	for index, row in dataframe.iterrows():
		print(f"{row['query_in_english']} (Confidence: {row['confidence']}, {row['ratio']}%)")

if (len(sys.argv) > 1):
	print(f"Query: {sys.argv[1]}")
	_tic("get_potential_queries()")
	potential_queries = get_potential_queries(sys.argv[1])
	_toc("get_potential_queries()")

	_tic("creating dataframe")
	results = pd.DataFrame(potential_queries, columns = ['query_in_english', 'ratio', 'confidence'])
	results = results.sort_values(by=['ratio'], ascending=False)
	filter_greater_or_equal_to_70 = results['ratio'] > 70
	results_with_70_or_more_accuracy = results[filter_greater_or_equal_to_70]
	_toc("creating dataframe")
	pd.set_option('display.max_colwidth', -1)
	pd.set_option('display.max_columns', 3)
	SHOW_COUNT = 5
	_tic("filtering and printing dataframe")
	if len(results_with_70_or_more_accuracy) == 0: 
		filter_between_40_and_70 = (results['ratio'] >= 40) & (results['ratio'] <= 70)
		results_between_40_and_70 = results[filter_between_40_and_70]
		print_formatted_results(results_between_40_and_70[:SHOW_COUNT])
	else:
		print_formatted_results(results_with_70_or_more_accuracy[:SHOW_COUNT])
	_toc("filtering and printing dataframe")
else:
	print("")
	print("Usage:")
	print(f"     python {sys.argv[0]} [query in quotes]")
	print("For example:")
	print(f"     python {sys.argv[0]} \"Show schema\"")
	print("")
	sys.exit(-1)