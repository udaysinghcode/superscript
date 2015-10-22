{ open Parser }

rule token = parse
  [' ' '\t' '\n' '\r'] { token lexbuf } (* Whitespace *)
| ';'      { comment lexbuf }      (* Comments *)
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
| "true"   { TRUE }
| "false"  { FALSE }
| '<'      { LT }
| "<="     { LEQ }
| ">"      { GT }
| ">="     { GEQ }
| "if"     { IF }
| '\"'_*'\"' as lxm { STRING(String.sub lxm 1 (String.length lxm - 2)) } 	(* String *)
| ['0'-'9']*'.'['0'-'9']+  as lxm { FLOAT(float_of_string lxm) }		(* Float *)
| ['0'-'9']+'.'['0'-'9']*  as lxm { FLOAT(float_of_string lxm) }		(* Float *)
| ['0'-'9']+ as lxm { INT(int_of_string lxm) }					(* Int *)
| ['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_' '-']* as lxm { ID(lxm) }	(* Identifier *)
| eof { EOF }
| _ as char { raise (Failure("illegal input " ^ Char.escaped char)) }

and comment = parse
   '\n'  { token lexbuf } (* comments *)
   | _    { comment lexbuf }
