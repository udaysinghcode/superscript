open Ast;;
open Type_infer;;
open Generator;;
open Scanner;;
open Unix;;
open Message;;
open Printf;;
open Array;;

exception Fatal_error of string
let fatal_error msg = raise (Fatal_error msg)

(** [exec_cmd ctx cmd] executes the toplevel command [cmd] in
    the given context [ctx]. It returns the new context. *)
let rec exec_cmd ctx = function
    | Assign(el) ->
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
	     		
			in let ty =
					(* type check [e], and store it unevaluated! *)
			    try (Ast.rename (Type_infer.type_of ctx e))
			
		    	    with  
			      (* Error: RHS of assignment contained an undeclared variable *)
			      | Type_infer.Unknown_variable (msg, id) -> (

				   (* Case: unknown var != LHS of assignment --> immediately reject *)
				   if (String.compare x id) != 0 then
					(Type_infer.unknown_var_error("Unknown variable " ^ id) id)

				   (* Case: unknown var on RHS == LHS of assignment --> allow if RHS is a recursive fdecl *)
				   else 
				   (

				     (* Assume RHS is recursive fn definition: 
					store (x, TParam _) into the context to avoid unknown var errors *)

				     let tparam = Type_infer.fresh() in
				     let ctx = (x,tparam)::ctx in
				     let recfun = Ast.rename(Type_infer.type_of ctx e) in

				     (* Check that type of RHS was indeed a function definition *)

				     let ty = match recfun with
					| TArrow _ -> recfun
					| _ -> Type_infer.unknown_var_error("Unknown variable " ^ x) x
				     in
					ty
				  )
         		   )
		      in
		        print_endline ("val " ^ x ^ " : " ^ string_of_type ty);
		(x,ty)::(addCtx ctx tl)
	in
	(addCtx ctx defs)
    | _ as e ->
      (* type check [e], evaluate, and print result *)
      let ty = 
        try Ast.rename (Type_infer.type_of ctx e) with 
        Type_infer.Unknown_variable (msg, id) ->  raise (Failure (msg))

      in
	     print_string ("- : " ^ string_of_type ty) ;
             print_newline ();
	ctx
;;

(** [exec_cmds ctx cmds] executes the list of 
    expressions [cmds] in the given context [ctx].
    It returns the new context. *)
let exec_cmds ctx cmds =
   try
       List.fold_left (exec_cmd) ctx cmds
   with
       | Type_infer.Invalid_args msg -> raise (Failure (msg))
       | Type_infer.Type_error msg -> raise (Failure (msg))
;;

(** [load_file f] loads the file [f] and returns the contents as a string. *)
let load_file f =
  let ic = open_in f in
  let n = in_channel_length ic in
  let s = Bytes.create n in
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

(** [exec_file ctx fn] executes the contents of file [fn] in
    the given context [ctx]. It returns the new context. *)
let exec_file ctx (sysargs) = 
  let filename = sysargs.(1) in
  let filecontents =
	if filename = "-s" then 
		if Array.length sysargs != 3
		  then
		   raise(Failure "Usage: ./geb [file] or ./geb -s [input] ")
		  else
			sysargs.(2)
	else
		if Array.length sysargs != 2
		  then
		   raise(Failure "Usage: ./geb [file] or ./geb -s [input] ")
		else
			load_file filename
      in
         let lexbuf = Message.lexer_from_string 
		(let stdlib = load_file "stdlib.ss" in
			stdlib ^ filecontents) in
  let program = 
    try 
	 Parser.program Scanner.token lexbuf
    with
     | Failure("lexing: empty token") -> print_position lexbuf "Lexing: empty token"; exit (-1)
     | LexingErr msg -> print_position lexbuf msg; exit (-1)
     | Parsing.Parse_error -> print_position lexbuf "Syntax error occurs before"; exit (-1)

   in
   (* Perform type checking, by executing exec_cmds. Print all identifiers & types *)
       ignore(exec_cmds (
	    (* Add types for built-in functions to the context *)
		List.map (fun x -> (x, Generator.arrow_of(x))) 
	        (Generator.get_generatable_fnames program)) 
	     program); 

       let prog = Generator.generate_prog program in
          write prog;
              print_endline (String.concat "\n" (funct (Unix.open_process_in "node a.js"))) 
  
(** The main program. *)
let main = 
	if(Array.length Sys.argv < 2) then
		raise(Failure "Usage: ./geb [file] or ./geb -s [input] ")
	else
	     exec_file [] (Sys.argv)
