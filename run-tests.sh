#!/bin/bash

ocamlfind ocamlc -package oUnit -linkpkg -o test test.ml
./test
