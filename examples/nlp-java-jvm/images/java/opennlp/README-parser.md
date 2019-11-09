## Parser

Parse a line of text or an article and identify groups of words or phrases that go together (see [Penn Treebank tag set](https://www.ling.upenn.edu/courses/Fall_2003/ling001/penn_treebank_pos.html) for legend of token types).

Usage:
```bash
$ ./parser.sh 
```

```
No parameter has been passed. Please see usage below:

       Usage: ./parser.sh --text [text]
                 --file [path/to/filename]
                 --help

       --text      plain text surrounded by quotes
       --file      name of the file containing text to pass as command arg
       --help      shows the script usage help text
```

Examples:

```bash 
./parser.sh --text "The quick brown fox jumps over the lazy dog ."
Checking if model en-parser-chunking.bin (en) exists...
Found model en-parser-chunking.bin (en)
Loading Parser model ... done (7.499s)
(TOP (NP (NP (DT The) (JJ quick) (JJ brown) (NN fox) (NNS jumps)) (PP (IN over) (NP (DT the) (JJ lazy) (NN dog))) (. .)))


Average: 8.6 sent/s
Total: 1 sent
Runtime: 0.116s
Execution time: 7.903 seconds

Check out https://www.ling.upenn.edu/courses/Fall_2003/ling001/penn_treebank_pos.html
  to find out what each of the tags mean
```

Similarly a file containing text can be passed in as:

```
$ ./parser.sh --file article.txt
```
# Contributing

Contributions are very welcome, please share back with the wider community (and get credited for it)!

Please have a look at the [CONTRIBUTING](../../../../../CONTRIBUTING.md) guidelines, also have a read about our [licensing](../../../../../LICENSE.md) policy.

---

Back to [NLP page](../../../../../natural-language-processing/README.md#natural-language-processing-nlp) </br>
Back to [main page (table of contents)](../../../../../README.md)