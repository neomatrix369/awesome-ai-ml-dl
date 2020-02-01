#
# Credits to GrakLabs for creating the original version
# Original version can be found at https://github.com/graknlabs/examples/tree/master/phone_calls/python/queries.py
#
# coding=utf-8
from grakn.client import GraknClient

def print_to_log(title, content):
    print("~~~~~~~~~~~~~~~~~~\n")
    print(title)
    print(content)
    print("~~~~~~~~~~~~~~~~~~\n")

def execute_user_query(user_input, transaction):
    iterator = transaction.query(user_input[1])
    answers = iterator.collect_concepts()
    result = [answer.value() for answer in answers]

    print_to_log(user_input[2], result)

    return result

def random_error_decorator_messages():
    from random import randint
    messages = [
        "Argh! We have an issue, but don't fret! It end ups up well",
        "Oh no! Houton, we are not in Texas anymore!",
        "Cow patter! Now this is not so cool. But I will get through fine!",
        "Hallo, Hallo! Fawlty towers again!",
        "Not again! I just seal the problems, Oh well it's just an exception!",
    ]

    a_random_number = randint(0, len(messages))
    return messages[a_random_number]

graql_queries = [
    [ "SCHEMA",
      "match $x sub thing; get;",
      "The schema of the keyspace is as shown" 
    ],
    [
        "CUSTOMERS_CALLED_SINCE",
        """
            match
               $customer isa person, has phone-number $phone-number;
               $company isa company, has name "Telecom";
               (customer: $customer, provider: $company) isa contract;
               $target isa person, has phone-number "+86 921 547 9004";
               (caller: $customer, callee: $target) isa call, has started-at $started-at;
               $min-date == 2018-09-10T00:00:00; $started-at > $min-date;
               get $phone-number;
        """, 
        "These are numbers of the customers who called +86 921 547 9004 since 2018-09-10T00:00:00"
    ],
    [
    "OVER_50_PHONE_CALLS_CAMBRIDGE",
    """
     match
        $potential_caller isa person, has city "London", has age > 50;
        $company isa company, has name "Telecom";
          (customer: $potential_caller, provider: $company) isa contract;
          $pattern-callee isa person, has age < 20;
          (caller: $potential_caller, callee: $pattern-callee) isa call, has started-at $pattern-call-date;
          $target isa person, has phone-number $phone-number;
          not { (customer: $target, provider: $company) isa contract; };
          (caller: $potential_caller, callee: $target) isa call, has started-at $target-call-date;
          $target-call-date > $pattern-call-date;
        get $phone-number
    """,
    "Here are the phone numbers of the people (London calls)"
    ],
    [
    "UNDER_20_PHONE_CALLS_LONDON",
"""
      match
        $potential_caller isa person, has city "Cambridge", has age > 50;
        $company isa company, has name "Telecom";
          (customer: $potential_caller, provider: $company) isa contract;
          $pattern-callee isa person, has age < 20;
          (caller: $potential_caller, callee: $pattern-callee) isa call, has started-at $pattern-call-date;
          $target isa person, has phone-number $phone-number;
          not { (customer: $target, provider: $company) isa contract; };
          (caller: $potential_caller, callee: $target) isa call, has started-at $target-call-date;
          $target-call-date > $pattern-call-date;
        get $phone-number
""",
"Here are the phone numbers of the people (Cambridge calls)"
    ],    
    [
"COMMON_CUSTOMERS_MULTIPLE_NUMBERS",
"""
 match 
          $common-contact isa person, has phone-number $phone-number;
          $customer-a isa person, has phone-number "+7 171 898 0853";
          $customer-b isa person, has phone-number "+370 351 224 5176";
          (caller: $customer-a, callee: $common-contact) isa call;
          (caller: $customer-b, callee: $common-contact) isa call;
        get $phone-number;
""",
"Here are the numbers of the common customers"
    ],
[
"COMMON_CUSTOMERS_SINGLE_NUMBER",
"""
 match 
          $target isa person, has phone-number "+48 894 777 5173";
          $company isa company, has name "Telecom";
          $customer-a isa person, has phone-number $phone-number-a;
          (customer: $customer-a, provider: $company) isa contract;
          (caller: $customer-a, callee: $target) isa call;
          $customer-b isa person, has phone-number $phone-number-b;
          (customer: $customer-b, provider: $company) isa contract;
          (caller: $customer-b, callee: $target) isa call;
          (caller: $customer-a, callee: $customer-b) isa call;
        get $phone-number-a, $phone-number-b;
""",
"The customers who have called the single number are"
],
]

def process_user_input(user_input):
    print("Let me think, will take a moment, please be patient...")
    try:    
        execute_user_query(graql_queries[0], transaction)
    except Exception as ex:
        print("")
        print(random_error_decorator_messages())
        print("Execution halted, due to an error:")
        print(ex)
        print("")


if __name__ == "__main__":

    '''
      The code below:
      - creates a Grakn client > session > transaction connected to the phone_calls keyspace
      - runs a query based on the user's input
      - closes the session
    '''

    keyspace_name = "phone_calls"
    client = GraknClient(uri="localhost:48555")
    session = client.session(keyspace=keyspace_name)
    ## create a transaction to talk to the Grakn server
    transaction = session.transaction().read()
    cache = {}

    ## get user's question selection
    user_input = ""
    while True:
        print("")
        print("Enter/paste your query in English or Graql, Ctrl-D or Ctrl-Z ( windows ) to save it! (Let the force be with us!)")    
        user_input = input()
        user_input = user_input.replace("\t", " ")
        if user_input.lower().strip() == "exit":
            print("Hastla vista! See you soon!")
            break
        process_user_input(user_input)