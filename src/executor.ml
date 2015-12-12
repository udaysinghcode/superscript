open Ast;;
open Type_infer;;
open Generator;;
open Scanner;;
open Unix;;
open Stringify;;

exception Fatal_error of string

let fatal_error msg = raise (Fatal_error msg)

(** [exec_cmd (ctx, env) cmd] executes the toplevel command [cmd] in
    the given context [ctx] and environment [env]. It returns the
    new context and environment. *)
let rec exec_cmd (ctx, env) = function
   _ as e -> 
      (* type check [e], evaluate, and print result *)
        let ty = (Type_infer.type_of ctx e) in
	(ctx, env)
;;

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
let exec_cmds ce cmds = 
  try 
  List.fold_left (exec_cmd) ce cmds
with
  Type_infer.Type_error msg -> fatal_error (msg)
| Parsing.Parse_error | Failure("lexing: empty token" ) -> 
	fatal_error("Syntax error" ^ "TODO: ERROR MSG")
in 
let expression = Parser.program Scanner.token lexbuf in
        exec_cmds ([], []) expression;
let prog = Generator.generate_prog expression in
write prog;
print_endline (String.concat "\n" (funct (Unix.open_process_in "node a.js")))
