## Tokenise

Tokenise a line of text or an article into it’s smaller components (i.e. words, punctuation, numbers).

Usage: 
```bash
$ ./tokenizer.sh
```

```
No parameter has been passed. Please see usage below:

       Usage: ./tokenizer.sh --method [ simple | learnable ]
                 --text [text]
                 --file [path/to/filename]
                 --help

       --method       [ simple | learnable ]
                        simple        use the simple tokenisation method
                        learnable     use the learned model to perform tokenisation
       --text         plain text surrounded by quotes
       --file         name of the file containing text to pass as command arg
       --help         shows the script usage help text
```

Examples:

```bash
$ ./tokenizer.sh --method simple --text "this-is-worth,tokenising.and,this,is,another,one"
```

```
this - is - worth , tokenising . and , this , is , another , one


Average: 111.1 sent/s
Total: 1 sent
Runtime: 0.009s
Execution time: 0.233 seconds
```

```bash
$ ./tokenizer.sh --method learnable --text "this-is-worth,tokenising.and,this,is,another,one"
```

```
Checking if model en-token.bin (en) exists...
Downloading model en-token.bin (en)...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  429k  100  429k    0     0   391k      0  0:00:01  0:00:01 --:--:--  391k
Loading Tokenizer model ... done (0.281s)
this-is-worth ,tokenising .and ,this ,is ,another ,one


Average: 76.9 sent/s
Total: 1 sent
Runtime: 0.013s
Execution time: 0.600 seconds
```

Similarly a file containing text can be passed in as:

```
$ ./tokenizer.sh --method simple    --file article.txt
or 
$ ./tokenizer.sh --method learnable --file article.txt
```

# Contributing

Contributions are very welcome, please share back with the wider community (and get credited for it)!

Please have a look at the [CONTRIBUTING](../../../../../CONTRIBUTING.md) guidelines, also have a read about our [licensing](../../../../../LICENSE.md) policy.

---

Back to [NLP page](../../../../../natural-language-processing/README.md#natural-language-processing-nlp) </br>
Back to [main page (table of contents)](../../../../../README.md)