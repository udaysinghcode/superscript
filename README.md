# Superscript

![Build
Passing](https://circleci.com/gh/udaysinghcode/superscript.svg?style=shield&circle-token=c4a7fd27027a5be7c2f8d8295c088c97a8946692)
![Build
Passing](https://circleci.com/gh/udaysinghcode/superscript.svg?circle-token=c4a7fd27027a5be7c2f8d8295c088c97a8946692)

## 1. Introduction

### 1.1 Welcome to Superscript

Superscript is a type-inferred Lisp with syntax, focused on rapid development, that compiles into Javascript. Superscript is a compiled language with static type inference, using the Lisp core, that allows the user to write robust, yet concise programs.  It is heavily influenced by both Arc and Clojure, two new languages introduced to the Lisp community, and OCaml.

Unlike Javascript, the functional-first nature of Superscript encourages users to think more before they code. Using static type inference based on the Hindley-Milner algorithm, our compiler tells users when their functions break due to type inconsistency. Similar to OCaml, it discourages users from thinking in terms of objects, and encourages clean data transformations through the use of S-expressions, which may be written using either Lisp-like, or imperative syntax (refer to Section 8, for Syntax Modifications to the Lisp core). This, combined with the flexibility of the Lisp family of languages, where functions and data are equivalent, gives users of Superscript a level of power unavailable in languages like Javascript.

Superscript enables sharp programmers to think and express clear functional ideas in a language that is slowly becoming the backbone of the web.

### 1.2 Program Structure

Superscript programs are built with expressions, and a program can be viewed as a single expression or a list of expressions executed in sequence. In Superscript, functions are data and data are functions.

In the following examples, the indicated result is what the expression would evaluate to, in the executable JavaScript produced by the Superscript compiler.

```lisp
; Function call that prints Hello, world!
> (prn “Hello, world!”);;
Hello, world!

; Addition function applied to all integers from 1 to 10
> (+ 1 2 3 4 5 6 7 8 9 10);;

; Function call, applying the ‘head’ function to a list
; that consists of ‘+’ and the integers 1 through 10.
> (head ‘(+ 1 2 3 4 5 6 7 8 9 10));;
```

The idea that both functions and data are one and the same allows for rapid expression of ideas in Superscript that would otherwise be more difficult to express in Javascript. The above examples show not only how functions are executed, but how comments work (using the semicolon), and the power of code and data being one.

### 1.3 Related Work and Inspiration

There are actually a number of related works to Superscript, a lot of which we noticed when we were hunting for names - SLisp, LispyScript, Parenscript, and more. We did not actually consult any of them when designing Superscript, except Clojurescript. Clojurescript, however, is focused on covering many of the syntax ideas of Clojure in a Lisp which compiles to Javascript. Clojure involves many syntactic differences that Superscript does not have such as the notation for sets, maps, and vectors.

Our work is inspired by a Lisp called Arc developed by Paul Graham prior to Clojure as a response to the lack of Lisp development since the 1980s. We focused on Arc’s obsession of brevity (as in shortening the required amount of tokens to write a program, thus effectively decreasing the number of bugs). We tried not to fall into the Perl trap of requiring too few characters, but reducing the number of tokens so that programs remain transparent and short. We included an alternate syntax which preserves the semantics of Lisp, yet is very approachable for those who might be alarmed by the number of parentheses. Caramel can be preprocessed into Superscript which is then run by GEB (our compiler named after Hofstadter’s seminal work Gödel, Escher, Bach). Caramel allows Superscript to be more appealing to a more mainstream audience, switching out parentheses for indentation, as well as a few more syntactic features. Superscript still allows s-expressions as much like how John McCarthy worked on designing a syntax structure for Lisp, programmers preferred the untouched s-expressions.

We looked at Poly and Haskell for type inference to prevent classic type errors that plague Lisp, utilizing Hindley Milner’s Algorithm W. We strayed away from Arc’s function overloading as this would break Algorithm W and instead focused on implementing the best of the safety that comes from type inference with a mix between terse Lisp code which is readable and short that can be picked up easily by beginners to Lisp and safe enough to prevent many of the classic bugs that hurt Javascript.

We also utilized Node.js to evaluate Javascript on a cross-platform runtime environment so that Superscript could be extremely powerful for developing server-side web applications.

All in all, Superscript could not have developed without the open source community, and for that we are indebted.


### Footnotes

[0]: http://www.hanselman.com/blog/JavaScriptIsAssemblyLanguageForTheWebPart2MadnessOrJustInsanity.aspx
[1]: http://rauchg.com/2014/7-principles-of-rich-web-applications
[2]: https://www.destroyallsoftware.com/talks/wat
[3]: http://languagelog.ldc.upenn.edu/myl/ldc/llog/jmc.pdf
[4]: ttp://www.paulgraham.com/arc.html
[5]: http://cs.princeton.edu/courses/archive/spr11/cos333/lectures/17paradigms/sort.lisp
[6]: http://www.braveclojure.com/
