from fuzzywuzzy import fuzz
import pandas as pd

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
    'Who are customers called other persons phone number least'
  ],

  'Get me the phone number of people who have received calls from both customer with phone number +7 171 898 0853 and customer with phone number +370 351 224 5176.': [
    'Get phone number of people received calls from customer of certain age'
  ],

  'How does the average call duration among customers aged under 20 compare those aged over 40?': [
    'How average call duration among customers aged compare aged'
  ],
}

print('Iterating through schema queries')
comparison_results = []
for each_query in schema_queries_in_english:
    print(f'Question/command: {each_query}')
for each_similarity in schema_queries_in_english[each_query]:
    ratio = fuzz.ratio(each_query, each_similarity)
partial_ratio = fuzz.partial_ratio(each_query, each_similarity)
token_sort_ratio = fuzz.token_sort_ratio(each_query, each_similarity)
comparison_results.append([each_query, each_similarity, ratio, partial_ratio, token_sort_ratio])

print('Publishing results')
results = pd.DataFrame(comparison_results, columns = ['each_query', 'each_similarity', 'ratio', 'partial_ratio', 'token_sort_ratio'])
print(results)
print()
print(results.describe())
print()
ratio_results = results.sort_values(by = 'ratio', ascending = False)
print(ratio_results)
print()
transposed_results = ratio_results.drop('each_query', axis = 1).transpose()
print(transposed_results)
results_partial_ratio = ratio_results.sort_values(by = 'partial_ratio', ascending = False)
transposed_results = results_partial_ratio.drop('each_query', axis = 1).transpose()
print(transposed_results)
print()
token_sort_ratio = ratio_results.sort_values(by = 'token_sort_ratio', ascending = False)
transposed_results = token_sort_ratio.drop('each_query', axis = 1).transpose()
print(transposed_results)