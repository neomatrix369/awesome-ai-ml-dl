# Apache OpenNLP [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![NLP Java](https://img.shields.io/docker/pulls/neomatrix369/nlp-java.svg)](https://hub.docker.com/r/neomatrix369/nlp-java) 

Run a docker container with Apache OpenNLP written in Java, running under the traditional Java 8 (from OpenJDK or another source) or GraalVM.

Find out more about [Natural Language Processing](https://en.wikipedia.org/wiki/Natural_language_processing) from the [NLP section](../../../../../natural-language-processing/README.md#natural-language-processing-nlp) section.

Startup in traditional JDK or GraalVM mode.

## Goals

- Download and install the Apache OpenNLP tool
- (optional) Switch to GraalVM (polyglot JVM i.e. GraalVM JDK Community version from Oracle Labs)
- Run a number of NLP actions to explore the Apache OpenNLP tool

## Scripts provided

**Go to [the previous folder](../opennlp) to find the below scripts.**

- [opennlp.sh](./opennlp.sh): download and install the Apache OpenNLP tool into the `shared` folder
- [detectLanguage.sh](./detectLanguage.sh): Detecting language in a single line text or article (see [legend of language abbreviations](https://www.apache.org/dist/opennlp/models/langdetect/1.8.3/README.txt) used).
- [detectSentence.sh](./detectSentence.sh): Detecting sentences in a single line text or article.
- [nameFinder.sh](./nameFinder.sh): Finding person name, organization name, date, time, money, location, percentage information in a single line text or article.
- [tokenizer.sh](./tokenizer.sh): Tokenise a line of text or an article into it’s smaller components (i.e. words, punctuation, numbers).
- [parser.sh](./parser.sh): Parse a line of text or an article and identify groups of words or phrases that go together (see [Penn Treebank tag set](https://www.ling.upenn.edu/courses/Fall_2003/ling001/penn_treebank_pos.html) for legend of token types).
- [posTagger.sh](./posTagger.sh): Tag parts of speech of each token in a line of text or an article (see [Penn Treebank tag set](https://www.ling.upenn.edu/courses/Fall_2003/ling001/penn_treebank_pos.html) for legend of token types), also see https://nlp.stanford.edu/software/tagger.shtml.
- [chunker.sh](./chunker.sh): Text chunking by dividing a text or an article into syntactically correlated parts of words, like noun groups, verb groups. You apply this feature on the tagged parts of speech text or article. Apply chunking on a text already tagged by PoS tagger. Also see https://nlpforhackers.io/text-chunking/.

All the above check if the respective model(s) exist and downloads them accordingly into the `shared` folder.

## Exploring NLP concepts

### Detecting language

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

### Detecting sentences

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

### Finding names

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

### Tokenise

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

### Parser 

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

### Tag parts of speech
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

### Chunking

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

### Docker image on Docker Hub

Find the [NLP Java/JVM Docker Image on Docker Hub](https://hub.docker.com/r/neomatrix369/nlp-java). The `docker-runner.sh --pushImageToHub` script pushes the image to the Docker hub and the `docker-runner.sh --runContainer` script runs it from the local repository. If absent, in the the local repository, it downloads this image from Docker Hub.

## Resources

### Apache OpenNLP

- [Apache OpenNLP](https://opennlp.apache.org/) | [GitHub](https://github.com/apache/opennlp) | [Mailing list](https://opennlp.apache.org/mailing-lists.html)
- Docs
    - https://opennlp.apache.org/docs/
    - [Apache OpenNLP Tools Javadoc](https://opennlp.apache.org/docs/1.9.1/apidocs/opennlp-tools/index.html)
    - Manual
        - https://opennlp.apache.org/docs/1.9.1/manual/opennlp.html
- Download
    - Apache OpenNLP Jar/binary
        - https://opennlp.apache.org/download.html
    - Model Zoo
        - https://opennlp.apache.org/models.html
        - http://www.mirrorservice.org/sites/ftp.apache.org/opennlp/models/langdetect/1.8.3/langdetect-183.bin
        - Older models to support the examples in the docs
            - http://opennlp.sourceforge.net/models-1.5/ 
- Legend to support the examples in the docs
    - List of languages: https://www.apache.org/dist/opennlp/models/langdetect/1.8.3/README.txt
    - [Penn Treebank tag set](https://www.ling.upenn.edu/courses/Fall_2003/ling001/penn_treebank_pos.html)

### Other NLP Java/JVM libraries

- [Standford CoreNLP](https://stanfordnlp.github.io/CoreNLP/) (GPL v2)
- [NLP4J: NLP Toolkit for JVM Languages](https://emorynlp.github.io/nlp4j/)
- [Word2vec in Java](https://deeplearning4j.org/docs/latest/deeplearning4j-nlp-word2vec) (DL4J)
- [ReVerb: Web-Scale Open Information Extraction](https://github.com/knowitall/reverb/) 
- [OpenRegex: An efficient and flexible token-based regular expression language and engine](https://github.com/knowitall/openregex) 
- [CogcompNLP: Core libraries developed in the U of Illinois' Cognitive Computation Group](https://github.com/datquocnguyen/RDRPOSTagger)
- [MALLET - MAchine Learning for LanguagE Toolkit](http://mallet.cs.umass.edu/)
- [RDRPOSTagger - A robust POS tagging toolkit available (in both Java & Python) together with pre-trained models for 40+ languages.](https://github.com/datquocnguyen/RDRPOSTagger)

### [Awesome AI/ML/DL resources](https://github.com/neomatrix369/awesome-ai-ml-dl/)
  * [Java AI/ML/DL resources](https://github.com/neomatrix369/awesome-ai-ml-dl/blob/master/README-details.md#java)
      * [Deep Learning and DL4J Resources](https://github.com/neomatrix369/awesome-ai-ml-dl/blob/master/README-details.md#deep-learning)
      * **Awesome AI/ML/DL:** [NLP resources](https://github.com/neomatrix369/awesome-ai-ml-dl/tree/master/natural-language-processing#natural-language-processing-nlp)
      * **DL4J NLP resources**
          * [Language processing](https://deeplearning4j.org/docs/latest/deeplearning4j-nlp-overview)
              * [ND4J backends for GPUs and CPUs](https://deeplearning4j.org/docs/latest/deeplearning4j-config-gpu-cpu)
              * [How the Vocab Cache Works](https://deeplearning4j.org/docs/latest/deeplearning4j-nlp-vocabulary-cache)
              * [Word2Vec, Doc2vec & GloVe: Neural Word Embeddings for Natural Language Processing](https://deeplearning4j.org/docs/latest/deeplearning4j-nlp-word2vec)
              * [Doc2Vec, or Paragraph Vectors, in Deeplearning4j](https://deeplearning4j.org/docs/latest/deeplearning4j-nlp-doc2vec)
              * [Sentence iterator](https://deeplearning4j.org/docs/latest/deeplearning4j-nlp-sentence-iterator)
              * [What is Tokenization?](https://deeplearning4j.org/docs/latest/deeplearning4j-nlp-tokenization)
          * Examples
              * https://github.com/eclipse/deeplearning4j-examples/tree/master/dl4j-examples
              * https://github.com/eclipse/deeplearning4j/tree/master/deeplearning4j/deeplearning4j-nlp-parent

# Contributing

Contributions are very welcome, please share back with the wider community (and get credited for it)!

Please have a look at the [CONTRIBUTING](../../../../../CONTRIBUTING.md) guidelines, also have a read about our [licensing](../../../../../LICENSE.md) policy.

---

Back to [NLP page](../../../../../natural-language-processing/README.md#natural-language-processing-nlp) </br>
Back to [main page (table of contents)](../../../../../README.md)