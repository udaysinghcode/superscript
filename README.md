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

```clojure
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

## 2. Tutorial

This is a tutorial on Superscript that is for all users. Our Language Reference Manual is also designed like a tutorial, but this is more of a conversational attempt to get you into using Superscript. You do not have to know Lisp to walk through our tutorial. We will use the following syntax to cover code. When you see text in this typeface, it is in reference to command line functions.

Let’s start by introducing the three characters important to understanding our tutorial. The % character is used to symbolize your Unix shell input. Make sure you have Node.js installed, if not, it can be downloaded from the Node.js site. In order to get started and print

```bash
% ./make
%  ./geb -s "(prn \"Hello, world!\");;"
```

This allows you to run individual lines of Superscript. Remember when using quotes to escape them in the command line, and to include the double semicolon for concluding statements.

``` bash
% vim hello.ss
/* Type (prn "Hello, world!");; */
% ./geb hello.ss
```

If you want to run a program, you can use this method of compiling the file using geb, and you will see the output. We also used a `/* */` to symbolize a comment. This is how you comment as well in Superscript files. We will sometimes use the comment notation to provide extra information for the user.

Our second to last symbol we will introduce is the > which is short for any line of Superscript which can be run. Rather than writing for either compiling files, or running individual lines, we will use this character to display lines of Superscript code. Feel free to provide appropriate spacing for writing Superscript files or bringing everything into one line to run with the ./geb -s command.

```clojure
> (prn "Hello, world!");;
"Hello, world!"
```

Our last symbol is >> which stands for the return value of the expression. This will not be explicitly printed, but is useful to show for certain expressions. We will usually show the printed output below the returned value.

```clojure
> (prn "Hello, world!");;
>> unit
"Hello, world!"
```

So let’s start with the classic “Hello, World!” program. Wait, we’ve actually done that before and we had no build up to it. Instead, we will try something different.

So here we will try it again, but instead do it with Devanagari script in Hindi. Let’s say hello, or better yet, “namaste” much like you do before a Yoga class.

```clojure
> (prn "नमस्ते")
```

So that was terribly easy, and you’ll note that Superscript can print all Unicode characters allowed by Javascript. Essentially when you run when hello.ss has the line above in it:

```bash
% ./geb hello.ss
```

This creates a file called a.js which is then run by the Node.js runtime. If Javascript can do it, we can do it too. You can run the file for the same output by running:

```bash
% node a.js
```

You will notice a number of functions and respective types printed above the output, this is Superscript showing you the types of all available functions as it is run. You can see what functions are available when and their types, and the process of Algorithm W; this is by design to assist with debugging.

Superscript programs are built out of expressions such as integers, floats, strings, and booleans.

```clojure
> 25;;
>> 25

> "foo";;
>> "foo"

> 24.4;;
>> 24.4

> true;;
>> true
```

Most expressions enclosed within multiple parentheses are also an expression. Many expressions together within parentheses are also known as an expression or actually, an s-expression, we also call these lists.

```clojure
> (+ 2 3);;

>> 5
```

There are two types of lists. Quoted and unquoted lists. We understand this doesn’t mean much right now, but all will be clear very soon.

```clojure
/* Unquoted lists */
(+ 2 3)

/* Quoted lists */
'(+ 2 3)
```

The list above, or the unquoted list, is technically a function or is evaluated from left to right with the values of the tail being passed as arguments to the values of the head. The first, unquoted list returns 5. The second quoted list is a list with a +, a 2, and a 3 in it. In other words, lists with quotes are not evaluated, lists with quotes are evaluated as function calls. All s-expressions will return something. So what does this return?

```clojure
> (+ (* 1 3) (+ 3 (+ 4 5)));;
```

If you said, 15, you would be correct, but as you are probably noticing, Superscript is not printing your values. So let’s see what’s happening  behind the madness.

In order to print something, you have to use the prn function, however, prn requires a string for it to produce a string. This is an intentional strength of Superscript as the static type inference of Superscript requires functions to have the appropriate types for it to run a successful type check of the expression. The prn function requires a string and outputs a string. In order to do this we can use one of our many cast functions.

```clojure
> (string_of_int (+ (* 1 3) (+ 3 (+ 4 5))));;
>> "15"
> (prn (string_of_int (+ (* 1 3) (+ 3 (+ 4 5)))));;
>> "15"
15
```

All casts are listed in the Language Reference Manual and will be used below. The format is pretty straight forward, string_of_int, string_of_float, string_of_boolean, and more.

So to go back to the expression, we notice that prefix notation, or putting the + before the elements in the unquoted list may seem a little odd compared to standard infix notation (if you want standard infix notation, we offer that. See the Infix Expression section in the Language Reference Manual or just put the operation within curly brackets. Prefix notation, however, has its benefits as we can keep adding arguments to the function.

```clojure
> (+);;
>> 0

