#
# Credits to GrakLabs for creating the original version
# Original version can be found at https://github.com/graknlabs/examples/tree/master/phone_calls/python/queries.py
#
# !/usr/bin/python
# -*- coding: utf-8 -*-

# supress warnings
import warnings

warnings.filterwarnings('ignore')

from random import randint
import os
import sys

import time
from grakn.client import GraknClient
from grakn.service.Session.util.ResponseReader import ConceptMap, Value

from colorama import Fore, Back, Style

import importlib

queries = importlib.import_module("english-graql-queries")
main_queries_in_english = queries.main_queries_in_english
alternative_queries_in_english = queries.alternative_queries_in_english
graql_queries = queries.graql_queries

pattern_matching = importlib.import_module("pattern-matching")

GRAQL_BOT = f"{Fore.GREEN}GraqlBot:{Style.RESET_ALL}"

# results from graql_query
GRAQL_QUERY = 0
RESPONSE_TEMPLATE = 1

keyspace_name = "phone_calls"

global connection_to_grakn_exists
connection_to_grakn_exists = False
client = None
session = None
transaction = None

results_cache = {}

error_message_decorators = [
    f"{GRAQL_BOT} Argh! We have an issue, but don't fret! It will end ups fine though, trust me!",
    f"{GRAQL_BOT} Oh no! Houston, we are not in Texas anymore!",
    f"{GRAQL_BOT} Cow patter! Now this is not so cool. But I will get through fine!",
    f"{GRAQL_BOT} Hallo, Hallo! Fawlty towers again!",
    f"{GRAQL_BOT} Not again! I just seal the problems, Oh well it's just an exception!",
]

took_time_messages = [
    f"{GRAQL_BOT} Even though it's been a long day, and I'm a bit lazy today!",
    f"{GRAQL_BOT} I could things faster if you like! I'm practising for the performance Olympics!",
    f"{GRAQL_BOT} Cow patter! Was I so slow? Could I have been faster?",
    f"{GRAQL_BOT} That's faster than Usain Bolt!",
    f"{GRAQL_BOT} Mo Farah couldn't do it as fast, could he now?",
]

could_not_find_input = [
    f"{GRAQL_BOT} Nice try, but we could find nothing! Do you want to try another query?",
    f"{GRAQL_BOT} Not sure what you meant by that one, not the end of the world. We can try again.",
    f"{GRAQL_BOT} Don't give up on me just cause I don't follow you. Keep trying till we perfect it!",
]

found_something_from_input = [
    f"{GRAQL_BOT} Not sure if I have the precise answer! But we found some we can go through together!",
    f"{GRAQL_BOT} Not which one you meant exactly! But we found others!",
    f"{GRAQL_BOT} Not a silver-bullet list of answers! Although there might be useful nuggets to consider!",
    f"{GRAQL_BOT} Not promising the moon but we do have some useful stuff on our end you know!"
]


def create_grakn_connection():
    global client, session, transaction, connection_to_grakn_exists

    if not connection_to_grakn_exists:
        print("(Connected to Grakn Server)")
        client = GraknClient(uri="localhost:48555")
        session = client.session(keyspace=keyspace_name)
        ## create a transaction to talk to the Grakn server
        transaction = session.transaction().read()
        connection_to_grakn_exists = True


def print_to_log(title, content):
    show_divider()
    print(f"{GRAQL_BOT}", title, content)
    show_divider()


def contains_type(iterator, type):
    for each in iterator:
        if isinstance(each, type):
            return True
    return False


def get_results(query):
    return transaction.query(query)


def execute_user_query(query_code, query_response):
    start_time = time.time()
    result = results_cache.get(query_code)
    retrieve_method = "real-time"
    if result:
        retrieve_method = "cache"
    else:
        graql_query = query_response[GRAQL_QUERY]
        if query_code == "HUMAN_GRAQL_QUERY":
            print(f"{GRAQL_BOT} Nice effort, looks like a well crafted query!")
        else:
            print(f"{GRAQL_BOT} Here's what the Graql query would look like if you typed it, neat isn't it?")
        print("")
        print(f"{Fore.CYAN}{graql_query}{Style.RESET_ALL}")
        print("")
        print(
            f"{GRAQL_BOT} Let me think, will take a moment, please be patient (talking to Highlander Grakn Server)...")

        iterator = get_results(graql_query)
        if contains_type(iterator, ConceptMap):
            iterator = get_results(graql_query)
            answers = iterator.collect_concepts()
            if hasattr(answers[0], 'value'):
                result = [answer.value() for answer in answers]
            else:
                print(f"{GRAQL_BOT} 😲 Schema found, 😩 we don't have the expertise to build it at "
                      f"the moment, your best bet it to use Graql Console or Workbase")
                return
        else:
            iterator = get_results(graql_query)
            if contains_type(iterator, Value):
                iterator = get_results(graql_query)
                first_answer = list(iterator)
                result = 0
                if len(first_answer) > 0:
                    result = first_answer[0].number()

        results_cache.update({query_code: []})
        results_cache[query_code] = result

    end_time = time.time()
    duration = end_time - start_time
    time_it_took_msg = f'{GRAQL_BOT} And it took me {Fore.YELLOW}{duration} seconds{Style.RESET_ALL} ' \
                       f'({retrieve_method}) to execute this query. '
    print_to_log(query_response[RESPONSE_TEMPLATE], result)
    print(time_it_took_msg)
    print(get_random_message(took_time_messages))

    return result


