# Graql-to-English

The reverse of English-to-Graql Graql queries mapping to a list of English phrases or questions.

Let's see how they turn out!

## Query 1

### Graql

	match $x sub thing; get; offset 0; limit 30

### English (literal)

Find all items that inherits from thing (super class type), assign it the variable by the notation `$x` and bring back the first 30 items of the result.

### English (created by human)

Can I see the schema?
List the schema in this keyspace
Show me the schema
List the schema
What is the schema here
Schema?
Schema please


## Query 2

### Graql

		match
		  $customer isa person, has phone-number $phone-number;
		  $company isa company, has name "Telecom";
		  (customer: $customer, provider: $company) isa contract;
		  $target isa person, has phone-number "+86 921 547 9004";
		  (caller: $customer, callee: $target) isa call, has started-at $started-at;
		  $min-date == 2018-09-10T00:00:00; $started-at > $min-date;
		get $phone-number;

### English (literal)

- Find customers of type person, with attribute phone number populated (valid entries)
- Find a company whose attribute name is Telecom
- Find a contract relationship between a customer and company
- Find a target (customer) of entity type person and with a phone number attribute of value "+86 921 547 9004"
- Find a call relationship between a customer and a target (also customer) where the call attribute started-at > a given minimum date of 2018-09-10T00:00:00
- Find the phone number of the target

### English (simplifications)

- Find a company by the name Telecom 
- And customers who have a contract with this company
- ~Find customers of type person, with attribute phone number populated (valid entries) (automatically filtered)~
- And find the customer with the telephone number "+86 921 547 9004"
- Find all the calls made by this customer to others on or after the date 10-9-2018 starting mid-night (or September 10th 2018 starting mid-night)
- Gather and return the phone numbers of all these people who were called

### English (further simplifications)

- Find the customer from the company Telecom with the telephone number "+86 921 547 9004"
- Get the numbers of all the calls made by this customer on or after the date 10-9-2018 mid-night (or September 10th 2018 mid-night)


### English (created by human)

_Mostly such texts are going to be terse or compact or might not give out all of the details like that in the **English (literal)** forms._

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
          $min-date == 2018-09-14T00:00:00; $started-at > $min-date;
        get $phone-number;

### English (literal)

- Find customers of type person, with attribute phone number populated (valid entry)
- Find a company whose attribute name is Telecom
- Find a contract relationship between a customer and company
- Find a target (customer) of entity type person and with a phone number attribute of value "+86 921 547 9004"
- Find a call relationship between a customer and a target (also customer) where the call attribute started-at > a given minimum date of 2018-09-14T00:00:00
- Find the phone number of the target

### English (created by human)

_Mostly such texts are going to be terse or compact or might not give out all of the details like that in the **English (literal)** forms._

Get me the customers of company “Telecom” who called the target person with phone number +86 921 547 9004 from September 14th onwards.


## Query 3

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

### English (literal)

- Find first person (potential caller) of type person, with attribute city "Cambridge" and age greater than 50
- Find a company whose attribute name is Telecom
- Find a contract relationship between the first caller (potential caller) and company
- Find a second entity of type person and age attribute < 20;
- Find a call relationship between first person and second person with an attribute started-at (assign it to $pattern-call-date)
- A third entity (target) is of type person and has an attribute phone number
- The target entity does not have a contract relationship with the company
- Find a call relationship between first person and third person with attribute started-at (assign to target-call-date)
- target-call-date is greater than $pattern-call-date
- Find the phone number of the target

### English (created by human)

_Mostly such texts are going to be terse or compact or might not give out all of the details like that in the **English (literal)** forms._

Who are the people aged under 20 who have received at least one phone call from a Cambridge customer aged over 50?


## Query 4

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

### English (literal)

- Find first person (potential caller) of type person, with attribute city "London" and age greater than 50
- Find a company whose attribute name is Telecom
- Find a contract relationship between the first caller (potential caller) and company
- Find a second entity of type person and age attribute < 20;
- Find a call relationship between first person and second person with an attribute started-at (assign it to $pattern-call-date)
- A third entity (target) is of type person and has an attribute phone number
- The target entity does not have a contract relationship with the company
- Find a call relationship between first person and third person with attribute started-at (assign to target-call-date)
- target-call-date is greater than $pattern-call-date
- Find the phone number of the target

### English (created by human)

_Mostly such texts are going to be terse or compact or might not give out all of the details like that in the **English (literal)** forms._

Who are the people who have received a call from a London customer aged over 50 who has previously called someone aged under 20?

or 

Get me the phone number of people who have received a call from a customer aged over 50 after this customer (potential person) made a call to another customer aged under 20.


## Query 5

