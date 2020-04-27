# English-to-Graql

A list of English phrases or questions mapped to respective Graql queries.

## Query 1

### English

Can I see the schema?
List the schema in this keyspace
Show me the schema
List the schema
What is the schema here
Schema?
Schema please

### Graql

	match $x sub thing; get; offset 0; limit 30

## Query 2

### English

From 2018-09-10 onwards, which customers called the person with phone number +86 921 547 9004?

or

Since September 10th, which customers called the person with phone number +86 921 547 9004?

### Graql

		match
		  $customer isa person, has phone-number $phone-number;
		  $company isa company, has name "Telecom";
		  (customer: $customer, provider: $company) isa contract;
		  $target isa person, has phone-number "+86 921 547 9004";
		  (caller: $customer, callee: $target) isa call, has started-at $started-at;
		  $min-date == 2018-09-10T00:00:00; $started-at > $min-date;
		get $phone-number;

### English

Get me the customers of company “Telecom” who called the target person with phone number +86 921 547 9004 from September 14th onwards.

### Graql

        match
          $customer isa person, has phone-number $phone-number;
          $company isa company, has name "Telecom";
          (customer: $customer, provider: $company) isa contract;
          $target isa person, has phone-number "+86 921 547 9004";
          (caller: $customer, callee: $target) isa call, has started-at $started-at;
          $min-date == 2018-09-14T00:00:00; $started-at > $min-date;
        get $phone-number;

## Query 3

### English

Who are the people aged under 20 who have received at least one phone call from a Cambridge customer aged over 50?

### Graql

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

## Query 4

### English

Who are the people who have received a call from a London customer aged over 50 who has previously called someone aged under 20?

or 

Get me the phone number of people who have received a call from a customer aged over 50 after this customer (potential person) made a call to another customer aged under 20.

### Graql

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

## Query 5

### English

Who are the common contacts of customers with phone numbers +7 171 898 0853 and +370 351 224 5176?

### Graql

        match 
          $common-contact isa person, has phone-number $phone-number;
          $customer-a isa person, has phone-number "+7 171 898 0853";
          $customer-b isa person, has phone-number "+370 351 224 5176";
          (caller: $customer-a, callee: $common-contact) isa call;
          (caller: $customer-b, callee: $common-contact) isa call;
        get $phone-number;

## Query 6

### English

Who are the customers who 1) have all called each other and 2) have all called person with phone number +48 894 777 5173 at least once?

or

Get me the phone number of people who have received calls from both customer with phone number +7 171 898 0853 and customer with phone number +370 351 224 5176.

### Graql

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

## Query 7

### English

How does the average call duration among customers aged under 20 compare those aged over 40? (not for graphing, only aggregate calls), splits into query a) and b).

a) Get me the average call duration among customers who have a contract with company “Telecom” and are aged under 20.

### Graql

        match
          $customer isa person, has age < 20;
          $company isa company, has name "Telecom";
          (customer: $customer, provider: $company) isa contract;
          (caller: $customer, callee: $anyone) isa call, has duration $duration;
        get $duration; mean $duration;

b) Get me the average call duration among customers who have a contract with company “Telecom” and are aged over 40.

### Graql

        match
          $customer isa person, has age > 40;
          $company isa company, has name "Telecom";
          (customer: $customer, provider: $company) isa contract;
          (caller: $customer, callee: $anyone) isa call, has duration $duration;
        get $duration; mean $duration;

---

[back to README](../README.md)