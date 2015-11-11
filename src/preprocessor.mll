{ 
type token = EOF | Fparen of string | Fdecl of string | Word of string | Comment | StdFn of string | LineBreak
let curIndent = Stack.create();;
Stack.push (-1) curIndent;;
let rec countSp s count index = 
	 let len = (String.length s - 1) in
		if index > len then count
			else if String.get s index = ' ' then countSp s (count+1)(index+1)
			else if String.get s index = '\t' then countSp s (count+8)(index+1)
		else countSp s count (index + 1)
}
let fncall = ['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_' '-']*' '*'('

rule token = parse
	| eof { EOF }
	| "\n\n" { let parens = 
			let rec closeParens s stack = 
				let top = Stack.top stack in
					if (top == -1) then (s ^ ";;\n")  
					else (ignore (Stack.pop stack); closeParens (")" ^ s) stack)
		in closeParens "" curIndent
		in Word(parens) }
	| ['\n' ' ' '\t']*';'[^'\n''\r']* { Comment } (* Comments will be ignored *)
	| '\n'[' ' '\t']*("if" | "for" | "do" | "while" ) as lxm { let spaces = countSp lxm 0 0 in
									   ignore(Stack.push spaces curIndent); StdFn(lxm) }
	| _ as lxm { Word(String.make 1 lxm) }
	| '\n'[' ' '\t']* as ws { let spaces = 
					countSp ws 0 0 in
				if(spaces > Stack.top curIndent) then ( Word(ws))
				else if (spaces < Stack.top curIndent) then (ignore(Stack.pop curIndent); Word(")" ^ ws))
				else Word(");;" ^ ws) }
	| "fn"' '*'('	as lxm { Fdecl(lxm) }
	| "def"' '*['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_' '-']*' '*'(' as lxm { let spaces = countSp lxm 0 0 in
										ignore(Stack.push spaces curIndent); Fdecl(lxm) }
	| [' ' '\t']*fncall as lxm { Fparen(lxm) }
{
	let () = 
	let oc = open_out "program.ss" in	
	let lexbuf = Lexing.from_channel stdin in
	
	let wordlist =
	  let rec next l  = match token lexbuf with
		EOF -> l
		| Comment -> next(l)
		| LineBreak -> next("\n" :: l)
		| Word(s) -> next(s::l)
		| Fdecl(s) -> next( ("( " ^ s) :: l)
		| StdFn(s) -> next( ("( " ^ s) :: l)
		| Fparen(s) -> 
			let args = String.index s '(' + 1 in
			let s = "(" ^ (String.sub s 0 (args - 1)) ^ " " in
				next(s::l)
		in next []
	in let program = String.concat "" (List.rev wordlist) 
	in let lines = Str.split (Str.regexp "\n") program
	


	in ignore(List.iter (fun a -> print_endline a) lines);
	Printf.fprintf oc "%s\n" program;
	close_out oc;
}

