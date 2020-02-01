print('Loading nltk libraries, please wait...')
import nltk
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize 
print('Finished loading nltk libraries.')

stop_words = set(stopwords.words('english'))

schema_queries = {
	'List the schema in this keyspace',
	'From 2018-09-10 onwards, which customers called the person with phone number +86 921 547 9004?',
	'Since September 10th, which customers called the person with phone number +86 921 547 9004?',
	'Get me the customers of company “Telecom” who called the target person with phone number +86 921 547 9004 from September 14th onwards.',
	'Get me the customers of company “Telecom” who called the target person with phone number +86 921 547 9004 from September 10th onwards.',
	'Who are the people aged under 20 who have received at least one phone call from a Cambridge customer aged over 50?',
	'Who are the people who have received a call from a London customer aged over 50 who has previously called someone aged under 20?',
	'Get me the phone number of people who have received a call from a customer aged over 50 after this customer (potential person) made a call to another customer aged under 20.',
	'Who are the common contacts of customers with phone numbers +7 171 898 0853 and +370 351 224 5176?',
	'Who are the customers who 1) have all called each other and 2) have all called person with phone number +48 894 777 5173 at least once?',
	'Get me the phone number of people who have received calls from both customer with phone number +7 171 898 0853 and customer with phone number +370 351 224 5176.',
	'How does the average call duration among customers aged under 20 compare those aged over 40?',
}

punctuations = '''!()[]{};:'"\,<>./?@#$%^&*_~+“”'''; ### excluding - (hypen / dash)
new_schema_queries=[] 
for each_query in schema_queries:
    new_query = each_query
    for each_char in each_query:
       if each_char in punctuations:
         new_query = new_query.replace(each_char, "");
    new_schema_queries.append(new_query)

schema_queries=new_schema_queries

print(f'~~~ Tokenising schema queries (queries: {len(schema_queries)})')
for each_query in schema_queries:
    query_tokens = word_tokenize(each_query)
    query_without_stop_words = []
    for query_token in query_tokens:
        if (not query_token in stop_words) and (not query_token.isnumeric()):
           query_without_stop_words.append(query_token)
    print(f'{each_query}: {query_without_stop_words}')