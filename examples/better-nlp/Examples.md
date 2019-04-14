# Examples and results

### Extracts entities from text

Command:

```bash 
    cd library/examples/
    python3 extract-entities-from-text.py
```

Output:
```
Loading model en_core_web_lg...
~~~~~~~~ Started parsing...
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Denis Guedj (PERSON)
1940 – April 24, 2010 (DATE)
French (NORP)
the History of Science (ORG)
Paris VIII University (ORG)
Setif (GPE)
many years (DATE)
The Universal Language (ORG)
The Parrot's Theorem (ORG)
Paris (GPE)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Token types legend:  ['GPE = Geographic Point Entity', 'FAC = ', 'DATE = calendar date', 'NORP = Noun or Pronoun', 'PERSON = name of a person (proper noun)', 'ORG = Organisation']


...Finished parsing ~~~~~~~
```


### Extract noun chunks from text

Command:

```bash 
    cd library/examples/
    python3 extract-noun-chunks-from-text.py
```

Output:
```
Loading model en_core_web_lg...
~~~~~ Started parsing...
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
A list of words that belong together (in lowercase):
parrot's theorem
children math
universal language
many years
paris viii university
denis guedj
french novelist
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


...Finished parsing ~~~~~~
```

### Extracts facts from text

Command:

```bash 
    cd library/examples/
    python3 gather-facts-from-text.py
```

Output:
```
Loading model en_core_web_lg...
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Trying to gather details about Denis Guedj
 - a French novelist and a professor of the History of Science at Paris VIII University
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


...Finished parsing ~~~~~~~
```

### Obfuscate details from text for privacy

Command:

```bash 
    cd library/examples/
    python3 obfuscate-privacy-details-in-the-text.py
```

Output:
```
~~~~~~ Started parsing...
Loading model en_core_web_lg...
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Obfuscated generic text:  [OBFUSCATED] (1940 – April 24, 2010) was a French novelist and a professor of the History of Science at Paris VIII University. He was born in Setif. He spent many years devising courses and games to teach adults and children math. He is the author of Numbers: The Universal Language and of the novel The Parrot's Theorem. He died in Paris.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


...Finished parsing ~~~~~~~
```