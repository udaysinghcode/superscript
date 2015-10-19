{ open Parser }

rule token = parse
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
