#!/usr/bin/python
# -*- coding: utf-8 -*-

from fuzzywuzzy import fuzz
import pandas as pd

import importlib
queries=importlib.import_module("english-graql-queries")
main_queries_in_english = queries.main_queries_in_english

print('Iterating through schema queries')
comparison_results = []
for each_query in main_queries_in_english:
    print(f'Question/command: {each_query}')
    
for each_similarity in main_queries_in_english[each_query]:
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
