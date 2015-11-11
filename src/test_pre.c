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

  ; this should not work since the arguments to if are not indented properly
SUM ((f a b)	
	if{N < 0}
	f(a b)
	{1 + 2})

; the sum function with corrected indenting
SUM ((f a b)	
	if{N < 0}
		f(a b)
		{1 + 2})

