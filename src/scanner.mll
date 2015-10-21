{ open Parser }

rule token = parse
  [' ' '\t' '\r'] { token lexbuf } (* Whitespace *)
| ';'     { comment lexbuf }           (* Comments *)
| '('      { LPAREN }
| ')'      { RPAREN }
| '{'      { LBRACE }
| '}'      { RBRACE }
| '\n'      { NL }
| '+'      { PLUS }
| '-'      { MINUS }
| '*'      { TIMES }
| '/'      { DIVIDE }
| "+."     { PLUSF }
| "-."     { MINUSF }
| "*."     { TIMESF }
| "/."     { DIVIDEF }
| '\''     { QUOTE }
| '='      { ASSIGN }
| "is"     { EQ }
| "isnt"   { NEQ }
| '<'      { LT }
| "<="     { LEQ }
| ">"      { GT }
| ">="     { GEQ }
| "if"     { IF }
| ['0'-'9']*'.'['0'-'9']+  as lxm { FLOAT(float_of_string lxm) }
| ['0'-'9']+'.'['0'-'9']*  as lxm { FLOAT(float_of_string lxm) }
| ['0'-'9']+ as lxm { INT(int_of_string lxm) }
| ['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_' '-']* as lxm { ID(lxm) }
| eof { EOF }
| _ as char { raise (Failure("illegal input " ^ Char.escaped char)) }

and comment = parse
   '\n'  { token lexbuf } (* comments *)
   | _    { comment lexbuf }
