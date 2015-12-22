{ 
  open Parser
  open Message
  open Lexing
}

rule token = parse
| "###ENDSTDLIB###"	{ ignore
			    (lexbuf.lex_curr_p <- {(lexeme_start_p lexbuf) 
			      with  pos_lnum = 0 ; }); 
			 token lexbuf } 
| [' ' '\t' '\\''\\'] { token lexbuf } (* Whitespace *)
| [ '\n' '\r' ]		{ ignore(Lexing.new_line lexbuf); token lexbuf } 
| "/*"      { comment lexbuf }      (* Comments *)
| ";;"     { SEMI }
| '('      { LPAREN }
| ')'      { RPAREN }
| '{'      { LBRACE }
| '}'      { RBRACE }
| '+'      { PLUS }
| '-'      { MINUS }
| '*'      { TIMES }
| '/'      { DIVIDE }
| "+."     { PLUSF }
| "-."     { MINUSF }
| "*."     { TIMESF }
| "/."     { DIVIDEF }
| "and"	   { AND }
| "or"     { OR }
| "not"    { NOT }
| '\''     { QUOTE }
| '='      { ASSIGN }
| "is"     { EQ }
| "isnt"   { NEQ }
| "true"   as lxm { BOOL(bool_of_string lxm) }
| "false"  as lxm { BOOL(bool_of_string lxm) }
| "nil"     { NIL }
| '<'      { LT }
| "<="     { LEQ }
| ">"      { GT }
| ">="     { GEQ }
| "++"     { CONCAT }
| "fn"     { FUNC }
| "if"     { IF }
| "do" 	   { DO }
| "eval"   { EVAL }
| "evaluate"  { raise(Failure "Lexer error: evaluate is a reserved keyword and may not be used. ") } 
| "exec"      { raise(Failure "Lexer error: exec is a reserved keyword and may not be used. ") }
| '\"'[^'\"']*'\"' as lxm { STRING(String.sub lxm 1 (String.length lxm - 2)) } 	(* String *)
| ['0'-'9']*'.'['0'-'9']+  as lxm { FLOAT(float_of_string lxm) }		(* Float *)
| ['0'-'9']+'.'['0'-'9']*  as lxm { FLOAT(float_of_string lxm) }		(* Float *)
| ['0'-'9']+ as lxm { INT(int_of_string lxm) }					(* Int *)
| ['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_']* as lxm { ID(lxm) }		(* Identifier *)
| eof { EOF }
| _ 	 { raise (Message.LexingErr("Illegal input")) }

and comment = parse
   "*/"  { token lexbuf } (* comments *)
   | _    { comment lexbuf }
