{ open Parser }

rule token = parse
<<<<<<< HEAD
  [' ' '\t' '\r' '\n'] { token lexbuf } (* Whitespace *)
| ';'     { comment lexbuf }           (* Comments *)
| '('      { LPAREN }
| ')'      { RPAREN }
| '{'      { LBRACE }
| '}'      { RBRACE }
| ';'      { SEMI }
| '+'      { PLUSINT }
| '-'      { MINUSINT }
| '*'      { TIMESINT }
| '/'      { DIVIDEINT }
| "+."     { PLUSFLOAT }
| "-."     { MINUSFLOAT }
| "*."     { TIMESFLOAT }
| "/."     { DIVIDEFLOAT }
| '\''     { QUOTE }
| '='      { ASSIGN }
| "=="     { EQ }
| "!="     { NEQ }
| '<'      { LT }
| "<="     { LEQ }
| ">"      { GT }
| ">="     { GEQ }
| "if"     { IF }
| ['0'-'9']+ as lxm { LITERAL(int_of_string lxm) }
| ['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_' '-']* as lxm { ID(lxm) }
| eof { EOF }
| _ as char { raise (Failure("illegal input " ^ Char.escaped char)) }

and comment = parse
   '\n'  { token lexbuf } (* comments *)
   | _    { comment lexbuf }
=======
[' ' '\t' '\r' '\n'] { token lexbuf } (* Whitespace *)
| "(*"      { comment lexbuf }        (* Comments *)
| '('       { LPAREN }
| ')'       { RPAREN }
| '+'       { PLUS }
| '-'       { MINUS }
| '*'       { TIMES }
| '/'       { DIVIDE }
| '='       { ASSIGN }
| ['0'-'9']+ as lxm { LITERAL(int_of_string lxm) }
| ['a'-'z' 'A'-Z'] ['a'-'z' 'A'-'Z' '0'-'9' '_' '-']* as lxm { ID(lxm) }
| eof { EOF }

and comment = parse
"*)"        { token lexbuf }
| _         { comment lexbuf }
>>>>>>> FETCH_HEAD