def get_random_message(messages):
    a_random_number = randint(0, len(messages) - 1)
    return messages[a_random_number]


def run_the_actual_graql_query(query_code, graql_query):
    results = execute_user_query(query_code, graql_query)
    print(f"{GRAQL_BOT} The above is based on your original input: '{user_input}'")
    return results


def process_user_input(user_input):
    create_grakn_connection()
    try:
        if "graql:" in user_input:
            print(f"{GRAQL_BOT} Wow, that's a great change, not many do that these days ;)")
            print(f"{GRAQL_BOT} Happy to execute it for you, if you think you have your graql-foo down")
            graql_query = user_input.replace("graql:", "").strip()
            graql_query_response = [graql_query, "Here's the output to your hand-written query:"]
            run_the_actual_graql_query("HUMAN_GRAQL_QUERY", graql_query_response)
        else:
            responses = pattern_matching.get_filtered_responses(user_input)
            rows_returned = responses.shape[0]  # 0=col count, 0=row count
            print("")
            if rows_returned == 1:
                print(f"{GRAQL_BOT} Yay! We found it (at least we think we did)! Going ahead and running it for you!")
                print(f"{GRAQL_BOT} Hope I'm not being too hasty!")
            elif rows_returned > 1:
                print(get_random_message(found_something_from_input))
                print("Here is our list:")
            else:
                print(get_random_message(could_not_find_input))
                return

            print()
            q_numbers = []
            for index, row in responses.iterrows():
                q_numbers.append(index)
                print(f"   q{Style.BRIGHT}{index}{Style.RESET_ALL}  --->  {row['query_in_english']}")
                meta_info = f"   Code: {Fore.BLUE}{Style.BRIGHT}{row['query_code']} {Style.RESET_ALL} | Confidence: " \
                            f"{Fore.GREEN}{row['confidence']}{Style.RESET_ALL}, " \
                            f"{Fore.GREEN}{row['ratio']}%{Style.RESET_ALL})"
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
            run_the_actual_graql_query(query_code, graql_query_response)
    except Exception as ex:
        global connection_to_grakn_exists
        connection_to_grakn_exists = False
        print("")
        print(get_random_message(error_message_decorators))
        print("")
        show_divider()
        print(f"{GRAQL_BOT} {Fore.RED}{Style.BRIGHT} Execution halted, due to an error:")
        print(ex)
        print(Style.RESET_ALL)
        show_divider()


def does_user_want_to_stop(user_input):
    if user_input.lower().strip() == "exit":
        print(f"{GRAQL_BOT} {Fore.YELLOW} Hastla vista! See you soon! {Style.RESET_ALL}")
        sys.exit(0)


def does_user_want_to_clear_screen(user_input):
    return user_input.lower().strip() == "cls" or user_input.lower().strip() == "clear"


def clear_screen():
    if sys.platform == "win32":
        os.system('cls')
    else:
        # Linux of OS X
        os.system('clear')


def show_divider():
    print(f"{Style.DIM}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
          f"~~~~~~~~~~~~~~~~~~~~{Style.RESET_ALL}")


if __name__ == "__main__":
    '''
      The code below:
      - creates a Grakn client > session > transaction connected to the phone_calls keyspace
      - runs a query based on the user's input
      - closes the session
    '''

    clear_screen()

    ## get user's question selection
    user_input = ""
    print(f"{GRAQL_BOT} {Fore.MAGENTA}Enter/paste your query in English or Graql.")
    print(f"And may the force be with us!{Style.RESET_ALL}")
    print('Type "exit" at the prompt to leave! "clear" to clear the screen.')
    while True:
        show_divider()
        print(f"{GRAQL_BOT} {Fore.MAGENTA}English or Graql >{Style.RESET_ALL}")
        user_input = input()
        user_input = user_input.replace("\t", " ")

        does_user_want_to_stop(user_input)
        if does_user_want_to_clear_screen(user_input):
            clear_screen()
        else:
            process_user_input(user_input)
