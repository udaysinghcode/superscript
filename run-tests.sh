#!/bin/bash

`opam config env`; ocamlfind ocamlc -package oUnit -linkpkg -o test test.ml
./test
