type token =
  | PLUS
  | MINUS
  | TIMES
  | DIVIDE
  | PLUSF
  | MINUSF
  | TIMESF
  | DIVIDEF
  | EOF
  | ASSIGN
  | QUOTE
  | AND
  | OR
  | EQ
  | NEQ
  | LT
  | LEQ
  | GT
  | GEQ
  | CONCAT
  | SEMI
  | LPAREN
  | RPAREN
  | LBRACE
  | RBRACE
  | INT of (int)
  | FUNC
  | LET
  | IF
  | FOR
  | WHILE
  | ID of (string)
  | STRING of (string)
  | FLOAT of (float)
  | BOOL of (bool)
  | NIL

open Parsing;;
let _ = parse_error;;
# 1 "parser.mly"
 open Ast 
# 44 "parser.ml"
let yytransl_const = [|
  257 (* PLUS *);
  258 (* MINUS *);
  259 (* TIMES *);
  260 (* DIVIDE *);
  261 (* PLUSF *);
  262 (* MINUSF *);
  263 (* TIMESF *);
  264 (* DIVIDEF *);
    0 (* EOF *);
  265 (* ASSIGN *);
  266 (* QUOTE *);
  267 (* AND *);
  268 (* OR *);
  269 (* EQ *);
  270 (* NEQ *);
  271 (* LT *);
  272 (* LEQ *);
  273 (* GT *);
  274 (* GEQ *);
  275 (* CONCAT *);
  276 (* SEMI *);
  277 (* LPAREN *);
  278 (* RPAREN *);
  279 (* LBRACE *);
  280 (* RBRACE *);
  282 (* FUNC *);
  283 (* LET *);
  284 (* IF *);
  285 (* FOR *);
  286 (* WHILE *);
  291 (* NIL *);
    0|]

