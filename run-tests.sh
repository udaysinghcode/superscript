#!/bin/bash
mkdir build
eval `opam config env`; ocamlfind ocamlc -package oUnit -linkpkg -o build/test src/test.ml
./build/test
