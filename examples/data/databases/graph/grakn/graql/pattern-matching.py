#!/usr/bin/python
# -*- coding: utf-8 -*-

# supress warnings
import warnings

warnings.filterwarnings('ignore')

from fuzzywuzzy import fuzz
import pandas as pd
import sys
from pytictoc import TicToc

import importlib

queries = importlib.import_module("english-graql-queries")
main_queries_in_english = queries.main_queries_in_english
alternative_queries_in_english = queries.alternative_queries_in_english
graql_queries = queries.graql_queries

PICK_TOP_N = 5

DEBUG_PERF = False
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
    ["Very likely", 99, 100],  # Certain: 100%: Give or take 0%
    ### The General Area of Possibility
    ["Likely", 87, 99],  # Almost Certain: 93%: Give or take 6%
    ["Pretty likely", 63, 87],  # Probable: 75%: Give or take about 12%
    ["50-50 chance", 40, 63],  # Chances About Even: 50%: Give or take about 10%
    ["Pretty unlikely", 12, 40],  # Probably Not: 30%: Give or take about 10%
    ["Unlikely", 2, 12],  # Almost Certainly Not 7%: Give or take about 5%
    ["Very unlikely", 0, 2]  # Impossible 0%: Give or take 0%
]


def get_confidence_in_words(value):
    for each_slab in words_of_probability_estimation:
        if (value >= each_slab[1]) and (value <= each_slab[2]):
            return each_slab[0]


def add_result_to(results, query_code, query, query_asked):
    ratio = fuzz.partial_ratio(query, query_asked)
    confidence = get_confidence_in_words(ratio)
    results.append([query_code, query, ratio, confidence])
    return results


def get_potential_queries(query_asked):
    potential_queries = []
    for query_code in main_queries_in_english:
        for english_query in main_queries_in_english[query_code]:
            potential_queries = add_result_to(potential_queries, query_code, english_query, query_asked)

    for query_code in alternative_queries_in_english:
        for english_query in alternative_queries_in_english[query_code]:
            potential_queries = add_result_to(potential_queries, query_code, english_query, query_asked)
    return potential_queries


def print_formatted_results(dataframe):
    for index, row in dataframe.iterrows():
        print(f"q{index} {row['query_in_english']}")
        meta_info = f"| (Code: {row['query_code']} | Confidence: {row['confidence']}, {row['ratio']}%) |"
        print(meta_info)
        print("")


def get_filtered_responses(user_input):
    _tic("get_potential_queries()")
    potential_queries = get_potential_queries(user_input)
    _toc("get_potential_queries()")

    _tic("creating dataframe")
    results = pd.DataFrame(potential_queries, columns=['query_code', 'query_in_english',
                                                       'ratio', 'confidence'])
    results = results.sort_values(by=['ratio', 'query_code'], ascending=False)
    filter_greater_or_equal_to_70 = results['ratio'] > 70
    results_with_70_or_more_accuracy = results[filter_greater_or_equal_to_70]
    _toc("creating dataframe")

    _tic("filtering dataframe")
    if len(results_with_70_or_more_accuracy) == 0:
        filter_between_40_and_70 = (results['ratio'] >= 40) & (results['ratio'] <= 70)
        results_between_40_and_70 = results[filter_between_40_and_70]
        result = results_between_40_and_70[:PICK_TOP_N]
    else:
        result = results_with_70_or_more_accuracy[:PICK_TOP_N]

    result = result.reset_index()
    _toc("filtering dataframe")
    return result


if __name__ == "__main__":
    if (len(sys.argv) > 1):
        user_input = sys.argv[1]
        print(f"Query: {user_input}")
        _tic("filtering and printing dataframe")
        final_results = get_filtered_responses(user_input)
        pd.set_option('display.max_colwidth', -1)
        pd.set_option('display.max_columns', 3)
        print_formatted_results(final_results)
        _toc("filtering and printing dataframe")
    else:
        print("")
        print("Usage:")
        print(f"     python {sys.argv[0]} [query in quotes]")
        print("For example:")
        print(f"     python {sys.argv[0]} \"Show schema\"")
        print("")
        sys.exit(-1)
