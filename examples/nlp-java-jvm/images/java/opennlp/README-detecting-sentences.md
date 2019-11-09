## Detecting sentences

Detecting sentences in a single line text or article.

Usage: 
```bash
$ ./detectSentence.sh
```

```
No parameter has been passed. Please see usage below:

       Usage: ./detectSentence.sh --text [text]
                 --file [path/to/filename]
                 --help

       --text      plain text surrounded by quotes
       --file      name of the file containing text to pass as command arg
       --help      shows the script usage help text
```

Examples:

```bash
$ ./detectSentence.sh --text "This is an english sentence. And this is another sentence."
Checking if model en-sent.bin (en) exists...
Found model en-sent.bin (en)
Loading Sentence Detector model ... done (0.137s)
This is an english sentence.
And this is another sentence.



Average: 117.6 sent/s
Total: 2 sent
Runtime: 0.017s
Execution time: 0.414 seconds
```

Similarly a file containing text can be passed in as:

```bash
$ ./detectSentence.sh --file article.txt
```

Note: if you miss out sentence ending delimeters (like a period ==> .) then it considers the whole text as a sentence till it finds the next delimeter terminating the sentence.

# Contributing

Contributions are very welcome, please share back with the wider community (and get credited for it)!

Please have a look at the [CONTRIBUTING](../../../../../CONTRIBUTING.md) guidelines, also have a read about our [licensing](../../../../../LICENSE.md) policy.

---

Back to [NLP page](../../../../../natural-language-processing/README.md#natural-language-processing-nlp) </br>
Back to [main page (table of contents)](../../../../../README.md)
