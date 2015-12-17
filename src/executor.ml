open Ast;;
open Type_infer;;
(* open Generator;; *)
open Scanner;;
open Unix;;

exception Fatal_error of string

type environment = (string * value ref) list
and value = 
    | VInt of int
    | VBool of bool
    | VNil
    | VClosure of environment * expr

let fatal_error msg = raise (Fatal_error msg)

(** [exec_cmd (ctx, env) cmd] executes the toplevel command [cmd] in
    the given context [ctx] and environment [env]. It returns the
    new context and environment. *)
let rec exec_cmd (ctx, env) = function
    | Assign(el) as assignment ->
	let rec gen_pairs l = 
	match l with
		| [] -> []
		| h1::h2::tl -> (h1, h2)::(gen_pairs tl)
		| _::[] -> raise(Fatal_error("=operator used on odd numbered list!"))
	in 
	let defs = (gen_pairs el) in
	let rec addCtx ctx = function
		| [] -> ctx
		| (x,e)::tl -> 
	    		(* convert x from Ast.htype into the actual identifier string *)
	     		let x = match x with
				| Id(s) -> s
				| _ -> raise(Fatal_error("first operand of assignment must be an identifier!"))
	     		in
	     		(* type check [e], and store it unevaluated! *)
	         	let ty = Ast.rename (Type_infer.type_of ctx e) 
        in print_endline ("val " ^ x ^ " : " ^ string_of_type ty) ;
	     			(x,ty)::(addCtx ctx tl)
	in
	(addCtx ctx defs), env 

    | _ as e ->
      (* type check [e], evaluate, and print result *)
      let ty = Ast.rename (Type_infer.type_of ctx e) in
	print_string ("- : " ^ string_of_type ty ^ " = ") ;
	print_newline () ;
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
let program = Parser.program Scanner.token lexbuf in
	let types = fst(exec_cmds ([], []) program) in
	(*PRINTING ALL IDENTIFIER AND TYPES from CTX *)
	ignore(print_endline "\nIdentifier & Type");
	List.iter(fun a -> ignore(print_string ((fst a) ^ ": ")); 
		let ty = Ast.rename(snd a) in
		print_endline(string_of_type ty)) types; ignore(print_string "\n");
let prog = Generator.generate_prog program in
write prog;
print_endline (String.concat "\n" (funct (Unix.open_process_in "node a.js")))
