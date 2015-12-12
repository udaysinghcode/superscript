open Ast;;

open Generator;;
open Scanner;;
open Unix;;
open Stringify;;

let load_file f =
  let ic = open_in f in
  let n = in_channel_length ic in
  let s = String.create n in
  really_input ic s 0 n;
  close_in ic;
  (s) ;;


let rec funct foo =
  try 
    let l = input_line foo in 
    match l with 
    | _ -> l::(funct foo)
  with End_of_file -> [] ;;

let write stuff =
  let oc = open_out "a.js" in
    output_string oc stuff;
    close_out oc;
;;

let filename = Sys.argv.(1) in
let lexbuf = Lexing.from_string (if filename = "-s" then Sys.argv.(2) else load_file filename) in
let expression = Parser.program Scanner.token lexbuf in
let prog = Generator.generate_prog expression in
write prog;
print_endline (String.concat "\n" (funct (Unix.open_process_in "node a.js")))
