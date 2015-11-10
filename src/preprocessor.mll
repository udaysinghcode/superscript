{ type token = EOF | Fparen of string | Fdecl of string | Word of string }

rule token = parse
	| eof { EOF }	
	| [' ' '\t' '\r' '\n'] as lxm { Word(String.make 1 lxm) }
	| _ as lxm { Word(String.make 1 lxm) }
	| "fn"' '*'('	as lxm { Fdecl(lxm) }
	| "def"' '*['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_' '-']*' '*'(' as lxm { Fdecl(lxm) }
	| ['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_' '-']*' '*'(' as lxm { Fparen(lxm) }
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
	let (wordlist, charBuff)  =
	  let rec next l buff  = match token lexbuf with
		EOF -> (l, buff)
		| Word(s) -> next l (s::buff)
		| Fdecl(s) -> let prevChars = (String.concat "" (List.rev buff)) in
				next((prevChars ^ s) :: l)[]
		| Fparen(s) -> 
			let args = String.index s '(' + 1 in
			let s = "(" ^ (String.sub s 0 (args - 1)) ^ " " in
			let prevChars = (String.concat "" (List.rev buff)) in
				next((prevChars ^ s) :: l) []
		in next [][]
	in

	let program = String.concat "" (List.rev wordlist) in
(*	let rec print_program oc = function
	| [] -> ()
	| hd::tl -> Printf.fprintf oc "%s\n" (hd); print_program oc tl
	
	in
	print_program oc program; 
*)
	Printf.fprintf oc "%s\n" program;
	close_out oc;

	(* List.iter print_endline (List.rev wordlist) *);
}

