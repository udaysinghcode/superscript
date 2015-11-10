; To test the preprocessor:
; ocamllex preprocessor.mll
; ocamlc -o preprocessor preprocessor.ml
; ./preprocessor < test_pre.c
; output is in "program.ss" 
0
0def fac(n)
4if {n <= 1}
81
8{n * fac{n - 1}}
0
0
0def fac(n)
4if {n <= 1}
8(f a b c)
8{n * fac{n - 1}}
0
0
