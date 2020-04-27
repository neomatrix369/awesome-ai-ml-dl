print('Loading nltk libraries, please wait...')
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize 
print('Finished loading nltk libraries.')

import importlib
queries=importlib.import_module("english-graql-queries")

main_queries_in_english = queries.main_queries_in_english

stop_words = set(stopwords.words('english'))

punctuations = '''!()[]{};:'"\,<>./?@#$%^&*_~+“”'''; ### excluding - (hypen / dash)
new_schema_queries=[] 
for each_query in main_queries_in_english:
    new_query = each_query
    for each_char in each_query:
       if each_char in punctuations:
         new_query = new_query.replace(each_char, "");
    new_schema_queries.append(new_query)

main_queries_in_english=new_schema_queries

print(f'~~~ Tokenising schema queries (queries: {len(main_queries_in_english)})')
for each_query in main_queries_in_english:
    query_tokens = word_tokenize(each_query)
    query_without_stop_words = []
    for query_token in query_tokens:
        if (not query_token in stop_words) and (not query_token.isnumeric()):
           query_without_stop_words.append(query_token)
    print(f'{each_query}: {query_without_stop_words}')
