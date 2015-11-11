	; To test the preprocessor:
; ocamllex preprocessor.mll
; ocamlc -o preprocessor str.cma preprocessor.ml
; ./preprocessor < test_pre.c
; output is in "program.ss" 
def fac(n)
     if {n <= 1}
          1
          {n * fac{n - 1}}

def fac(n)
  if {n <= 1}
   f(a b c)
   {n * fac{n - 1}}

SUM ((f a b)	
	if{N < 0}
		f(a b)
		{1 + 2})

SUM ((f a b)	
	if{N < 0}
		f(a b)
		{1 + 2})

