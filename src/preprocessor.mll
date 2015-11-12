{ 
type token = EOF | String of string | Fparen of string | Fdecl of string | Word of string | Comment | StdFn of string | LineBreak 

(* Store the indentation of added left parens using a stack *)
let curIndent = Stack.create();;
Stack.push (-1) curIndent;;  (* mark bottom of stack with -1 *)

(* Sentinel to track whether a new expression has started; if not then do not terminate with ";;" *)
let noexpr = 0;;

(* Counts continuous whitespace in string s, starting at the given index and count *)
let rec countSp s count index = 
	 let len = (String.length s - 1) in
		if index > len then count
			else if String.get s index = ' ' then countSp s (count+1)(index+1)
			else if String.get s index = '\t' then countSp s (count+8)(index+1)
		else count

(* At the end of each expression (after seeing two newlines):
   Add  one right paren for each element popped off the given stack,
   until the stop of stack is -1; Adding to the end of given string s *)
let rec closeExpression s stack =
	let top = Stack.top stack in
		if (top == -1) then (s ^ ";;\n")  (* keep -1 as bottom-of-stack marker *)
		else (ignore (Stack.pop stack); closeExpression (")" ^ s) stack)
}
let fn_name = ['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_' '-']*
let binop =  "+" | "-" | "*" | "/" | "+." | "-." | "*." | "/." | "and" | "or" | "not" | "="

rule token = parse
	 eof { EOF }

	| "\n" { let parens = closeExpression "" curIndent in Word(parens) }	(* Newline marks end of expression; Add R-parens & ";;" *)
	
	| "(*" { comment lexbuf }

	| '\n'[' ' '\t']*("if" | "for" | "do" | "while" | "def" ) as lxm 		(* Standard library functions *)
					{ let spaces = countSp lxm 0 1 in
					   ignore(Stack.push spaces curIndent); 
					 StdFn(lxm) }
	| '\n'[' ' '\t']* as ws { 						(* Indentation: whitespace at the beginning of a line *)
				let spaces = countSp ws 0 1 in
				if(spaces > Stack.top curIndent) then ( Word(ws))
				else (			
					(* Same or less indentation than previously added lparen: 
						pop stack until current indentation = top of stack *)
					let parens = 
					let rec closeParens s stack = 
						let top = Stack.top curIndent in
						if (top == -1) then (s ^ ";;\n") 
						else if (top <= spaces) then (ignore(Stack.pop stack); closeParens (")" ^ s) stack)
						else (* top > spaces *) s
					in closeParens ws curIndent
					in Word(parens)
				) }

	| "fn"' '*'('	as lxm { Fdecl(lxm) }					(* Anonymous function declaration: "fn (" *)
	
	| '\n'[' ' '\t']* "def" ' '* fn_name ' '* '(' 		(* Named function declaration: needs own regexp
							   		so that fn_name(args) does not get slurped into (fn_name args) *)			
						as lxm { let spaces = countSp lxm 0 1 in
 						ignore(Stack.push spaces curIndent); Fdecl(lxm) }

	| (fn_name | binop)' '*'(' as lxm { Fparen(lxm) }		(* Function call as "f(args)" *)

	| '\"'[^'\"']*'\"' as lxm { String("&&&" ^ lxm ^ "&&&") } 		(* Quoted strings, so +-/* or f() within quotes scan as strings, not fn calls *)

	| _ as lxm { Word(String.make 1 lxm) } 		(* All characters other than the above *)

and comment = parse
	"*)"	{ token lexbuf }	(* Return to normal scanning *)
	| _	{ comment lexbuf }  	(* Ignore other characters *)
{
	let () = 
	let oc = open_out "program.ss" in	
	let lexbuf = Lexing.from_channel stdin in
	
	let wordlist =
	  let rec next l  = match token lexbuf with
		EOF -> l
		| String(s) -> next(s::l)
		| Comment -> next(l)
		| LineBreak -> next("\n" :: l)
		| Word(s) -> next(s::l)
		| Fdecl(s) -> next( ("\n(" ^ s) :: l)
		| StdFn(s) -> next( ("\n(" ^ s) :: l)
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

