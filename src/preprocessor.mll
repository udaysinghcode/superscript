    { type token = EOF | Fparen of string | Fdecl of string | Word of string }
		
    rule token = parse
	| eof { EOF }
	| ['\r' '\n'][' ' '\t']*';' as lxm { Word(lxm) } (* Comments: do not count whitespaces before comments *)	
	| ['\r' '\n'][' ' '\t']* as ws { let spaces = 
					let rec countSp s count index = 
					let len = (String.length s - 1) in
  						if index > len then count
  						else if String.get s index = ' ' then countSp s (count+1)(index+1)
  						else if String.get s index = '\t' then countSp s (count+4)(index+1)
  					else countSp s count (index + 1)
					in countSp ws 0 0
				in
				Word("\n" ^ string_of_int(spaces)) } 
	| _ as lxm { Word(String.make 1 lxm) }
	| "fn"' '*'('	as lxm { Fdecl(lxm) }
	| "def"' '*['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_' '-']*' '*'(' as lxm { Fdecl(lxm) }
	| ['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_' '-']*' '*'(' as lxm { Fparen(lxm) }
{
	let () = 
	let oc = open_out "program.ss" in	
	let lexbuf = Lexing.from_channel stdin in
	let wordlist =
	  let rec next l  = match token lexbuf with
		EOF -> l
		| Word(s) -> next(s::l)
		| Fdecl(s) -> next(s::l)
		| Fparen(s) -> 
			let args = String.index s '(' + 1 in
			let s = "(" ^ (String.sub s 0 (args - 1)) ^ " " in
				next(s::l)
		in next []
	in

	let program = String.concat "" (List.rev wordlist) 
	in	
	Printf.fprintf oc "%s\n" program;
	close_out oc;
}

