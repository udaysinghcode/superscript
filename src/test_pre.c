; To test the preprocessor:
; ocamllex preprocessor.mll
; ocamlc -o preprocessor preprocessor.ml
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