let yytransl_block = [|
  281 (* INT *);
  287 (* ID *);
  288 (* STRING *);
  289 (* FLOAT *);
  290 (* BOOL *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\004\000\004\000\004\000\004\000\004\000\
\004\000\003\000\003\000\003\000\003\000\008\000\005\000\005\000\
\011\000\011\000\007\000\007\000\007\000\007\000\013\000\013\000\
\013\000\013\000\013\000\013\000\013\000\013\000\013\000\013\000\
\013\000\014\000\014\000\014\000\014\000\014\000\014\000\012\000\
\012\000\012\000\012\000\006\000\006\000\006\000\006\000\010\000\
\010\000\015\000\017\000\017\000\016\000\016\000\009\000\009\000\
\009\000\009\000\009\000\009\000\009\000\009\000\009\000\009\000\
\009\000\009\000\009\000\009\000\009\000\009\000\009\000\009\000\
\009\000\009\000\009\000\009\000\009\000\000\000"

let yylen = "\002\000\
\002\000\000\000\003\000\004\000\004\000\005\000\003\000\005\000\
\001\000\001\000\001\000\003\000\003\000\004\000\000\000\001\000\
\001\000\002\000\001\000\001\000\001\000\001\000\001\000\001\000\
\001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
\001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
\001\000\001\000\001\000\002\000\002\000\002\000\002\000\000\000\
\001\000\002\000\001\000\002\000\000\000\003\000\001\000\001\000\
\002\000\002\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\003\000\003\000\003\000\003\000\002\000"

let yydefred = "\000\000\
\002\000\000\000\078\000\000\000\023\000\024\000\025\000\026\000\
\027\000\028\000\030\000\029\000\001\000\000\000\031\000\032\000\
\033\000\000\000\000\000\040\000\020\000\043\000\041\000\042\000\
\021\000\000\000\010\000\011\000\019\000\022\000\000\000\000\000\
\034\000\035\000\036\000\037\000\038\000\039\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\009\000\000\000\000\000\
\000\000\000\000\000\000\000\000\055\000\003\000\051\000\000\000\
\000\000\000\000\047\000\000\000\000\000\000\000\000\000\000\000\
\044\000\013\000\045\000\000\000\046\000\057\000\058\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\012\000\014\000\052\000\000\000\017\000\000\000\
\000\000\000\000\000\000\000\000\007\000\050\000\059\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\061\000\054\000\000\000\018\000\004\000\005\000\000\000\008\000\
\006\000"

let yydgoto = "\002\000\
\003\000\004\000\055\000\045\000\096\000\046\000\027\000\028\000\
\052\000\056\000\097\000\029\000\030\000\048\000\069\000\059\000\
\057\000"

let yysindex = "\011\000\
\000\000\000\000\000\000\001\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\007\255\000\000\000\000\
\000\000\176\255\000\255\000\000\000\000\000\000\000\000\000\000\
\000\000\003\255\000\000\000\000\000\000\000\000\141\255\004\255\
\000\000\000\000\000\000\000\000\000\000\000\000\015\255\009\255\
\141\255\141\255\141\255\141\255\019\255\000\000\141\255\141\255\
\253\254\000\255\034\255\231\255\000\000\000\000\000\000\033\255\
\141\255\141\255\000\000\025\255\141\255\141\255\141\255\141\255\
\000\000\000\000\000\000\141\255\000\000\000\000\000\000\180\000\
\000\255\000\255\000\255\000\255\000\255\000\255\000\255\000\255\
\000\255\000\255\000\255\000\255\000\255\000\255\000\255\000\255\
\000\255\000\255\000\000\000\000\000\000\004\255\000\000\039\255\
\031\255\141\255\141\255\141\255\000\000\000\000\000\000\202\000\
\083\255\083\255\064\255\064\255\083\255\083\255\064\255\064\255\
\240\000\221\000\003\001\003\001\044\255\044\255\044\255\044\255\
\000\000\000\000\141\255\000\000\000\000\000\000\141\255\000\000\
\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\062\255\067\255\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\062\255\000\000\000\000\062\255\000\000\
\000\000\000\000\207\255\000\000\000\000\000\000\000\000\000\000\
\070\255\000\000\000\000\071\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\067\255\000\000\000\000\
\075\255\000\000\000\000\000\000\000\000\000\000\000\000\005\255\
\098\255\108\000\002\255\036\000\132\000\156\000\060\000\084\000\
\147\255\174\255\143\255\003\000\012\001\026\001\040\001\054\001\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000"

let yygindex = "\000\000\
\000\000\000\000\252\255\000\000\000\000\000\000\000\000\000\000\
\051\000\041\000\000\000\248\255\080\000\000\000\000\000\012\000\
\000\000"

let yytablesize = 590
let yytable = "\026\000\
\013\000\049\000\064\000\064\000\064\000\064\000\064\000\064\000\
\064\000\064\000\053\000\001\000\064\000\064\000\064\000\064\000\
\064\000\064\000\064\000\064\000\050\000\070\000\054\000\064\000\
\020\000\064\000\060\000\031\000\060\000\071\000\051\000\022\000\
\023\000\024\000\058\000\060\000\062\000\063\000\064\000\061\000\
\066\000\053\000\073\000\068\000\074\000\075\000\076\000\077\000\
\078\000\079\000\080\000\081\000\093\000\094\000\092\000\095\000\
\098\000\099\000\100\000\101\000\123\000\124\000\090\000\102\000\
\053\000\053\000\053\000\053\000\053\000\053\000\053\000\053\000\
\053\000\053\000\053\000\053\000\053\000\053\000\053\000\053\000\
\053\000\053\000\090\000\048\000\065\000\076\000\077\000\067\000\
\053\000\080\000\081\000\049\000\015\000\125\000\126\000\127\000\
\016\000\047\000\062\000\062\000\072\000\090\000\062\000\062\000\
\000\000\122\000\000\000\000\000\062\000\062\000\062\000\062\000\
\062\000\062\000\062\000\062\000\000\000\000\000\128\000\062\000\
\000\000\062\000\129\000\104\000\105\000\106\000\107\000\108\000\
\109\000\110\000\111\000\112\000\113\000\114\000\115\000\116\000\
\117\000\118\000\119\000\120\000\121\000\005\000\006\000\007\000\
\008\000\009\000\010\000\011\000\012\000\000\000\014\000\015\000\
\016\000\070\000\070\000\070\000\070\000\076\000\076\000\017\000\
\000\000\018\000\000\000\019\000\070\000\020\000\070\000\000\000\
\076\000\000\000\076\000\021\000\022\000\023\000\024\000\025\000\
\005\000\006\000\007\000\008\000\009\000\010\000\011\000\012\000\
\032\000\077\000\015\000\016\000\033\000\034\000\035\000\036\000\
\037\000\038\000\017\000\077\000\000\000\077\000\000\000\000\000\
\000\000\039\000\040\000\041\000\042\000\043\000\044\000\056\000\
\056\000\056\000\056\000\056\000\056\000\056\000\056\000\000\000\
\000\000\056\000\056\000\056\000\056\000\056\000\056\000\056\000\
\056\000\056\000\000\000\000\000\056\000\000\000\056\000\074\000\
\075\000\076\000\077\000\078\000\079\000\080\000\081\000\000\000\
\000\000\082\000\083\000\084\000\085\000\086\000\087\000\088\000\
\089\000\090\000\000\000\000\000\000\000\000\000\091\000\000\000\
\000\000\005\000\006\000\007\000\008\000\009\000\010\000\011\000\
\012\000\000\000\014\000\015\000\016\000\071\000\071\000\071\000\
\071\000\000\000\000\000\017\000\000\000\018\000\000\000\019\000\
\071\000\020\000\071\000\000\000\000\000\000\000\000\000\021\000\
\022\000\023\000\024\000\025\000\065\000\065\000\065\000\065\000\
\065\000\065\000\065\000\065\000\000\000\000\000\065\000\065\000\
\065\000\065\000\065\000\065\000\065\000\065\000\000\000\000\000\
\000\000\065\000\000\000\065\000\068\000\068\000\068\000\068\000\
\068\000\068\000\068\000\068\000\000\000\000\000\068\000\068\000\
\068\000\068\000\068\000\068\000\068\000\068\000\000\000\000\000\
\000\000\068\000\000\000\068\000\069\000\069\000\069\000\069\000\
\069\000\069\000\069\000\069\000\000\000\000\000\069\000\069\000\
\069\000\069\000\069\000\069\000\069\000\069\000\000\000\000\000\
\000\000\069\000\000\000\069\000\063\000\063\000\000\000\000\000\
\063\000\063\000\000\000\000\000\000\000\000\000\063\000\063\000\
\063\000\063\000\063\000\063\000\063\000\063\000\000\000\000\000\
\000\000\063\000\000\000\063\000\066\000\066\000\000\000\000\000\
\066\000\066\000\000\000\000\000\000\000\000\000\066\000\066\000\
\066\000\066\000\066\000\066\000\066\000\066\000\000\000\000\000\
\000\000\066\000\000\000\066\000\067\000\067\000\000\000\000\000\
\067\000\067\000\000\000\000\000\000\000\000\000\067\000\067\000\
\067\000\067\000\067\000\067\000\067\000\067\000\000\000\000\000\
\000\000\067\000\000\000\067\000\074\000\075\000\076\000\077\000\
\078\000\079\000\080\000\081\000\000\000\000\000\082\000\083\000\
\084\000\085\000\086\000\087\000\088\000\089\000\090\000\000\000\
\000\000\103\000\074\000\075\000\076\000\077\000\078\000\079\000\
\080\000\081\000\000\000\000\000\082\000\083\000\084\000\085\000\
\086\000\087\000\088\000\089\000\090\000\074\000\075\000\076\000\
\077\000\078\000\079\000\080\000\081\000\000\000\000\000\082\000\
\000\000\084\000\085\000\086\000\087\000\088\000\089\000\090\000\
\074\000\075\000\076\000\077\000\078\000\079\000\080\000\081\000\
\000\000\000\000\000\000\000\000\084\000\085\000\086\000\087\000\
\088\000\089\000\090\000\074\000\075\000\076\000\077\000\078\000\
\079\000\080\000\081\000\000\000\000\000\000\000\000\000\000\000\
\000\000\086\000\087\000\088\000\089\000\090\000\072\000\072\000\
\072\000\072\000\072\000\072\000\072\000\072\000\000\000\000\000\
\000\000\072\000\000\000\072\000\073\000\073\000\073\000\073\000\
\073\000\073\000\073\000\073\000\000\000\000\000\000\000\073\000\
\000\000\073\000\074\000\074\000\074\000\074\000\074\000\074\000\
\074\000\074\000\000\000\000\000\000\000\074\000\000\000\074\000\
\075\000\075\000\075\000\075\000\075\000\075\000\075\000\075\000\
\000\000\000\000\000\000\075\000\000\000\075\000"

let yycheck = "\004\000\
\000\000\002\001\001\001\002\001\003\001\004\001\005\001\006\001\
\007\001\008\001\019\000\001\000\011\001\012\001\013\001\014\001\
\015\001\016\001\017\001\018\001\021\001\025\001\020\001\022\001\
\025\001\024\001\022\001\021\001\024\001\033\001\031\001\032\001\
\033\001\034\001\031\001\021\001\041\000\042\000\043\000\031\001\
\022\001\050\000\009\001\048\000\001\001\002\001\003\001\004\001\
\005\001\006\001\007\001\008\001\057\000\058\000\022\001\031\001\
\061\000\062\000\063\000\064\000\022\001\031\001\019\001\068\000\
\073\000\074\000\075\000\076\000\077\000\078\000\079\000\080\000\
\081\000\082\000\083\000\084\000\085\000\086\000\087\000\088\000\
\089\000\090\000\019\001\022\001\044\000\003\001\004\001\047\000\
\022\001\007\001\008\001\022\001\022\001\098\000\099\000\100\000\
\022\001\018\000\001\001\002\001\050\000\019\001\005\001\006\001\
\255\255\094\000\255\255\255\255\011\001\012\001\013\001\014\001\
\015\001\016\001\017\001\018\001\255\255\255\255\123\000\022\001\
\255\255\024\001\127\000\073\000\074\000\075\000\076\000\077\000\
\078\000\079\000\080\000\081\000\082\000\083\000\084\000\085\000\
\086\000\087\000\088\000\089\000\090\000\001\001\002\001\003\001\
\004\001\005\001\006\001\007\001\008\001\255\255\010\001\011\001\
\012\001\011\001\012\001\013\001\014\001\011\001\012\001\019\001\
\255\255\021\001\255\255\023\001\022\001\025\001\024\001\255\255\
\022\001\255\255\024\001\031\001\032\001\033\001\034\001\035\001\
\001\001\002\001\003\001\004\001\005\001\006\001\007\001\008\001\
\009\001\012\001\011\001\012\001\013\001\014\001\015\001\016\001\
\017\001\018\001\019\001\022\001\255\255\024\001\255\255\255\255\
\255\255\026\001\027\001\028\001\029\001\030\001\031\001\001\001\
\002\001\003\001\004\001\005\001\006\001\007\001\008\001\255\255\
\255\255\011\001\012\001\013\001\014\001\015\001\016\001\017\001\
\018\001\019\001\255\255\255\255\022\001\255\255\024\001\001\001\
\002\001\003\001\004\001\005\001\006\001\007\001\008\001\255\255\
\255\255\011\001\012\001\013\001\014\001\015\001\016\001\017\001\
\018\001\019\001\255\255\255\255\255\255\255\255\024\001\255\255\
\255\255\001\001\002\001\003\001\004\001\005\001\006\001\007\001\
\008\001\255\255\010\001\011\001\012\001\011\001\012\001\013\001\
\014\001\255\255\255\255\019\001\255\255\021\001\255\255\023\001\
\022\001\025\001\024\001\255\255\255\255\255\255\255\255\031\001\
\032\001\033\001\034\001\035\001\001\001\002\001\003\001\004\001\
\005\001\006\001\007\001\008\001\255\255\255\255\011\001\012\001\
\013\001\014\001\015\001\016\001\017\001\018\001\255\255\255\255\
\255\255\022\001\255\255\024\001\001\001\002\001\003\001\004\001\
\005\001\006\001\007\001\008\001\255\255\255\255\011\001\012\001\
\013\001\014\001\015\001\016\001\017\001\018\001\255\255\255\255\
\255\255\022\001\255\255\024\001\001\001\002\001\003\001\004\001\
\005\001\006\001\007\001\008\001\255\255\255\255\011\001\012\001\
\013\001\014\001\015\001\016\001\017\001\018\001\255\255\255\255\
\255\255\022\001\255\255\024\001\001\001\002\001\255\255\255\255\
\005\001\006\001\255\255\255\255\255\255\255\255\011\001\012\001\
\013\001\014\001\015\001\016\001\017\001\018\001\255\255\255\255\
\255\255\022\001\255\255\024\001\001\001\002\001\255\255\255\255\
\005\001\006\001\255\255\255\255\255\255\255\255\011\001\012\001\
\013\001\014\001\015\001\016\001\017\001\018\001\255\255\255\255\
\255\255\022\001\255\255\024\001\001\001\002\001\255\255\255\255\
\005\001\006\001\255\255\255\255\255\255\255\255\011\001\012\001\
\013\001\014\001\015\001\016\001\017\001\018\001\255\255\255\255\
\255\255\022\001\255\255\024\001\001\001\002\001\003\001\004\001\
\005\001\006\001\007\001\008\001\255\255\255\255\011\001\012\001\
\013\001\014\001\015\001\016\001\017\001\018\001\019\001\255\255\
\255\255\022\001\001\001\002\001\003\001\004\001\005\001\006\001\
\007\001\008\001\255\255\255\255\011\001\012\001\013\001\014\001\
\015\001\016\001\017\001\018\001\019\001\001\001\002\001\003\001\
\004\001\005\001\006\001\007\001\008\001\255\255\255\255\011\001\
\255\255\013\001\014\001\015\001\016\001\017\001\018\001\019\001\
\001\001\002\001\003\001\004\001\005\001\006\001\007\001\008\001\
\255\255\255\255\255\255\255\255\013\001\014\001\015\001\016\001\
\017\001\018\001\019\001\001\001\002\001\003\001\004\001\005\001\
\006\001\007\001\008\001\255\255\255\255\255\255\255\255\255\255\
\255\255\015\001\016\001\017\001\018\001\019\001\011\001\012\001\
\013\001\014\001\015\001\016\001\017\001\018\001\255\255\255\255\
\255\255\022\001\255\255\024\001\011\001\012\001\013\001\014\001\
\015\001\016\001\017\001\018\001\255\255\255\255\255\255\022\001\
\255\255\024\001\011\001\012\001\013\001\014\001\015\001\016\001\
\017\001\018\001\255\255\255\255\255\255\022\001\255\255\024\001\
\011\001\012\001\013\001\014\001\015\001\016\001\017\001\018\001\
\255\255\255\255\255\255\022\001\255\255\024\001"

let yynames_const = "\
  PLUS\000\
  MINUS\000\
  TIMES\000\
  DIVIDE\000\
  PLUSF\000\
  MINUSF\000\
  TIMESF\000\
  DIVIDEF\000\
  EOF\000\
  ASSIGN\000\
  QUOTE\000\
  AND\000\
  OR\000\
  EQ\000\
  NEQ\000\
  LT\000\
  LEQ\000\
  GT\000\
  GEQ\000\
  CONCAT\000\
  SEMI\000\
  LPAREN\000\
  RPAREN\000\
  LBRACE\000\
  RBRACE\000\
  FUNC\000\
  LET\000\
  IF\000\
  FOR\000\
  WHILE\000\
  NIL\000\
  "

let yynames_block = "\
  INT\000\
  ID\000\
  STRING\000\
  FLOAT\000\
  BOOL\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr_list) in
    Obj.repr(
# 29 "parser.mly"
                ( List.rev _1 )
# 380 "parser.ml"
               : Ast.program))
; (fun __caml_parser_env ->
    Obj.repr(
# 32 "parser.mly"
               ( [] )
# 386 "parser.ml"
               : 'expr_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr_list) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 33 "parser.mly"
                      ( _2 :: _1 )
# 394 "parser.ml"
               : 'expr_list))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 36 "parser.mly"
                       ( Let(_2, _3, _4) )
# 403 "parser.ml"
               : 'sexpr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 37 "parser.mly"
                     ( If(_2, _3, _4) )
# 412 "parser.ml"
               : 'sexpr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 38 "parser.mly"
                          ( For(_2, _3, _4, _5))
# 422 "parser.ml"
               : 'sexpr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 39 "parser.mly"
                   ( While(_2, _3) )
# 430 "parser.ml"
               : 'sexpr))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'formals_opt) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 40 "parser.mly"
                                      ( Fdecl(List.rev _3, _5) )
# 438 "parser.ml"
               : 'sexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'call) in
    Obj.repr(
# 41 "parser.mly"
          ( _1 )
# 445 "parser.ml"
               : 'sexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atom) in
    Obj.repr(
# 44 "parser.mly"
          ( _1 )
# 452 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'list) in
    Obj.repr(
# 45 "parser.mly"
          ( _1 )
# 459 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'infix_expr) in
    Obj.repr(
# 46 "parser.mly"
                           ( _2 )
# 466 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'sexpr) in
    Obj.repr(
# 47 "parser.mly"
                       ( _2 )
# 473 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'args_opt) in
    Obj.repr(
# 50 "parser.mly"
                                ( List(List.rev _3) )
# 480 "parser.ml"
               : 'list))
; (fun __caml_parser_env ->
    Obj.repr(
# 53 "parser.mly"
               ( [] )
# 486 "parser.ml"
               : 'formals_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'formal_list) in
    Obj.repr(
# 54 "parser.mly"
              ( List.rev _1 )
# 493 "parser.ml"
               : 'formals_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 57 "parser.mly"
        ( [_1] )
# 500 "parser.ml"
               : 'formal_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'formal_list) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 58 "parser.mly"
                  ( _2 :: _1 )
# 508 "parser.ml"
               : 'formal_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'constant) in
    Obj.repr(
# 61 "parser.mly"
            ( _1 )
# 515 "parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 62 "parser.mly"
       ( Id(_1) )
# 522 "parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    Obj.repr(
# 63 "parser.mly"
        ( Nil )
# 528 "parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'operator) in
    Obj.repr(
# 64 "parser.mly"
            ( Id(_1) )
# 535 "parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    Obj.repr(
# 67 "parser.mly"
         ( "__add" )
# 541 "parser.ml"
               : 'operator))
; (fun __caml_parser_env ->
    Obj.repr(
# 68 "parser.mly"
          ( "__sub" )
# 547 "parser.ml"
               : 'operator))
; (fun __caml_parser_env ->
    Obj.repr(
# 69 "parser.mly"
          ( "__mult" )
# 553 "parser.ml"
               : 'operator))
; (fun __caml_parser_env ->
    Obj.repr(
# 70 "parser.mly"
          ( "__div" )
# 559 "parser.ml"
               : 'operator))
; (fun __caml_parser_env ->
    Obj.repr(
# 71 "parser.mly"
          ( "__addf" )
# 565 "parser.ml"
               : 'operator))
; (fun __caml_parser_env ->
    Obj.repr(
# 72 "parser.mly"
          ( "__subf" )
# 571 "parser.ml"
               : 'operator))
; (fun __caml_parser_env ->
    Obj.repr(
# 73 "parser.mly"
           ( "__divf" )
# 577 "parser.ml"
               : 'operator))
; (fun __caml_parser_env ->
    Obj.repr(
# 74 "parser.mly"
          ( "__multf" )
# 583 "parser.ml"
               : 'operator))
; (fun __caml_parser_env ->
    Obj.repr(
# 75 "parser.mly"
        ( "__and" )
# 589 "parser.ml"
               : 'operator))
; (fun __caml_parser_env ->
    Obj.repr(
# 76 "parser.mly"
       ( "__or" )
# 595 "parser.ml"
               : 'operator))
; (fun __caml_parser_env ->
    Obj.repr(
# 77 "parser.mly"
          ( "__concat" )
# 601 "parser.ml"
               : 'operator))
; (fun __caml_parser_env ->
    Obj.repr(
# 80 "parser.mly"
          ( "__equal" )
# 607 "parser.ml"
               : 'two_args_operators))
; (fun __caml_parser_env ->
    Obj.repr(
# 81 "parser.mly"
          ( "__neq" )
# 613 "parser.ml"
               : 'two_args_operators))
; (fun __caml_parser_env ->
    Obj.repr(
# 82 "parser.mly"
          ( "__less" )
# 619 "parser.ml"
               : 'two_args_operators))
; (fun __caml_parser_env ->
    Obj.repr(
# 83 "parser.mly"
          ( "__leq" )
# 625 "parser.ml"
               : 'two_args_operators))
; (fun __caml_parser_env ->
    Obj.repr(
# 84 "parser.mly"
          ( "__greater" )
# 631 "parser.ml"
               : 'two_args_operators))
; (fun __caml_parser_env ->
    Obj.repr(
# 85 "parser.mly"
          ( "__geq" )
# 637 "parser.ml"
               : 'two_args_operators))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 88 "parser.mly"
         ( Int(_1) )
# 644 "parser.ml"
               : 'constant))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : float) in
    Obj.repr(
# 89 "parser.mly"
          ( Float(_1) )
# 651 "parser.ml"
               : 'constant))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : bool) in
    Obj.repr(
# 90 "parser.mly"
         ( Boolean(_1) )
# 658 "parser.ml"
               : 'constant))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 91 "parser.mly"
          ( String(_1) )
# 665 "parser.ml"
               : 'constant))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'args_opt) in
    Obj.repr(
# 94 "parser.mly"
               ( Eval(_1, List.rev _2) )
# 673 "parser.ml"
               : 'call))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'operator) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'args_opt) in
    Obj.repr(
# 95 "parser.mly"
                     ( Eval(_1, List.rev _2) )
# 681 "parser.ml"
               : 'call))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'two_args_operators) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'two_args) in
    Obj.repr(
# 96 "parser.mly"
                              ( Eval(_1, List.rev _2))
# 689 "parser.ml"
               : 'call))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'assign_args) in
    Obj.repr(
# 97 "parser.mly"
                     ( Assign(List.rev _2) )
# 696 "parser.ml"
               : 'call))
; (fun __caml_parser_env ->
    Obj.repr(
# 100 "parser.mly"
                ( [] )
# 702 "parser.ml"
               : 'args_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 101 "parser.mly"
         ( _1 )
# 709 "parser.ml"
               : 'args_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 104 "parser.mly"
          ( [_2; _1] )
# 717 "parser.ml"
               : 'two_args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 107 "parser.mly"
         ( [_1] )
# 724 "parser.ml"
               : 'args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'args) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 108 "parser.mly"
             ( _2 :: _1 )
# 732 "parser.ml"
               : 'args))
; (fun __caml_parser_env ->
    Obj.repr(
# 111 "parser.mly"
               ( [] )
# 738 "parser.ml"
               : 'assign_args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'assign_args) in
    Obj.repr(
# 112 "parser.mly"
                        ( _2 :: Id(_1) :: _3 )
# 747 "parser.ml"
               : 'assign_args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'constant) in
    Obj.repr(
# 115 "parser.mly"
             ( _1 )
# 754 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 116 "parser.mly"
        ( Id(_1) )
# 761 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 117 "parser.mly"
              ( Int(-1 * _2) )
# 768 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : float) in
    Obj.repr(
# 118 "parser.mly"
                ( Float(-1.0 *. _2) )
# 775 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'infix_expr) in
    Obj.repr(
# 119 "parser.mly"
                           ( _2 )
# 782 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 120 "parser.mly"
                        ( Assign([Id(_1); _3]) )
# 790 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 121 "parser.mly"
                                ( Eval("__concat", [_1; _3]) )
# 798 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 122 "parser.mly"
                             ( Eval("__add", [_1; _3]) )
# 806 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 123 "parser.mly"
                              ( Eval("__sub", [_1; _3])  )
# 814 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 124 "parser.mly"
                              ( Eval("__mult", [_1; _3]) )
# 822 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 125 "parser.mly"
                               ( Eval("__div", [_1; _3])  )
# 830 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 126 "parser.mly"
                              ( Eval("__addf", [_1; _3]) )
# 838 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 127 "parser.mly"
                               ( Eval("__subf", [_1; _3]) )
# 846 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 128 "parser.mly"
                               ( Eval("__multf", [_1; _3]) )
# 854 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 129 "parser.mly"
                                ( Eval("__divf", [_1; _3]) )
# 862 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 130 "parser.mly"
                           ( Eval("__equal", [_1; _3]) )
# 870 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 131 "parser.mly"
                            ( Eval("__neq", [_1; _3]) )
# 878 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 132 "parser.mly"
                           ( Eval("__add", [_1; _3]) )
# 886 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 133 "parser.mly"
                            ( Eval("__less", [_1; _3]) )
# 894 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 134 "parser.mly"
                           ( Eval("__greater", [_1; _3]) )
# 902 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 135 "parser.mly"
                            ( Eval("__geq", [_1; _3]) )
# 910 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 136 "parser.mly"
                            ( Eval("__and", [_1; _3]) )
# 918 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 137 "parser.mly"
                           ( Eval("__or", [_1; _3]) )
# 926 "parser.ml"
               : 'infix_expr))
(* Entry program *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let program (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Ast.program)
