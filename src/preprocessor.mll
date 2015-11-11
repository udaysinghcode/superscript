{ type token = EOF | Fparen of string | Fdecl of string }

rule token = parse
	| eof { EOF }
	| "fn"' '*'('	as lxm { Fdecl(lxm) }
	| "def"' '*['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_' '-']*' '*'(' as lxm { Fdecl(lxm) }
	| ['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_' '-']*' '*'(' as lxm { Fparen(lxm) }
	| _ { token lexbuf }
{
	(* f{ a b c d e } *)
	(* def fac(n) (hihihi) *)
	(* fn(a b c) (hi there you) *)
	(* fn()(5) *)

	(* def fac(n)
		if {n <= 1}
		1
		{n * fac{n - 1}}
	*)
	let () = 
	let oc = open_out "program.ss" in	
	let lexbuf = Lexing.from_channel stdin in
	let wordlist =
	  let rec next l  = match token lexbuf with
		EOF -> l
		| Fdecl(s) -> next(s :: l)
		| Fparen(s) -> 
			let args = String.index s '(' + 1 in
			let s = "(" ^ (String.sub s 0 (args - 1)) ^ " "
    			(* let lenToEnd = (String.length s - args) in *)     
  			(* let s = "(" ^ (String.sub s 0 (args - 1)) ^ " " ^ (String.sub s args lenToEnd) *)
			in next(s :: l)
		in next []
	in
	(* List.iter print_endline wordlist *)
	let rec print_program oc = function
	| [] -> ()
	| hd::tl -> Printf.fprintf oc "%s\n" (hd); print_program oc tl
	
	in
	print_program oc wordlist; List.iter print_endline wordlist;
}

