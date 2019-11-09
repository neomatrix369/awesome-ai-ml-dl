## Detecting language

Detecting language in a single line text or article (see [legend of language abbreviations](https://www.apache.org/dist/opennlp/models/langdetect/1.8.3/README.txt) used).

Usage:

```bash
$ ./detectLanguage.sh
```

```
No parameter has been passed. Please see usage below:

       Usage: ./detectLanguage.sh --text [text]
                 --file [path/to/filename]
                 --help

       --text      plain text surrounded by quotes
       --file      name of the file containing text to pass as command arg
       --help      shows the script usage help text
```

Examples:

```bash
$ ./detectLanguage.sh --text "This is an english sentence"

Checking if model langdetect-183.bin exists...
Found model langdetect-183.bin
Loading Language Detector model ... done (1.836s)
eng This is an english sentence



Average: 26.3 doc/s
Total: 1 doc
Runtime: 0.038s
Execution time: 2.221 seconds

Check out https://www.apache.org/dist/opennlp/models/langdetect/1.8.3/README.txt to find out what each of the two-letter language indicators mean
```

Similarly a file containing text can be passed in as:

```bash
$ ./detectLanguage.sh --file article.txt
```

# Contributing

Contributions are very welcome, please share back with the wider community (and get credited for it)!

Please have a look at the [CONTRIBUTING](../../../../../CONTRIBUTING.md) guidelines, also have a read about our [licensing](../../../../../LICENSE.md) policy.

---

Back to [NLP page](../../../../../natural-language-processing/README.md#natural-language-processing-nlp) </br>
Back to [main page (table of contents)](../../../../../README.md)