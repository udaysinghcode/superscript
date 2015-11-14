(*  To test the preprocessor:
ocamllex preprocessor.mll
ocamlc -o preprocessor str.cma preprocessor.ml
./preprocessor < test_pre.c
output is in "program.ss" 
TODO: newline must be inserted before first expression of program before preprocessing *)
(* testing indentation using tabs *)
def fac(n)
     if {n <= 1}
          1
          {n * fac({n - 1})}

(* testing indentation using spaces *)
def fac(n)
  if {n <= 1}
   f(a b c)
   {n * fac({n - 1})}



def fac (a)
	if {a is 1}
		1
		0

(* this will not work since args to if must be indented *)
def fac (a)
	if(a b c)

=( fac(n)
  if {n <= 1}
   f(a b c)
   {n * fac({n - 1})})

(* this should not work since the arguments to "if" are not indented properly *)
+ ( f(a b c)	
	if{n < 0}
	f(a b)
	{1 + 2})

(* the above sum (+) function with corrected indenting *)
+ ( f(a b c )
	if{n < 0}
		f(a b)
		{1 + 2})


def fac (a)
    if {a is 1}
        my_func ( 1
            "aa"
            your_func( 2
                "bb"
                3
            )
        )
        if isnt(a 0)
            0
            1
        0
