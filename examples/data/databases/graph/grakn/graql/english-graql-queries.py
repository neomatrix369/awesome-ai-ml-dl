#!/usr/bin/python
# -*- coding: utf-8 -*-

main_queries_in_english = {
    'SCHEMA': ['List the schema in this keyspace'],
    'CUSTOMERS_CALLED_SINCE': [
        'From 2018-09-10 onwards, which customers called the person with '
        'phone number +86 921 547 9004?'
    ],
    'CUSTOMERS_CALLED_SINCE': [
        'Since September 10th, which customers called the person with '
        'phone number +86 921 547 9004?'
    ],
    'CUSTOMERS_CALLED_SINCE': [
        'Get me the customers of company "Telecom" who called the target person with '
        'phone number +86 921 547 9004 from September 14th onwards.'
    ],
    'CUSTOMERS_CALLED_SINCE': [
        'Get me the customers of company "Telecom" who called the target person with '
        'phone number +86 921 547 9004 from September 10th onwards.'
    ],
    'OVER_50_PHONE_CALLS_CAMBRIDGE': [
        'Who are the people aged under 20 who have received at least one phone call from a '
        'Cambridge customer aged over 50?'
    ],
    'UNDER_20_PHONE_CALLS_LONDON': [
        'Who are the people who have received a call from a London customer aged over 50 who has '
        'previously called someone aged under 20?'
    ],
    'OVER_50_UNDER_20_PHONE_CALLS': [
        'Get me the phone number of people who have received a call from a customer aged '
        'over 50 after this customer (potential person) made a call to another customer '
        'aged under 20.'
    ],
    'COMMON_CUSTOMERS_SINGLE_NUMBER': [
        'Who are the customers who 1) have all called each other and 2) have all called '
        'person with phone number +48 894 777 5173 at least once?'],
    'COMMON_CUSTOMERS_MULTIPLE_NUMBERS': [
        'Who are the common contacts of customers with phone numbers '
        '+7 171 898 0853 and +370 351 224 5176?'
    ],
    'CALL_DURATION_COMPARISON': [
        'How does the average call duration among customers aged under 20 '
        'compare those aged over 40?'
    ],
    'CALL_DURATION_UNDER_20': ['How does the average call duration among customers aged under 20?'
                               ],
    'CALL_DURATION_OVER_40': ['How does the average call duration among customers aged over 40?'
                              ],
}

alternative_queries_in_english = {
    'SCHEMA': [
        'Show me the schema',
        'List the schema',
        'List schema keyspace',
        'What is the schema here',
        'What is the schema',
        'What is the schema here?',
        'What is the schema?',
        'Schema?',
        'Schema please',
    ],
    'CUSTOMERS_CALLED_SINCE': ['From a date onwards which customers called another person with '
                               'phone number'
        ,
                               'Since a date which customers called a person with phone number'
        ,
                               'Get customers of company Telecom who called target person with '
                               'phone number from a date onwards '
                               ],
    'OVER_50_PHONE_CALLS_CAMBRIDGE': ['People aged under certain age received at least one phone call from a place '
                                      'customer from customer aged over certain age '
        ,
                                      'Get phone number of people received calls from customer aged customer '
                                      'potential person who made calls to another customer aged under certain age '
                                      ],
    'UNDER_20_PHONE_CALLS_LONDON?': ['Who people received call from customer of certain place aged over certain age '
                                     'also called by someone aged under certain age '
        ,
                                     'Get phone number of people received calls from customer aged customer potential '
                                     'person who made calls to another customer aged under certain age '
                                     ],
    'COMMON_CUSTOMERS_MULTIPLE_NUMBERS': ['Who are common contacts of customers with certain phone numbers'
        ,
                                          'Get me the phone number of people who have received calls from both '
                                          'customer with phone number +7 171 898 0853 and customer with phone '
                                          'number +370 351 224 5176. '
                                          ],
    'COMMON_CUSTOMERS_SINGLE_NUMBER': ['Who are customers called other persons phone number least once'
        , "Who are customers who call one another's phone",
                                       'Customers who have called each other at least once',
                                       'Get phone number of people received calls from customer of certain age'
                                       ],
    'CALL_DURATION_COMPARISON': ['How average call duration among customers compared between ages?'
        , 'how long did the call last'],
    'CALL_DURATION_UNDER_20': ['How much time do customers under 20 spend time on a call on an average?'
                               ],
    'CALL_DURATION_OVER_40': ['How much time do customers over 40 spend time on a call on an average?'
                              ],
}


graql_queries = {
    'SCHEMA': ["""match $x sub thing; get;""",
               'The schema of the keyspace is as shown'],
    'CUSTOMERS_CALLED_SINCE': ["""
match
   $customer isa person, has phone-number $phone-number;
   $company isa company, has name "Telecom";
   (customer: $customer, provider: $company) isa contract;
   $target isa person, has phone-number "+86 921 547 9004";
   (caller: $customer, callee: $target) isa call, has started-at $started-at;
   $min-date == 2018-09-10T00:00:00; $started-at > $min-date;
get $phone-number;
        """, 'These are numbers of the customers who called '
             '+86 921 547 9004 since 2018-09-10T00:00:00 '
                               ],
    'UNDER_20_PHONE_CALLS_LONDON': ["""
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
get $phone-number;
    """,
                                    'Here are the phone numbers of the people (London calls)'
                                    ],
    'OVER_50_PHONE_CALLS_CAMBRIDGE': ["""
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
get $phone-number;
    """, 'Here are the phone numbers of the people (Cambridge calls)'
                                      ],
    'COMMON_CUSTOMERS_MULTIPLE_NUMBERS': ["""
match 
    $common-contact isa person, has phone-number $phone-number;
    $customer-a isa person, has phone-number "+7 171 898 0853";
    $customer-b isa person, has phone-number "+370 351 224 5176";
    (caller: $customer-a, callee: $common-contact) isa call;
    (caller: $customer-b, callee: $common-contact) isa call;
get $phone-number;
      """, 'Here are the numbers of the common customers'],
    'COMMON_CUSTOMERS_SINGLE_NUMBER': ["""
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
    """, 'The numbers of the customers who have called the single number are'
], 'CALL_DURATION_COMPARISON': [["""
match
    $customer isa person, has age < 20;
    $company isa company, has name "Telecom";
    (customer: $customer, provider: $company) isa contract;
    (caller: $customer, callee: $anyone) isa call, has duration $duration;
get $duration; 
mean $duration;
        """,'The average call duration between customers have been (in seconds)'
],
["""
match
  $customer isa person, has age > 40;
  $company isa company, has name "Telecom";
  (customer: $customer, provider: $company) isa contract;
  (caller: $customer, callee: $anyone) isa call, has duration $duration;
get $duration; 
mean $duration;
        """,'The average call duration between customers have been (in seconds)'
]],
    'CALL_DURATION_UNDER_20': ["""
match
    $customer isa person, has age < 20;
    $company isa company, has name "Telecom";
    (customer: $customer, provider: $company) isa contract;
    (caller: $customer, callee: $anyone) isa call, has duration $duration;
get $duration; 
mean $duration;
        """,
                               'The average call duration between customers have been (in seconds)'
                               ],
    'CALL_DURATION_OVER_40': ["""
match
  $customer isa person, has age > 40;
  $company isa company, has name "Telecom";
  (customer: $customer, provider: $company) isa contract;
  (caller: $customer, callee: $anyone) isa call, has duration $duration;
get $duration; 
mean $duration;
        """,
                              'The average call duration between customers have been (in seconds)'
                              ],
}
