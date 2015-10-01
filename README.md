# Superscript


### Motivation
[![Build
Passing](https://circleci.com/gh/udaysinghcode/superscript.svg?style=shield&circle-token=c4a7fd27027a5be7c2f8d8295c088c97a8946692)]
[![Build
Passing](https://circleci.com/gh/udaysinghcode/superscript.svg?circle-token=c4a7fd27027a5be7c2f8d8295c088c97a8946692)]
>"JS is the x86 of the web" - Brandon Eich

Why compile to Javascript? As Brandon Eich said, [“JS is the x86 of the web”][0] . 
Today Javascript is used not only to govern interactions on the front end of the internet, 
but also to prototype systems on the backend of the web.

In recent years, the web has transformed in terms of interaction design and web browser 
functionality. The modern web has progressed from static pages and now demands a [system][1]
that provides reactions based on data changes. This necessity for real-time interaction 
has led to a shift in the world of rapid prototyping, from monolithic web frameworks, to a 
clear separation between single-page applications and APIs.

The development of Node.js has led to more developers embracing Javascript as a viable 
language for backend development. Despite its popularity however, Javascript’s verbose syntax, 
mutable objects, illogical equality comparisons, and complex callbacks make it difficult for 
developers be completely aware of their code’s [side effects][2]. 

Developers should understand the full semantic structure of their code, especially when 
prototyping web servers and RESTful APIs, and dealing with callbacks and Node.js requests. 
However, closures and anonymous functions in Javascript are often confusing to write and 
understand. The number of lines of code is also directly correlated with the number of bugs 
generated. 

Despite Javascript treating functions as first class objects, Javascript is typically 
used as an imperative programming language. Its lack of structure has encouraged programmers 
to think of Javascript objects in terms of state, instead of attempting to transform data. 
Javascript is a product of rapid evolution, and thus for many people from the functional 
programming school of thought, it seems broken. Although its core library is small, 
Javascript’s weak typing and object construction system create a broken mix, where functions
 are first class, yet objects are used imperatively. 

Our solution is Superscript, a type-inferred language, inspired by a mix of Lisp, Clojure and 
Arc that compiles to Javascript.


### Language Description

> "Lisp isn't a language, it's a building material." - Alan Kay

Superscript is a Lisp focused on rapid development to compile to Javascript. Primarily being 
heavily influenced from both Arc and Clojure, two very new languages introduced to the Lisp 
community. Superscript is a Lisp designed to have very intentional syntax, allowing the user 
to know very little to write very large programs. 

Unlike Javascript, Superscript encourages users to write in a functional first language 
thinking more before they code. Using an inferred type system, similar to Ocaml, our compiler 
tells users when their functions break for particular type and strongly encourages functional 
thinking over imperative thinking. This breaks users from thinking in terms of objects as many 
new programmers do when looking at Javascript and encourages clean data transformations which 
the user is aware of through s-expressions. This, combined with the flexibility of the Lisp 
family of languages, where functions and data are equivalent, gives users of Superscript a 
level of power unavailable in languages like Javascript.

Object-oriented programming tends to be written with a lack of discipline on the developer's 
part, by preventing them from doing much damage by abstracting everything. Superscript’s focus 
on power and brevity encourages users for rapid prototyping to write succinct code, which 
results in clean, type-inferred functions in Javascript. Additionally, another shortcoming 
of Object-Oriented programming is that often times due to the lack of power provided by 
object-oriented languages, users tend to believe they are doing more work than they are 
actually outputting. Superscript encourages thoughtful programming, translated to Javascript that 
is performant, functional, and well typed.

Superscript uses syntax based on Lisp and will translate to Javascript. It builds upon the 
primary Lisp functions[3], and in addition, it allows for user-defined functions, recursion, 
and type inference with seven data types. Superscript’s syntax is based on closure, and is 
built from multiple nested S-expressions. Similar to OCaml, it is functional. Unlike 
languages like Scheme, it is type inferred.  Expressions are evaluated in prefix order. 
Superscript supports the typical arithmetic and logical operations. 

Superscript intends to provide sharp programmers a language to think and express clear 
functional ideas in a language which is slowly becoming the backbone of the web.

### Syntax Examples

A syntax example below:

```arc
; Superscript source code for GCD 

(def gcd (a b)
	(if (is 0 b) a
		(gcd b (mod a b))))
```

```js
// GCD in resulting Javscript

var gcd = function(a, b) {
	if (b === 0) {
		return a;
	}
	return gcd(b, a % b);
};
```

### Footnotes

[0]: http://www.hanselman.com/blog/JavaScriptIsAssemblyLanguageForTheWebPart2MadnessOrJustInsanity.aspx
[1]: http://rauchg.com/2014/7-principles-of-rich-web-applications
[2]: https://www.destroyallsoftware.com/talks/wat
[3]: http://languagelog.ldc.upenn.edu/myl/ldc/llog/jmc.pdf 
[4]: ttp://www.paulgraham.com/arc.html 
[5]: http://cs.princeton.edu/courses/archive/spr11/cos333/lectures/17paradigms/sort.lisp
[6]: http://www.braveclojure.com/
