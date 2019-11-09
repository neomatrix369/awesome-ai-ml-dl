## Chunking

Text chunking by dividing a text or an article into syntactically correlated parts of words, like noun groups, verb groups. You apply this feature on the tagged parts of speech text or article. Apply chunking on a text already tagged by PoS tagger. Also see https://nlpforhackers.io/text-chunking/.

Usage:

```
$ ./chunker.sh
```

```
No parameter has been passed. Please see usage below:

       Usage: ./chunker.sh --text [text]
                 --file [path/to/filename]
                 --help

       --text      plain text surrounded by quotes
       --file      name of the file containing text to pass as command arg
       --help      shows the script usage help text
```

```bash
$ ./chunker.sh --text "This_DT is_VBZ a_DT simple_JJ text_NN to_TO tag_NN"
```
```
Checking if model en-chunker.bin (en) exists...
Downloading model en-chunker.bin (en)...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 2500k  100 2500k    0     0   554k      0  0:00:04  0:00:04 --:--:--  622k
Found model en-chunker.bin (en)
Loading Chunker model ... done (0.565s)
 [NP This_DT ] [VP is_VBZ ] [NP a_DT simple_JJ text_NN ] [PP to_TO ] [NP tag_NN]


Average: 33.3 sent/s
Total: 1 sent
Runtime: 0.03s
Execution time: 0.935 seconds
```

```
$ ./chunker.sh --file article.txt
```