> (+ 1);;
>> 1

> (+ 1 1);;
>> 2

> (+ 1 1 1);;
>> 3
```

If we want to assign to foo the value of 42, the entire assignment expression will return 42 when evaluated.

```clojure
> (= foo 42);;
>> 42

> (prn (string_of_int 42));;
>> 42
42
```

Although most operators evaluate from left to right, this is an exception which stores the value of 42 into foo. Now let’s add 42 to an unquoted list.

```clojure
> (cons 4 '(8 15 16 23 42));;
>> ‘(4 8 15 16 23 42)
```

The cons function appends the first argument to the list in the second argument. You’ll note that we are using a quoted list as a data structure inside, and an unquoted list as a function expression. This allows Superscript to be a homoiconic language and allows the user to very clearly note the applicative order of Superscript and even compute Superscript expressions by hand similar to lambda calculus.

Similarly to cons, we have have two functions to take lists apart: head and tail. Although more traditional Lisps use the terms car and cdr respectively. We found that head and tail made more sense to new users as “Contents of the Address part of Register number” did not have the same ring as “head”. To use these functions try this:

```clojure
> (head '(4 8 15 16 23 42));;
>> 4

> (prn (string_of_int (int (head '(4 8 15 16 23 42)))));;
4

> (tail ‘(4 8 15 16 23 42));;
>> '(8 15 16 23 42)


> (print_list format_int (tail '(4 8 15 16 23 42))));;
[8,15,16,23,42]
```

You’ll note that the standard Lisp formatting gives us 4 right parentheses at the end of this list may seem cumbersome. How is this dealt with in Lisp? As Paul Graham says, “we don’t.” Lisp programmers don’t count parentheses and let their editors do the work for them. As for readability, we use indentation. If you write in Caramel, our preprocessor allows you to skip parentheses for indentation. Use the print_list function with format_int (or format_string or format_float, you get the idea), to print a list.

```clojure
> (= x ‘(4 8 15 16 23 42));;
> (= y (tail x));;
> (= z y);;
> (print_list format_int (tail z));;
[15,16,23,42]
```

By allowing heterogeneous lists, Superscript allows exploratory programming with the strength of static type inference. All lists are lists of type SomeList of SomeType. In order to use the head of a list (or any individual element) in another computation, the result of calling head on the list must be annotated with a specific type (or dynamic cast) in order for type inference to work. In the below example, the result of head must be annotated to be an “int” in order to be passed to string_of_int, and to print the resulting string.

```clojure
> (prn (string_of_int (int (head '(4 8 15 16 23 42)))));;
4
```

So the last few things we will teach you how to go through before we send you off to the language reference manual are booleans and lists.

So let’s try a simple if statement.

```clojure
> (if (is 0 0) 1 2);;
>> 1

> (if (isnt 0 0) 1 2);;
>> 2
```

We can use is and isnt for returning a boolean value which is fed into the if statement, we can also use standard comparable functions as well (<, >, <=, >=). These equality and comparison operators take 2 arguments which must be of the same type, such as int and int, or string and string. We also have logical operators such as and, or & not.

Now before we send you off into the language reference manual, we want to cover the last thing. Throughout this tutorial, we have been introducing you to the function and the very simple syntax behind Superscript. Most of the elements you see in Superscript are functions, and as such are easy to create yourself. To create a function, much like Javascript, all you have to do is assign an anonymous function to an identifier, and then you can call the identifier to run the function.

```clojure
> (= function_name (fn (arg1 arg2 … argn) (function_body));;
```

```clojure
> /* Note the use of infix below */
> (= fib (fn (x) (if (is x 0) 0 (if (is x 1) 1 (+ (fib {x - 1}) (fib {x -2} ))))));;
> (prn (string_of_int (fib 8)));;
21
```

And there you have it, you can now define and create your own functions in Superscript and run them like the way you learned. We have all sorts of more cute tricks and goodies inside the Language Reference Manual, but don’t want to inundate you now, and instead would love to see you start writing programs. The LRM is also written as a semi-tutorial, so don’t hesitate to just go through it section by section.

Happy hacking! (John McCarthy is probably smiling)

## 3. Language Reference Manual

### 3.1 Introduction

This is a language reference manual updated to reflect the current state of Superscript at the first release plus the geb compiler.

### 3.2 Lexical Convention

#### 3.2.1 Reserved Keywords

Superscript has a set of reserved keywords, which cannot be used as identifiers. Superscript also comes with built-in functions which generate specific Javascript code when invoked. It also has a standard library, written in Superscript, which is automatically imported (concatenated into the beginning of any user-defined code).



| Reserved Keywords | Built-in functions | Standard Library Functions  |
| ------------- |:-------------:| -----:|
| true, false, fn, if, eval, do      | +, -, *, /, +., -., *., /., mod, is, isnt, <, <=, >, >=, and, or, not, ++, do, eval, call, dot, module, cons, head, tail, pr, prn, int_of_string, string_of_float, float_of_string, string_of_boolean, boolean_of_string, string_of_int, int, float, boolean, string, list, type | identity, length, nth, first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth, last, map, fold_left, fold_right, filter,  append, reverse, drop, take, intersperse, member, zipwith, zipwith3, zip, unzip, format_boolean, format_int, format_string, format_float, stringify_list, format_boolean2d, format_int2d, format_float2d, format_string2d, print_list |

#### 3.2.2 Punctuation

##### 3.2.2.1 Comments
Comments in Superscript are C-style:

```clojure
>/* this is a comment */
```

##### 3.2.2.2 Double semicolon
A program in Superscript is a list of expressions, and the expressions are separated by double semicolons:
```clojure
> ( prn "hello" );; ( prn "world" );;  ( prn "people");;
hello
world
people
```

##### 3.2.2.3 Parentheses

Parentheses must enclose the representation of a list, which must be quoted if it is not intended to be a function call:

```clojure
> '( 1 2 3 );;
>> ‘(1 2 3)
```

Parentheses must be used to wrap a function definition, to wrap its arguments, and to wrap the function body. We used the Scheme lambda construction but removed the keyword lambda and replaced it with fn similar to Arc to encourage constant use of lambda functions, similar to Javascript function assignment:

```clojure
> (fn (x y) (+ x y));;
```

Parentheses must be used to wrap any function call, including a standard library function call or built-in operation.

```clojure
> (average 2 4);;	/*average is a function that returns the average value of its parameters*/
3

> (if true 1 2);;
1
```

All unquoted lists are interpreted as function calls. Hence, parentheses cannot be used to wrap an unquoted list that is not a function call. The following is a syntax error, and cannot be evaluated as you are trying to evaluate the operator 1 on the arguments 2 and 3:

```clojure
> (1 2 3);;
Line:1 char:1..6: Syntax error. Function call on inappropriate object.
```

##### 3.2.2.4 Curly Braces

Braces can be used to wrap an infix expression and to explicitly indicate the order of operations and associativity. See Section 3.8 for more information about syntactic sugar and Syntax Modifications that allow a more imperative programming  syntax. Infix expressions can be used in both Superscript and  Caramel syntax. See the section on Infix Expressions below.

```clojure
> {1 + 2};;
>> 3
```

### 3.3 Data Types

#### 3.3.1 Type Inference

Superscript uses static type inference, based on the Hindley-Milner algorithm[12], to evaluate the type and value of any legal expression and to check that expressions satisfy the proper data type in all function calls. Our compiler will flag any inconsistent data type in function calls as a type incompatibility error. Based on this type inference, the Superscript compiler implements error handling and prints the appropriate error messages to the user.

Superscript’s standard library provides a set of functions to let user convert between different data types.

#### 3.3.2 Atomic Data Types

The following are atomic (non-list) data types in Superscript.

##### 3.3.2.1 Numerical types

We use type inference to avoid NaN errors common in Javascript, since non-numerical values cannot be used in arithmetic functions.

###### Integers
Superscript allows integers, which may be manipulated by integer arithmetic using the standard +, -, /, * operators. Integers are sequences of digits containing no decimals. Integers are considered accurate up to 15 digits.

```clojure
> 42;;
>> 42

> (type 42);;
>> ‘int’
```

###### Floating Points
Superscript allows floating point values and requires the use of floating point specific operators to perform floating point arithmetic. These operators are the int operators followed by ‘.’ (+., -., /., *.). Floating points must include at least one digit and a decimal, satisfying the regular expression: ['0'-'9']*'.'['0'-'9']+ | ['0'-'9']+'.'['0'-'9']*

```clojure
> 42.0;;
42.0

> (type 42.0);;
‘float’
```

##### 3.3.2.2 Strings

Superscript supports UTF-8 strings as a way to represent textual data. Like Javascript, a single character is treated as a single character String. There is no type for chars. Print always prints to console and returns the unit datatype.

```clojure
> “Hello, world!”;;
>> “Hello, world!”

> (type “Hello, world!”);;
>> ‘string’
```


##### 3.3.2.3 Symbols

Symbols, or identifiers, represent programmer-defined objects. They are containers for storing data values, and they return the value assigned to them. An identifier name must start with a letter, followed by any number of letters, digits, or underscores, and is defined by the regular expression: ['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_' ]*

```clojure
> (= a 42);;
42

> a;;
42
```

3.3.2.4 True/False/Nil

Superscript has a boolean true and false value.

```clojure
> (type true);;
‘boolean’

> (type false);;
‘boolean’
```

Superscript also has a nil value which is the null datatype.  It is equivalent to the empty list.

```clojure
> nil;;
nil

> ‘();;
nil
```

#### 3.3.3 Non-atomic Data Types

##### 3.3.3.1 Lists

Multiple atoms enclosed parentheses are also called lists. An unquoted list is a function call, where the first element is the function name, and the other values are the parameters (See 3.3.2). For instance, `(a b c d e)` calls the function a with the arguments b, c, d, and e. It is a syntax error to write an expression that is an unquoted list, such as `(5 4 8)`, where the first element is not a function name.

In order to use `(a b c d e)` as a list, rather than function call, you must quote the list:  `‘(a b c d e)`  is a list of the elements a, b, c, d, and e.

```clojure
> ‘(1 2 3);;
‘(1 2 3)

> (type ‘(1 2 3));;
‘(sometype) list ’
```

##### 3.3.3.2 Functions

Call a function using an unquoted list, where the first argument is the function name, the following arguments are the parameters passed into the function call, and all the parameters are passed in by value, in the format of `( function_name arg1 arg2 arg3…)`:

```clojure
> (+ 1 2 3 4);;
10
```

Define an anonymous function in the following way, using the ‘fn’ keyword: `(fn (optional_args) expression)`, where optional_args is 0 or more formal arguments separated by spaces, and enclosed by parentheses; the body of the function is a single expression enclosed by parentheses; and the entire expression is surrounded by parentheses. A function definition returns a function data type. In Superscript, functions are a data type much like lists and atoms.

```clojure
> (fn (x y) (/(+ x y) 2));;
- : int -> int -> int
```

We can bind an anonymous function declaration to a name using the `=` function, which evaluates right-to-left. Don’t be scared by the prefix notation, as the same may be expressed using infix notation, covered in Section 8, Syntax Modifications.

Anonymous function declaration, which is then bound to the name `average`:

```clojure
> (= average (fn (x y) (/ (+ x y) 2)));;
val average : int -> int -> int
```
Function call:

```clojure
> (average 20 10);;
15
```

### 3.4. Operators and Built-in Functions

#### 3.4.1. Basic Assignment

The ‘=’ operator takes an even number of arguments, and assigns to the first of each pair the value of the second of each pair. This is a basic assignment that sets the value of a to 5, c to 6, and d to 7:

```clojure
> (= a 5 c 6 d 7);;
val a : int
val c : int
val d : int

> (= x 5);;
val x : int
```

Basic assignment is applicable to all datatypes.

#### 3.4.2. Arithmetic Operators

Before we go into arithmetic operators, note that we will be using prefix notation here. Superscript allows infix notation as well under the Infix Expression section.

Superscript offers several Standard Library arithmetic functions. These include both integral and floating addition, subtraction, multiplication, division; as well as the modulo of two ints. These functions are used as follows.

###### Addition, Subtraction, Multiplication, Division

You can add at least 2 arguments, a to b, or add an unlimited amount of arguments together. The following examples show function calls to arithmetic operations.

```clojure
(+ a b)

(+. a b c d e f g h i j k l m n o p …)
```

Both of the above expressions are unquoted lists where the first element is a function call to the addition function, done on the other elements in the list. The first example uses the integer operator (+), and the second, the floating operator (+.). Addition, Subtraction, Multiplication, and Division can be applied to two or more arguments.

All arguments to arithmetic functions must be numerical. They will be evaluated left to right.

###### Modulo

You can call a modulus function between TWO integers a and b, this will return the remainder of a / b.

```clojure
> (mod 5 6)
5
```

#### 3.4.3. Boolean Operators

Superscript’s Standard Library contains logical functions to evaluate boolean expressions.  

##### 3.4.3.1. Logical NOT Function

‘not’ is a Standard-Library function that takes one boolean expression as its argument, and negates the value of that expression.

```clojure
> (not true);;
false

> (not false);;
true
```

##### 3.4.3.2 Logical AND / OR

Superscript’s Standard Library supports logical AND/OR functions, using ‘and’ and ‘or’ keywords. AND/OR must be used with two boolean expressions as arguments.

```clojure
> (and true false);;
false

(or true true);;
> true
```

##### 3.4.3.3 Equality and Inequality

The ‘is’ function is an equality comparison that may be applied on atomic constants: ints, floats, and strings. The ‘isnt’ function compares two ints, floats, or strings for inequality. The arguments must be of the same type, for instance, string and string, or int and int.

```clojure
> (is “a” “b”);;
false

> (is 1 1);;
true

> (is 1 2);;
false

> (isnt “a” “b”);;
true
```

#### 3.4.4 Relational Comparison operators

 These relational comparison operators can be used for ints, floats, and strings. They take two expressions, which must be of the same type, as arguments:

Examples:
```clojure
(> a b);;
(< a b);;
(>= a b);;
(<= a b);;
```

Try it out:
```clojure
> (> 5 4);;
true
```

#### 3.4.5 String concatenation

String concatenation is done using the “++”’ function. It operates on a list of strings and concatenates them all from left to right.

```clojure
> (++ “hello” “ ” “world” “ superscript” “ is” “ here”);;
“hello world superscript is here”
```

#### 3.4.6 prn/pr Function

Print always prints to console. Its type is string -> unit. Hence you must pass it one or more  strings as argument.

```clojure
> (prn “Hello, world” “!”);;
Hello, world!

> (prn (string_of_int 5));;
5

> (type (prn 5));;
- : string -> unit
```

#### 3.4.7 Infix Expressions

Infix expressions may be used in Superscript if you enclose them in curly braces: {expression};; Example usage is below:


1. Basic arithmetic in infix expressions will be evaluated in the standard order of operations. To parenthesize within infix expressions, use curly braces:
```clojure
    { 1 * {2 - 4} / 4 };;
```

2. To call a function with an infix expression as argument, use parentheses around the entire function call, as per standard Superscript function calling syntax:
```clojure
		( foo {1 + 3 + 3 * 4} );;
```

3. To call functions from within an infix expression and manipulate its return values, call the functions as you would normally and remember to enclose all infix  expression in curly braces.
```clojure
		{ 1 + 2 + (foo 3) + ( baz {3 + 4} ) };;
```

### Footnotes

[0]: http://www.hanselman.com/blog/JavaScriptIsAssemblyLanguageForTheWebPart2MadnessOrJustInsanity.aspx
[1]: http://rauchg.com/2014/7-principles-of-rich-web-applications
[2]: https://www.destroyallsoftware.com/talks/wat
[3]: http://languagelog.ldc.upenn.edu/myl/ldc/llog/jmc.pdf
[4]: ttp://www.paulgraham.com/arc.html
[5]: http://cs.princeton.edu/courses/archive/spr11/cos333/lectures/17paradigms/sort.lisp
[6]: http://www.braveclojure.com/
