open Ast;;
open Generator;;
open Scanner;;
open Unix;;
open Stringify;;

(*  File Foo_ast:
	let asts = Lit(2)  *)


(*ocamlc -o final unix.cma scanner.cmo parser.cmo finaltest.cmo  *)


(*let _ = 
	let lexbuf = Lexing.from_string "2" in
	let expr = Parser.expr Scanner.token lexbuf in
	- probably use shell scrpit to pass a bunch of file (code) as arguments.
	- lex


	-- lexbuf is the code
	print_endline (if (Lit(2) = expr ) then "success" else "nope" ) ;;   *)
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

let tests = [
  ("prn function: (prn \"Hello World!\");;", "(prn \"Hello World!\");;", [], "Hello World!") ;
  ("str_of_int function: (prn (str_of_int 10));;", "(prn (str_of_int 10));;", [], "10") ;
  ("type function: (prn (type \"Hello\"));;", "(prn (type \"Hello\"));;", [], "string") ;
  ("function literal: (prn (type (fn (x) (prn x))));;", "(prn (type (fn (x) (prn x))));;", [], "function") ;
  ("assignment operator: (= foo \"Hello\");;(prn foo);;", "(= foo \"Hello\");;(prn foo);;", [], "Hello") ;
  ("user defined functions: (= foo (fn (x) (prn x)));;(foo \"Bar\");;", "(= foo (fn (x) (prn x)));;(foo \"Bar\");;", [], "Bar") ;
	("curly infix arithmetic expression: (prn (str_of_int {5 + 3}));;", "(prn (str_of_int {5 + 3}));;", [], "8") ;
  ("prefix integer add: (prn (str_of_int (+ 1 2 3 4)));;", "(prn (str_of_int (+ 1 2 3 4)));;", [], "10") ;
  ("prefix integer sub: (prn (str_of_int (- 10 2 3)));;", "(prn (str_of_int (- 10 2 3)));;", [], "5") ;
  ("prefix integer mult: (prn (str_of_int (* 1 2 3 4)));;", "(prn (str_of_int (* 1 2 3 4)));;", [], "24") ;
  ("prefix integer div: (prn (str_of_int (/ 10 2 -5)));;", "(prn (str_of_int (/ 10 2 -5)));;", [], "-1") ;
] ;;

let unsuccess = ref 0 ;;

List.iter (fun (desc, input, ast, expout) -> 
	let lexbuf = Lexing.from_string input in 
	let expression = Parser.program Scanner.token lexbuf in
	if (ast = expression || ast = []) then 
		let prog = Generator.generate_prog expression in  (*instead of prog = Generator.generate_prog expr*)
		write prog;	
			(*print_endline (String.concat "" (funct (Unix.open_process_in "node a.js"))) *)
		let actout = String.concat "\n" (funct (Unix.open_process_in "node a.js")) in
		if  expout = actout then 
			print_endline (String.concat "" [desc; "... SUCCESSFUL. Output: "; actout])
		else print_endline (String.concat "" [desc; "... UNSUCCESSFUL Compilation....\n\ninput:\n"; input; "\nexpected out:\n"; expout; "\n\nActual out:\n"; ]);
		(*print_endline prog*)
	else (print_endline (String.concat "" [desc; "... UNSUCCESSFUL Ast creation. Generated Ast: "; Stringify.stringify_prog expression; " Required Ast: "; Stringify.stringify_prog ast]) ; unsuccess := !unsuccess+1 ) ) tests ;;

if !unsuccess = 0 then exit 0 else exit 1 ;;