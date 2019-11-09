## Tag Parts of Speech

Tag parts of speech of each token in a line of text or an article (see [Penn Treebank tag set](https://www.ling.upenn.edu/courses/Fall_2003/ling001/penn_treebank_pos.html) for legend of token types), also see https://nlp.stanford.edu/software/tagger.shtml.

Usage: 

```bash
$ ./posTagger.sh
```

```
No parameter has been passed. Please see usage below:

       Usage: ./posTagger.sh --method [ maxent | perceptron ]
                 --text [text]
                 --file [path/to/filename]
                 --help

       --method       [ maxent | perceptron ]
                        maxent        use the model trained using the Max Entropy algorithm
                        perceptron    use the model trained using the Perceptron algorithm to train
       --text         plain text surrounded by quotes
       --file         name of the file containing text to pass as command arg
       --help         shows the script usage help text
```
Examples:

```bash
./posTagger.sh --method maxent --text "This is a simple text to tag"
```
```
Checking if model en-pos-maxent.bin (en) exists...
Downloading model en-pos-maxent.bin (en)...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 5562k  100 5562k    0     0   602k      0  0:00:09  0:00:09 --:--:--  561k
Loading POS Tagger model ... done (1.837s)
This_DT is_VBZ a_DT simple_JJ text_NN to_TO tag_NN


Average: 38.5 sent/s
Total: 1 sent
Runtime: 0.026s
Execution time: 1.969 seconds

Check out https://www.ling.upenn.edu/courses/Fall_2003/ling001/penn_treebank_pos.html
  to find out what each of the tags mean
```

```bash
$ ./posTagger.sh --method perceptron --text "This is a simple text to tag"
```
```
Checking if model en-pos-perceptron.bin (en) exists...
Downloading model en-pos-perceptron.bin (en)...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 3882k  100 3882k    0     0   634k      0  0:00:06  0:00:06 --:--:--  523k
Loading POS Tagger model ... done (1.492s)
This_DT is_VBZ a_DT simple_JJ text_NN to_TO tag_VB


Average: 58.8 sent/s
Total: 1 sent
Runtime: 0.017s
Execution time: 1.593 seconds

Check out https://www.ling.upenn.edu/courses/Fall_2003/ling001/penn_treebank_pos.html
  to find out what each of the tags mean
```

Parts of speech are prefixed with `_` followed by a two or three letter suffix, see https://www.ling.upenn.edu/courses/Fall_2003/ling001/penn_treebank_pos.html to find out what each of the Parts of Speech mean.


Similarly a file containing text can be passed in as:

```
$ ./posTagger.sh --method maxent     --file article.txt
or
$ ./posTagger.sh --method perceptron --file article.txt
```
# Contributing

Contributions are very welcome, please share back with the wider community (and get credited for it)!

Please have a look at the [CONTRIBUTING](../../../../../CONTRIBUTING.md) guidelines, also have a read about our [licensing](../../../../../LICENSE.md) policy.

---

Back to [NLP page](../../../../../natural-language-processing/README.md#natural-language-processing-nlp) </br>
Back to [main page (table of contents)](../../../../../README.md)