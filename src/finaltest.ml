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
  ("prn function should log to stdout", "(prn \"Hello World!\");;", [], "Hello World!") ;
  ("str_of_int function should make string from int", "(prn (str_of_int 10));;", [], "10") ;
  ("str_of_bool function should make string from boolean", "(pr (str_of_bool true));;(pr (str_of_bool false));;", [], "truefalse") ;
  ("type function should return type of string", "(prn (type \"Hello\"));;", [], "string") ;
  ("type function should return type of int", "(prn (type 10));;", [], "int") ;
  ("type function should return type of float", "(prn (type 2.2));;", [], "float") ;
  ("type function should return type of boolean", "(prn (type true));;", [], "boolean") ;
  ("type function should return type of list", "(prn (type '(10 20)));;", [], "list") ;
  ("type function should return type of function", "(prn (type (fn (x) (prn x))));;", [], "function") ;
  ("assignment operator", "(= foo \"Hello\");;(prn foo);;", [], "Hello") ;
  ("user defined functions", "(= foo (fn (x) (prn x)));;(foo \"Bar\");;", [], "Bar") ;
	("curly infix arithmetic expression", "(prn (str_of_int {5 + 3}));;", [], "8") ;
  ("+ operator with no args should return 0", "(prn (str_of_int (+)));;", [], "0") ;
  ("* operator with no args should return 1", "(prn (str_of_int (*)));;", [], "1") ;
  ("prefix integer add", "(prn (str_of_int (+ 1 2 3 4)));;", [], "10") ;
  ("prefix integer sub", "(prn (str_of_int (- 10 2 3)));;", [], "5") ;
  ("prefix integer mult", "(prn (str_of_int (* 1 2 3 4)));;", [], "24") ;
  ("prefix integer div", "(prn (str_of_int (/ 10 2 (- 5))));;", [], "-1") ;
  ("prefix float add", "(prn (str_of_int (+ .1 .2 .3 .4)));;", [], "1") ;
  ("prefix float sub", "(prn (str_of_int (- 5.0 .2 .3)));;", [], "4.5") ;
  ("prefix float mult", "(prn (str_of_int (* 1. 2. 3. 4.)));;", [], "24") ;
  ("prefix float div", "(prn (str_of_int (/ 10. 2. (- 5.))));;", [], "-1") ;
  ("comparing ints with is func", "(pr (str_of_bool (is 1 1)));;(pr (str_of_bool (is 1 2)));;", [], "truefalse") ;
  ("comparing floats with is func", "(pr (str_of_bool (is 1.0 1.)));;(pr (str_of_bool (is .1 .2)));;", [], "truefalse") ;
  ("comparing bools with is func", "(pr (str_of_bool (is true true)));;(pr (str_of_bool (is false true)));;", [], "truefalse") ;
  ("comparing strings with is func", "(pr (str_of_bool (is \"hello\" \"world\")));;(pr (str_of_bool (is \"world\" \"world\")));;", [], "falsetrue") ;
  ("empty list should be nil", "(prn (str_of_bool (is '() nil)));;", [], "true") ;
  ("head function should return head of list", "(prn (head '(\"foo\" \"bar\")));;", [], "foo") ;
  ("tail function should return tail of list", "(prn (head (tail '(\"foo\" \"bar\"))));;", [], "bar") ;
  ("let function should make temp variable for current statement", "(let x \"foo\" (prn x));;", [], "foo") ;
  ("let function should shield temp variable from other statements", "(= x \"bar\");;(let x \"foo\" (pr x));;(pr x);;", [], "foobar") ;
  ("nested let function should override same outer temp variable", "(let x \"foo\" (let x \"bar\" (prn x)));;", [], "bar") ;
  ("++ operator concatenates strings", "(prn (++ \"foo\" \"bar\" \"orange\"));;", [], "foobarorange") ;
  ("different outer temp variable should be available in nested let", "(let y \"foo\" (let x \"bar\" (prn (++ x y))));;", [], "barfoo") ;
  ("< operator should compare ints", "(pr (str_of_bool (< 9 10)));;(pr (str_of_bool (< 11 10)));;", [], "truefalse") ;
  ("if statements", "(if true (pr \"foo\") (pr \"bar\"));;(if false (pr \"foos\") (pr \"bars\"));;", [], "foobars") ;
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
			print_endline (String.concat "" ["\027[38;5;2m"; desc; ": "; input; "... SUCCESSFUL. Output: "; actout; "\027[0m"])
		else print_endline (String.concat "" ["\027[38;5;1m"; desc; ": "; input; "... UNSUCCESSFUL Compilation....\ninput: "; input; "\nexpected out: "; expout; "\nActual out: "; actout; "\027[0m"]);
		(*print_endline prog*)
	else (print_endline (String.concat "" ["\027[38;5;1m"; desc; ": "; input; "... UNSUCCESSFUL Ast creation. Generated Ast: "; Stringify.stringify_prog expression; " Required Ast: "; Stringify.stringify_prog ast; "\027[0m"]) ; unsuccess := !unsuccess+1 ) ) tests ;;

if !unsuccess = 0 then exit 0 else exit 1 ;;