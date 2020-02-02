#
# Credits to GrakLabs for creating the original version
# Original version can be found at https://github.com/graknlabs/examples/tree/master/phone_calls/python/queries.py
#
#!/usr/bin/python
# -*- coding: utf-8 -*-

# supress warnings
import warnings
warnings.filterwarnings('ignore')

from random import randint            
import sys
    
import time
from grakn.client import GraknClient

from colorama import Fore, Back, Style

import importlib
queries = importlib.import_module("english-graql-queries")
main_queries_in_english = queries.main_queries_in_english
alternative_queries_in_english=queries.alternative_queries_in_english
graql_queries = queries.graql_queries

pattern_matching=importlib.import_module("pattern-matching")


GRAQL_BOT = f"{Fore.GREEN}GraqlBot:{Style.RESET_ALL}"

# results from graql_query
GRAQL_QUERY=0
RESPONSE_TEMPLATE=1

keyspace_name = "phone_calls"

client = None
session = None
transaction = None

error_message_decorators = [
    f"{GRAQL_BOT} Argh! We have an issue, but don't fret! It end ups up well",
    f"{GRAQL_BOT} Oh no! Houston, we are not in Texas anymore!",
    f"{GRAQL_BOT} Cow patter! Now this is not so cool. But I will get through fine!",
    f"{GRAQL_BOT} Hallo, Hallo! Fawlty towers again!",
    f"{GRAQL_BOT} Not again! I just seal the problems, Oh well it's just an exception!",
]

took_time_messages = [
    f"{GRAQL_BOT} Even though it's been a long day, and I'm a bit lazy today!",
    f"{GRAQL_BOT} I could things faster if you like! I'm practising for the performance Olympics",
    f"{GRAQL_BOT} Cow patter! Was I so slow? Could I have been faster",
    f"{GRAQL_BOT} Thats faster than Usain Bolt",\
    f"{GRAQL_BOT} Mo Farah couldn't do it as fast could he now?",
]

def create_grakn_connection():
    global client, session, transaction

    client = GraknClient(uri="localhost:48555")
    session = client.session(keyspace=keyspace_name)
    ## create a transaction to talk to the Grakn server
    transaction = session.transaction().read()

def print_to_log(title, content):
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
    print(f"{GRAQL_BOT}",title)
    print(content)
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")

def execute_user_query(query_code, query_response, transaction):
    start_time = time.time()
    result = results_cache.get(query_code)
    retrieve_method = "real-time"
    if result:
        retrieve_method = "cache"
    else:
        graql_query = query_response[GRAQL_QUERY]
        print(f"{GRAQL_BOT} Here's what the Graql query would look like if you typed it, neat isn't it?")
        print(f"{Fore.CYAN}{graql_query}{Style.RESET_ALL}")
        print("")
        print(f"{GRAQL_BOT} Let me think, will take a moment, please be patient...")
        iterator = transaction.query(graql_query)
        answers = iterator.collect_concepts()
        result = [answer.value() for answer in answers]
        results_cache.update({query_code: []})
        results_cache[query_code] = result
        
    end_time = time.time()
    duration = end_time - start_time
    time_it_took_msg = f'{GRAQL_BOT} And it took me {Fore.YELLOW}{duration} seconds{Style.RESET_ALL} ({retrieve_method}) to execute this query.'
    print_to_log(query_response[RESPONSE_TEMPLATE], result)
    print(time_it_took_msg)
    print(get_random_message(took_time_messages))

    return result

def get_random_message(messages):
    a_random_number = randint(0, len(messages) - 1)
    return messages[a_random_number]

def process_user_input(user_input):
    try:
        responses = pattern_matching.get_filtered_responses(user_input)
        rows_returned = responses.shape[0] # 0=col count, 0=row count
        print("")
        if rows_returned == 1:
            print(f"{GRAQL_BOT} Yay! We found it (at least we think we did)!")
        elif rows_returned > 1:
            print(f"{GRAQL_BOT} Not sure which one you meant! But we found others!")
        else:
            print(f"{GRAQL_BOT} Nice try, but we could find nothing! Do you want to try another query?")
            return

        print()
        q_numbers = []
        for index, row in responses.iterrows():
            q_numbers.append(index)
            print(f"   {Style.BRIGHT}{index}{Style.RESET_ALL}  --->  {row['query_in_english']}")
            meta_info = f"   Code: {Fore.BLUE}{Style.BRIGHT}{row['query_code']} {Style.RESET_ALL} | Confidence: {Fore.GREEN}{row['confidence']}{Style.RESET_ALL}, {Fore.GREEN}{row['ratio']}%{Style.RESET_ALL})"
            print(meta_info)
            print("")

        if rows_returned > 1: 
            print(f"{GRAQL_BOT} Which one of these did you mean, just type the q number?")
            print(f"{GRAQL_BOT} one of these: {q_numbers}")
            q_number_entered = input()
            q_number_entered = q_number_entered.replace("\t", " ").lower()
        else:
            q_number_entered = q_numbers[0]

        q_number_entered = int(q_number_entered)
        query_code = responses['query_code'][q_number_entered]
        graql_query_response = graql_queries.get(query_code)
        execute_user_query(query_code, graql_query_response, transaction)
        print(f"{GRAQL_BOT} The above is based on your original input: '{user_input}'")
    except Exception as ex:
        print("")
        print(get_random_message(error_message_decorators))
        print("")
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        print(f"{GRAQL_BOT} {Fore.RED} Execution halted, due to an error:")
        print(ex)
        print(Style.RESET_ALL)
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        create_grakn_connection()

def does_user_want_to_stop(user_input):
    if user_input.lower().strip() == "exit":
        print(f"{GRAQL_BOT} {Fore.YELLOW} Hastla vista! See you soon! {Style.RESET_ALL}")
        sys.exit(0)

if __name__ == "__main__":

    '''
      The code below:
      - creates a Grakn client > session > transaction connected to the phone_calls keyspace
      - runs a query based on the user's input
      - closes the session
    '''

    create_grakn_connection()

    results_cache = {}

    ## get user's question selection
    user_input = ""
    print(f"{GRAQL_BOT} {Fore.MAGENTA}Enter/paste your query in English or Graql, exit to leave the prompt! (Let the force be with us!){Style.RESET_ALL}")
    while True:
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        print(f"{GRAQL_BOT} {Fore.MAGENTA}English or Graql >{Style.RESET_ALL}")
        user_input = input()
        user_input = user_input.replace("\t", " ")

        does_user_want_to_stop(user_input)

        process_user_input(user_input)