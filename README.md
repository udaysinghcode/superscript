# Holy Scriptjure

## Proposal

### Motivation
Over the last several years, the web has shifted in both terms of interaction
design and web browser functionality. The modern web has shifted from static
pages from the past thus demanding a [system][1] which provides reactions based
on data changes. This necessity for real time interaction has lead to the
development of single page applications and shift in the world of rapid
prototyping from monolithic web frameworks to a clear separation between single
page applications and APIs.

The development of Node.js, a Javascript runtime built on Chrome's V8 Javascript
engine has led to more developers embracing Javascript as a viable language for
backend development. Despite its popularity however, the syntax of Javascript,
the mutability of objects, and its complexity regarding callbacks makes it
slightly difficult to write code where the user is completely aware of their
code and its side effects.

There is a direct correlation between number of lines of code and number of bugs
generated. Javascript's method of handling closures and anonymous functions often
times can lead to functions that are difficult for not just the programmer to
write, but the reader to read. 

Under the assumption that code is written for humans to read, and
machine to execute, the importance for a programmer to understand the full
semantic structure of their code is not something just important to Javascript
but particularly important when prototyping web servers, RESTful APIs, and
asynchronous Node.js requests.

S-expressions provide users a method of decreasing the number of
lines of code while simultaneously having the user think through the execution
of their code. Additionally, Javascript's lack of immutability often can
generate dangerous side-effects within methods, which can prevent the programmer
from having a clear sense of the distinction between what they think their code
is doing and what it is actually doing.

### Language Description

### Syntax Examples

(= i 0) 

#### Intentional Syntax

#### Appendix

### Footnotes

[1]: http://rauchg.com/2014/7-principles-of-rich-web-applications/
