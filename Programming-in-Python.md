# Programming in Python

- [Learning](#learning)
- [Cheatsheets](#cheatsheets)
- [Static analysis](#static-analysis)
    - [Focussed packages](#focussed-packages)
    - [Python Wrappers](#python-wrappers) 
- [Best practices](#best-practices)
- [Testing](#testing)
- [Refactoring](#refactoring)
- [Performance](#performance)
- [Contributing](#contributing)

## Learning
- [Introduction to Python](https://simpliv-wordpress-com.cdn.ampproject.org/c/s/simpliv.wordpress.com/2019/06/27/best-way-to-learn-python-step-by-step-guide/amp/)
- [Learn Python](https://www.learnpython.org/)
- [Python 3 Tutorial](https://docs.python.org/3/tutorial/)
- Online Python REPLs & Editors
  - [Python 2](https://repl.it/languages/Python2)
  - [Python 3](https://repl.it/languages/Python3) 
  - [Coding Ground: Execute Python Online (Python v2.7.13)](https://www.tutorialspoint.com/execute_python_online.php)
  - [The 10 Best Tools to Edit and Compile Python](https://noeticforce.com/python-online-compiler-interpreter-code-editors)
  - [9 Online Interactive Shells to Write Python Anywhere](https://www.bettertechtips.com/internet/python-shell-online/)
  - [Online Python Turtle Editor](https://repl.it/languages/python_turtle)
  - [Online Python Compiler](https://www.onlinegdb.com/online_python_compiler)
- [Local machine: Interacting with Python](https://realpython.com/interacting-with-python/)

## Cheatsheets
- [Python Cheatsheet](https://www.pythoncheatsheet.org/)
- [PySheee: Python Cheatsheet](https://www.pythonsheets.com/)
- [7+ Python Cheat Sheets for Beginners and Experts](https://sinxloud.com/python-cheat-sheet-beginner-advanced/)
- [Python for Data Science](https://s3.amazonaws.com/assets.datacamp.com/blog_assets/PythonForDataScience.pdf)

## Static analysis

### Focussed packages

* [mccabe](https://github.com/PyCQA/mccabe) - check McCabe complexity
* [mypy](https://github.com/python/mypy) - a static type checker that aims to combine the benefits of duck typing and static typing, frequently used with [MonkeyType](https://github.com/Instagram/MonkeyType)
* [py-find-injection](https://github.com/uber/py-find-injection) - find SQL injection vulnerabilities in Python code
* [pycodestyle](https://github.com/PyCQA/pycodestyle) - (formerly `pep8`) check Python code against some of the style conventions in PEP 8
* [pydocstyle](https://github.com/PyCQA/pydocstyle) - check compliance with Python docstring conventions
* [pyflakes](https://github.com/pyflakes/pyflakes/) - check Python source files for errors
* [pylint](https://github.com/PyCQA/pylint) - looks for programming errors, helps enforcing a coding standard and sniffs for some code smells. It additionally includes `pyreverse` (an UML diagram generator) and `symilar` (a similarities checker).
* [pyre-check](https://github.com/facebook/pyre-check) - A fast, scalable type checker for large Python codebases
* [pyright](https://github.com/Microsoft/pyright) - Static type checker for Python, created to address gaps in existing tools like mypy.
* [pyroma](https://github.com/regebro/pyroma) - rate how well a Python project complies with the best practices of the Python packaging ecosystem, and list issues that could be improved
* [PyT - Python Taint](https://github.com/python-security/pyt) - A static analysis tool for detecting security vulnerabilities in Python web applications.
* [pytype](https://github.com/google/pytype) - A static type analyzer for Python code.
* [Review of Python Static Analysis Tools](https://www.codacy.com/blog/review-of-python-static-analysis-tools/)
* [Python Static Analysis Tools ](https://luminousmen.com/post/python-static-analysis-tools)
* See [awesome-static-analysis for Python](https://github.com/mre/awesome-static-analysis/blob/master/README.md#python)

### Python wrappers

* [ciocheck](https://github.com/ContinuumIO/ciocheck) - linter, formatter and test suite helper. As a linter, it is a wrapper around `pep8`, `pydocstyle`, `flake8`, and `pylint`.
* [flake8](https://github.com/PyCQA/flake8) - a wrapper around `pyflakes`, `pycodestyle` and `mccabe`
* [multilint](https://github.com/adamchainz/multilint) - a wrapper around `flake8`, `isort` and `modernize`
* [prospector](https://github.com/PyCQA/prospector) - a wrapper around `pylint`, `pep8`, `mccabe` and others

## Best practices

- [PEP 8 -- Style Guide for Python Code](https://www.python.org/dev/peps/pep-0008/)
- [Python Best Practices and Tips by Toptal Developers](https://www.toptal.com/python/tips-and-practices)
- [Python Best Practices for More Pythonic Code](https://realpython.com/tutorials/best-practices/)
- [Python String Formatting Best Practices](https://realpython.com/python-string-formatting/)
- [The Best of the Best Practices (BOBP) Guide for Python](https://gist.github.com/sloria/7001839)
- [Dmitry Mugtasimov's Python software development practices](https://dmugtasimov-tech.blogspot.com/2016/12/my-python-software-development-practices.html)
- [Pluralsight: Python Best Practices for Code Quality](https://www.pluralsight.com/courses/python-best-practices-code-quality)
- [SO: Python coding standards/best practices](https://stackoverflow.com/questions/356161/python-coding-standards-best-practices)
- [Python Best Practices: 5 Tips For Better Code - Airbrake Blog](https://airbrake.io/blog/python/python-best-practices)
- [Python tutorial: Best practices and common mistakes to avoid](https://jaxenter.com/python-tutorial-best-practices-145959.html)

## Testing

- [Python Developer's Guide » Running & Writing Tests](https://devguide.python.org/runtests/)
- [Hitchhickers Guide to Python: Testing Your Code](https://docs.python-guide.org/writing/tests/)
- [SO: Writing unit tests in Python: How do I start?](https://stackoverflow.com/questions/3371255/writing-unit-tests-in-python-how-do-i-start)
- [Testing Python Applications with Pytest](https://semaphoreci.com/community/tutorials/testing-python-applications-with-pytest)
- [An Introduction to Mocking in Python](https://www.toptal.com/python/an-introduction-to-mocking-in-python)
- [PyCharm: Testing Your First Python Application](https://www.jetbrains.com/help/pycharm/testing-your-first-python-application.html)
- [Udemy Course: Automated Software Testing with Python](https://www.udemy.com/automated-software-testing-with-python/)
- [unittest — Unit testing framework](https://docs.python.org/2/library/unittest.html)

## Refactoring

- [PyCharm: Refactoring code](https://www.jetbrains.com/help/pycharm/refactoring-source-code.html)
- [PyCharm refactoring tip](https://stackoverflow.com/questions/47978893/pycharm-is-this-kind-of-automatic-signature-refactoring-possible)
- [PyCharm Refactoring Tutorial](https://www.jetbrains.com/help/pycharm/product-refactoring-tutorial.html)
- [Learning Python with PyCharm: Refactoring](https://www.lynda.com/Python-tutorials/Refactoring/590828/629432-4.html)
- [What refactoring tools do you use for Python?](https://stackoverflow.com/questions/28796/what-refactoring-tools-do-you-use-for-python)

## Performance

- [Python High Performance - Second Edition](https://github.com/PacktPublishing/Python-High-Performance-Second-Edition)
- [Python and performance](https://github.com/ameroueh/performance)
- [NumPy aware dynamic Python compiler using LLVM ](https://github.com/ameroueh/numba) | [Numba](http://numba.pydata.org/)

# Contributing

Contributions are very welcome, please share back with the wider community (and get credited for it)!

Please have a look at the [CONTRIBUTING](CONTRIBUTING.md) guidelines, also have a read about our [licensing](LICENSE.md) policy.

---

Back to [main page (table of contents)](README.md)