open Ast;;
open Generator;;
open Scanner;;
open Unix;;

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
	("Hello World program", "(prn \"Hello World!\");;", [Eval("prn", [String("Hello World!")])], "Hello World!") ;
	("Curly expression produces expected ast", "{5 + 3};;", [Binop(Int(5), Add, Int(2))], "place holder") ;
] ;;

let unsuccess = ref 0 ;;

List.iter (fun (desc, input, ast, expout) -> 
	let lexbuf = Lexing.from_string input in 
	let expression = Parser.program Scanner.token lexbuf in
	if (ast = expression) then 
		let prog = Generator.generate_prog expression in  (*instead of prog = Generator.generate_prog expr*)
			write prog;	
			(*print_endline (String.concat "" (funct (Unix.open_process_in "node a.js"))) *)
			let actout = String.concat "" (funct (Unix.open_process_in "node a.js")) in
			if  expout = actout then 
				print_endline (String.concat "" [desc; "... SUCCESSFUL"])
			else print_endline (String.concat "" [desc; "... UNSUCCESSFUL Compilation....\n\ninput:\n"; input; "\nexpected out:\n"; expout; "\n\nActual out:\n"; ]);
			(*print_endline prog*)
		else (print_endline (String.concat "" [desc; "... UNSUCCESSFUL Ast creation"]) ; unsuccess := !unsuccess+1 ) ) tests ;;


if !unsuccess = 0 then exit 0 else exit 1 ;;