### Graql

        match 
          $common-contact isa person, has phone-number $phone-number;
          $customer-a isa person, has phone-number "+7 171 898 0853";
          $customer-b isa person, has phone-number "+370 351 224 5176";
          (caller: $customer-a, callee: $common-contact) isa call;
          (caller: $customer-b, callee: $common-contact) isa call;
        get $phone-number;

### English (literal)

- Find a common contact of entity type person with an attribute phone-number
- Find first entity type person with an attribute phone-number of value "+7 171 898 0853"
- Find second entity type person with an attribute phone-number of value "+370 351 224 5176"
- Find a call relationship between the first entity and common contact
- Find a call relationship between the second entity and common contact
- Find the common contacts and get their phone numbers

### English (created by human)

_Mostly such texts are going to be terse or compact or might not give out all of the details like that in the **English (literal)** forms._

Who are the common contacts of customers with phone numbers +7 171 898 0853 and +370 351 224 5176?

## Query 6

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


### English (literal)

- Find first entity type person with an attribute phone-number of value "+48 894 777 5173"
- Find entity type of company with attribute name "Telecom"
- Find second entity type person with an attribute phone-number
- Find a contract relationship between customer-a and provider company
- Find a call relationship between the caller customer-a and callee second entity type person
- Find a contract relationship between customer-b and provider company
- Find a call relationship between the caller customer-b and callee third entity type person
- Find a call relationship between the caller customer-a and callee customer-b type person
- Get the phone numbers of customer-a and customer-b

- Find the common contacts and get their phone numbers

### English (created by human)

_Mostly such texts are going to be terse or compact or might not give out all of the details like that in the **English (literal)** forms._

Who are the customers who 1) have all called each other and 2) have all called person with phone number +48 894 777 5173 at least once?

or

Get me the phone number of people who have received calls from both customer with phone number +7 171 898 0853 and customer with phone number +370 351 224 5176.

## Query 7

### Graql

        match
          $customer isa person, has age < 20;
          $company isa company, has name "Telecom";
          (customer: $customer, provider: $company) isa contract;
          (caller: $customer, callee: $anyone) isa call, has duration $duration;
        get $duration; mean $duration;
a) Get me the average call duration among customers who have a contract with company “Telecom” and are aged under 20.

### English (literal)

- Find a customer of entity type person, and with attribue age < 20
- Find entity type of company with attribute name "Telecom"
- Find a contract relationship between a customer and company
- Find a call relationship between any two customers with attribute call duration
- Get this call duration, calculate the mean of all these durations
 
### English (created by human)

_Mostly such texts are going to be terse or compact or might not give out all of the details like that in the **English (literal)** forms._

a) Get me the average call duration among customers who have a contract with company “Telecom” and are aged under 20.

### Graql

        match
          $customer isa person, has age > 40;
          $company isa company, has name "Telecom";
          (customer: $customer, provider: $company) isa contract;
          (caller: $customer, callee: $anyone) isa call, has duration $duration;
        get $duration; mean $duration;


### English (literal)

- Find a customer of entity type person, and with attribue age < 20
- Find entity type of company with attribute name "Telecom"
- Find a contract relationship between a customer and company
- Find a call relationship between any two customers with attribute call duration
- Get this call duration, calculate the mean of all these durations

### English (created by human)

_Mostly such texts are going to be terse or compact or might not give out all of the details like that in the **English (literal)** forms._

b) Get me the average call duration among customers who have a contract with company “Telecom” and are aged over 40.

## Graql Schema in English

### Schema

```
define

    name sub attribute,
      datatype string;
    started-at sub attribute,
      datatype date;
    duration sub attribute,
      datatype long;
    first-name sub attribute,
      datatype string;
    last-name sub attribute,
      datatype string;
    phone-number sub attribute,
      datatype string;
    city sub attribute,
      datatype string;
    age sub attribute,
      datatype long;

    contract sub relation,
        relates provider,
        relates customer;

    call sub relation,
        relates caller,
        relates callee,
        has started-at,
        has duration;

    company sub entity,
        plays provider,
        has name;

    person sub entity,
        plays customer,
        plays caller,
        plays callee,
        has first-name,
        has last-name,
        has phone-number,
        has city,
        has age;
```

### English (literal)

- Below is a list of attributes with their data types
  - name (string)
  - started-at (date)
  - duration (long)
  - first-name (string)
  - last-name (string)
  - phone-number (string)
  - city (string)
  - age (long)

- A contract is a type of relationship between providers and customers

- A call is a type of relationship between a caller and a callee (one who is being called) and has attributes started-at and duration

- A company is an entity and plays a role of a provider and has a name attribute

- A person is an entity that can play a role of a customer, a caller, and a callee and has attributes first-name, last-name, phone-number, city and age

---

[back to README](../README.md)