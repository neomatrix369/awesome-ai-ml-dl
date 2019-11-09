## Finding names

Finding person name, organization name, date, time, money, location, percentage information in a single line text or article.

Usage: 

```bash
$ ./nameFinder.sh
```

```
No parameter has been passed. Please see usage below:

       Usage: ./nameFinder.sh --method [ person | location | date | time | money | organization | percentage ]
                 --text [text]
                 --file [path/to/filename]
                 --help
       --method    [ person | location | date | time | money | organization | percentage ]
                     person       - find name of persons in text
                     location     - find location names in text
                     date         - find dates mentioned in text
                     time         - find time mentioned in text
                     money        - find money / currency mentioned in text
                     organization - find organization names mentioned in text
                     percentage   - find percentages mentioned in text
       --text      plain text surrounded by quotes
       --file      name of the file containing text to pass as command arg
       --help      shows the script usage help text
```

#### Person name

Example:

```bash
$ ./nameFinder.sh --method person  --text "My name is John"
```

```
Checking if model en-ner-person.bin (en) exists...
Downloading model en-ner-person.bin (en)...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 5085k  100 5085k    0     0   673k      0  0:00:07  0:00:07 --:--:--  609k
Loading Token Name Finder model ... done (1.200s)
My name is <START:person> John <END>


Average: 24.4 sent/s
Total: 1 sent
Runtime: 0.041s
Execution time: 1.845 seconds
```

Indicates the name of the person between the <START> and <END> tokens.

#### Location name

Example:

```bash
$ ./nameFinder.sh --method location  --text "John lives in Colorado."
```

```
Checking if model en-ner-location.bin (en) exists...
Found model en-ner-location.bin (en)
Loading Token Name Finder model ... done (1.263s)
John lives in <START:location> Colorado. <END>


Average: 31.3 sent/s
Total: 1 sent
Runtime: 0.032s
Execution time: 1.747 seconds
```

Indicates the place name between the <START> and <END> tokens.

#### Date names

Example:

```bash
$ ./nameFinder.sh --method date  --text "Today is Friday. John was born on November 2019."
```

```
Checking if model en-ner-date.bin (en) exists...
Found model en-ner-date.bin (en)
Loading Token Name Finder model ... done (1.147s)
<START:date> Today <END> is Friday. John was born on <START:date> November 2019. <END>


Average: 30.3 sent/s
Total: 1 sent
Runtime: 0.033s
Execution time: 1.621 seconds
```

Indicates the date name between the <START> and <END> tokens.

#### Time names

Example:

```bash
$ ./nameFinder.sh --method time  --text "The news if from this morning"
```

```
Checking if model en-ner-time.bin (en) exists...
Downloading model en-ner-time.bin (en)...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 4613k  100 4613k    0     0   565k      0  0:00:08  0:00:08 --:--:--  508k
Loading Token Name Finder model ... done (1.158s)
The news if from <START:time> this morning <END>


Average: 27.8 sent/s
Total: 1 sent
Runtime: 0.036s
Execution time: 1.656 seconds
```

Indicates the time name between the <START> and <END> tokens.

#### Money names

```bash
$ ./nameFinder.sh --method money  --text "The trip costs 500 hundred dollars."
```

```
Checking if model en-ner-money.bin (en) exists...
Downloading model en-ner-money.bin (en)...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 4693k  100 4693k    0     0   575k      0  0:00:08  0:00:08 --:--:--  529k
Loading Token Name Finder model ... done (1.225s)
The trip costs <START:money> 500 hundred dollars. <END>


Average: 30.3 sent/s
Total: 1 sent
Runtime: 0.033s
Execution time: 1.758 seconds
```

Indicates the money name between the <START> and <END> tokens.

#### Organization names

Example:

```bash
$ ./nameFinder.sh --method organization  --text "The UN is a great organisation."
```

```
Checking if model en-ner-organization.bin (en) exists...
Downloading model en-ner-organization.bin (en)...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 5173k  100 5173k    0     0   614k      0  0:00:08  0:00:08 --:--:--  598k
Loading Token Name Finder model ... done (1.311s)
The <START:organization> UN <END> is a great organisation.


Average: 27.8 sent/s
Total: 1 sent
Runtime: 0.036s
Execution time: 1.840 seconds
```

Indicates the organisation name between the <START> and <END> tokens.

#### Percentage names

Example:

```bash
$ ./nameFinder.sh --method percentage  --text "It is correct 50 percent of the time"
```

```
Checking if model en-ner-percentage.bin (en) exists...
Downloading model en-ner-percentage.bin (en)...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 4617k  100 4617k    0     0   607k      0  0:00:07  0:00:07 --:--:--  561k
Loading Token Name Finder model ... done (1.106s)
It is correct <START:percentage> 50 percent <END> of the time


Average: 20.4 sent/s
Total: 1 sent
Runtime: 0.049s
Execution time: 1.582 seconds
```

Indicates the percentage name between the <START> and <END> tokens.

# Contributing

Contributions are very welcome, please share back with the wider community (and get credited for it)!

Please have a look at the [CONTRIBUTING](../../../../../CONTRIBUTING.md) guidelines, also have a read about our [licensing](../../../../../LICENSE.md) policy.

---

Back to [NLP page](../../../../../natural-language-processing/README.md#natural-language-processing-nlp) </br>
Back to [main page (table of contents)](../../../../../README.md)
