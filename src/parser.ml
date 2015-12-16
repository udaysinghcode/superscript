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
\001\000\002\000\002\000\004\000\004\000\004\000\004\000\003\000\
\003\000\003\000\003\000\008\000\011\000\005\000\005\000\012\000\
\012\000\007\000\007\000\007\000\007\000\014\000\014\000\014\000\
\014\000\014\000\014\000\014\000\014\000\014\000\014\000\014\000\
\015\000\015\000\015\000\015\000\015\000\015\000\013\000\013\000\
\013\000\013\000\006\000\006\000\006\000\006\000\006\000\010\000\
\010\000\016\000\018\000\018\000\017\000\017\000\009\000\009\000\
\009\000\009\000\009\000\009\000\009\000\009\000\009\000\009\000\
\009\000\009\000\009\000\009\000\009\000\009\000\009\000\009\000\
\009\000\009\000\009\000\009\000\009\000\000\000"

let yylen = "\002\000\
\002\000\000\000\003\000\004\000\004\000\005\000\001\000\001\000\
\001\000\003\000\003\000\004\000\003\000\000\000\001\000\001\000\
\002\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
\001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
\001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
\001\000\001\000\002\000\002\000\002\000\002\000\002\000\000\000\
\001\000\002\000\001\000\002\000\000\000\003\000\001\000\001\000\
\002\000\002\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\003\000\003\000\003\000\003\000\002\000"

let yydefred = "\000\000\
\002\000\000\000\078\000\000\000\022\000\023\000\024\000\025\000\
\026\000\027\000\029\000\028\000\001\000\000\000\030\000\031\000\
\032\000\000\000\000\000\039\000\019\000\042\000\040\000\041\000\
\020\000\000\000\008\000\009\000\018\000\021\000\000\000\000\000\
\033\000\034\000\035\000\036\000\037\000\038\000\000\000\000\000\
\000\000\000\000\000\000\000\000\007\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\055\000\003\000\051\000\000\000\
\000\000\000\000\047\000\000\000\000\000\000\000\000\000\043\000\
\011\000\044\000\045\000\000\000\046\000\057\000\058\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\010\000\012\000\052\000\000\000\013\000\016\000\
\000\000\000\000\000\000\000\000\050\000\059\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\061\000\
\054\000\000\000\017\000\004\000\005\000\006\000"

let yydgoto = "\002\000\
\003\000\004\000\055\000\044\000\097\000\045\000\027\000\028\000\
\052\000\056\000\046\000\098\000\053\000\030\000\048\000\069\000\
\059\000\057\000"

let yysindex = "\014\000\
\000\000\000\000\000\000\001\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\255\254\000\000\000\000\
\000\000\133\255\001\255\000\000\000\000\000\000\000\000\000\000\
\000\000\008\255\000\000\000\000\000\000\000\000\098\255\000\255\
\000\000\000\000\000\000\000\000\000\000\000\000\133\255\009\255\
\019\255\098\255\098\255\035\255\000\000\098\255\098\255\098\255\
\247\254\001\255\032\255\188\255\000\000\000\000\000\000\040\255\
\098\255\098\255\000\000\041\255\034\255\098\255\098\255\000\000\
\000\000\000\000\000\000\098\255\000\000\000\000\000\000\204\000\
\001\255\001\255\001\255\001\255\001\255\001\255\001\255\001\255\
\001\255\001\255\001\255\001\255\001\255\001\255\001\255\001\255\
\001\255\001\255\000\000\000\000\000\000\000\255\000\000\000\000\
\045\255\055\255\098\255\098\255\000\000\000\000\236\255\010\255\
\010\255\068\255\068\255\010\255\010\255\068\255\068\255\245\000\
\226\000\008\001\008\001\004\255\004\255\004\255\004\255\000\000\
\000\000\098\255\000\000\000\000\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\066\255\067\255\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\066\255\000\000\000\000\066\255\066\255\000\000\
\000\000\000\000\164\255\000\000\000\000\000\000\000\000\000\000\
\069\255\000\000\000\000\000\000\070\255\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\067\255\000\000\000\000\
\000\000\071\255\000\000\000\000\000\000\000\000\253\254\108\000\
\132\000\212\255\036\000\156\000\180\000\060\000\084\000\025\255\
\103\255\100\255\003\000\017\001\031\001\045\001\059\001\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\254\255\051\000\000\000\000\000\000\000\000\000\
\251\255\005\000\000\000\000\000\252\255\242\255\000\000\000\000\
\013\000\000\000"

let yytablesize = 595
let yytable = "\029\000\
\013\000\026\000\049\000\047\000\074\000\075\000\076\000\077\000\
\078\000\079\000\080\000\081\000\076\000\077\000\001\000\070\000\
\080\000\081\000\060\000\031\000\060\000\050\000\090\000\071\000\
\047\000\020\000\029\000\054\000\090\000\061\000\058\000\051\000\
\022\000\023\000\024\000\076\000\076\000\029\000\029\000\063\000\
\073\000\029\000\029\000\029\000\072\000\068\000\076\000\064\000\
\076\000\062\000\066\000\067\000\029\000\029\000\093\000\094\000\
\065\000\029\000\029\000\099\000\100\000\092\000\095\000\029\000\
\096\000\101\000\122\000\103\000\104\000\105\000\106\000\107\000\
\108\000\109\000\110\000\111\000\112\000\113\000\114\000\115\000\
\116\000\117\000\118\000\119\000\120\000\123\000\090\000\048\000\
\053\000\060\000\049\000\014\000\015\000\000\000\029\000\029\000\
\124\000\125\000\005\000\006\000\007\000\008\000\009\000\010\000\
\011\000\012\000\121\000\014\000\015\000\016\000\070\000\070\000\
\070\000\070\000\077\000\000\000\017\000\029\000\018\000\126\000\
\019\000\070\000\020\000\070\000\077\000\000\000\077\000\000\000\
\021\000\022\000\023\000\024\000\025\000\005\000\006\000\007\000\
\008\000\009\000\010\000\011\000\012\000\032\000\000\000\015\000\
\016\000\033\000\034\000\035\000\036\000\037\000\038\000\017\000\
\000\000\039\000\000\000\000\000\000\000\000\000\040\000\041\000\
\042\000\000\000\000\000\043\000\056\000\056\000\056\000\056\000\
\056\000\056\000\056\000\056\000\000\000\000\000\056\000\056\000\
\056\000\056\000\056\000\056\000\056\000\056\000\056\000\000\000\
\000\000\056\000\000\000\056\000\074\000\075\000\076\000\077\000\
\078\000\079\000\080\000\081\000\000\000\000\000\082\000\083\000\
\084\000\085\000\086\000\087\000\088\000\089\000\090\000\000\000\
\000\000\000\000\000\000\091\000\064\000\064\000\064\000\064\000\
\064\000\064\000\064\000\064\000\000\000\000\000\064\000\064\000\
\064\000\064\000\064\000\064\000\064\000\064\000\000\000\000\000\
\000\000\064\000\000\000\064\000\074\000\075\000\076\000\077\000\
\078\000\079\000\080\000\081\000\000\000\000\000\082\000\083\000\
\084\000\085\000\086\000\087\000\088\000\089\000\090\000\000\000\
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
\000\000\069\000\000\000\069\000\062\000\062\000\000\000\000\000\
\062\000\062\000\000\000\000\000\000\000\000\000\062\000\062\000\
\062\000\062\000\062\000\062\000\062\000\062\000\000\000\000\000\
\000\000\062\000\000\000\062\000\063\000\063\000\000\000\000\000\
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
\000\000\102\000\074\000\075\000\076\000\077\000\078\000\079\000\
\080\000\081\000\000\000\000\000\082\000\000\000\084\000\085\000\
\086\000\087\000\088\000\089\000\090\000\074\000\075\000\076\000\
\077\000\078\000\079\000\080\000\081\000\000\000\000\000\000\000\
\000\000\084\000\085\000\086\000\087\000\088\000\089\000\090\000\
\074\000\075\000\076\000\077\000\078\000\079\000\080\000\081\000\
\000\000\000\000\000\000\000\000\000\000\000\000\086\000\087\000\
\088\000\089\000\090\000\072\000\072\000\072\000\072\000\072\000\
\072\000\072\000\072\000\000\000\000\000\000\000\072\000\000\000\
\072\000\073\000\073\000\073\000\073\000\073\000\073\000\073\000\
\073\000\000\000\000\000\000\000\073\000\000\000\073\000\074\000\
\074\000\074\000\074\000\074\000\074\000\074\000\074\000\000\000\
\000\000\000\000\074\000\000\000\074\000\075\000\075\000\075\000\
\075\000\075\000\075\000\075\000\075\000\000\000\000\000\000\000\
\075\000\000\000\075\000"

let yycheck = "\004\000\
\000\000\004\000\002\001\018\000\001\001\002\001\003\001\004\001\
\005\001\006\001\007\001\008\001\003\001\004\001\001\000\025\001\
\007\001\008\001\022\001\021\001\024\001\021\001\019\001\033\001\
\039\000\025\001\031\000\020\001\019\001\021\001\031\001\031\001\
\032\001\033\001\034\001\011\001\012\001\042\000\043\000\042\000\
\009\001\046\000\047\000\048\000\050\000\048\000\022\001\043\000\
\024\001\031\001\046\000\047\000\057\000\058\000\057\000\058\000\
\022\001\062\000\063\000\062\000\063\000\022\001\022\001\068\000\
\031\001\068\000\022\001\073\000\074\000\075\000\076\000\077\000\
\078\000\079\000\080\000\081\000\082\000\083\000\084\000\085\000\
\086\000\087\000\088\000\089\000\090\000\031\001\019\001\022\001\
\022\001\039\000\022\001\022\001\022\001\255\255\099\000\100\000\
\099\000\100\000\001\001\002\001\003\001\004\001\005\001\006\001\
\007\001\008\001\094\000\010\001\011\001\012\001\011\001\012\001\
\013\001\014\001\012\001\255\255\019\001\122\000\021\001\122\000\
\023\001\022\001\025\001\024\001\022\001\255\255\024\001\255\255\
\031\001\032\001\033\001\034\001\035\001\001\001\002\001\003\001\
\004\001\005\001\006\001\007\001\008\001\009\001\255\255\011\001\
\012\001\013\001\014\001\015\001\016\001\017\001\018\001\019\001\
\255\255\021\001\255\255\255\255\255\255\255\255\026\001\027\001\
\028\001\255\255\255\255\031\001\001\001\002\001\003\001\004\001\
\005\001\006\001\007\001\008\001\255\255\255\255\011\001\012\001\
\013\001\014\001\015\001\016\001\017\001\018\001\019\001\255\255\
\255\255\022\001\255\255\024\001\001\001\002\001\003\001\004\001\
\005\001\006\001\007\001\008\001\255\255\255\255\011\001\012\001\
\013\001\014\001\015\001\016\001\017\001\018\001\019\001\255\255\
\255\255\255\255\255\255\024\001\001\001\002\001\003\001\004\001\
\005\001\006\001\007\001\008\001\255\255\255\255\011\001\012\001\
\013\001\014\001\015\001\016\001\017\001\018\001\255\255\255\255\
\255\255\022\001\255\255\024\001\001\001\002\001\003\001\004\001\
\005\001\006\001\007\001\008\001\255\255\255\255\011\001\012\001\
\013\001\014\001\015\001\016\001\017\001\018\001\019\001\255\255\
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
\255\255\022\001\255\255\024\001\001\001\002\001\255\255\255\255\
\005\001\006\001\255\255\255\255\255\255\255\255\011\001\012\001\
\013\001\014\001\015\001\016\001\017\001\018\001\255\255\255\255\
\255\255\022\001\255\255\024\001\001\001\002\001\003\001\004\001\
\005\001\006\001\007\001\008\001\255\255\255\255\011\001\012\001\
\013\001\014\001\015\001\016\001\017\001\018\001\019\001\255\255\
\255\255\022\001\001\001\002\001\003\001\004\001\005\001\006\001\
\007\001\008\001\255\255\255\255\011\001\255\255\013\001\014\001\
\015\001\016\001\017\001\018\001\019\001\001\001\002\001\003\001\
\004\001\005\001\006\001\007\001\008\001\255\255\255\255\255\255\
\255\255\013\001\014\001\015\001\016\001\017\001\018\001\019\001\
\001\001\002\001\003\001\004\001\005\001\006\001\007\001\008\001\
\255\255\255\255\255\255\255\255\255\255\255\255\015\001\016\001\
\017\001\018\001\019\001\011\001\012\001\013\001\014\001\015\001\
\016\001\017\001\018\001\255\255\255\255\255\255\022\001\255\255\
\024\001\011\001\012\001\013\001\014\001\015\001\016\001\017\001\
\018\001\255\255\255\255\255\255\022\001\255\255\024\001\011\001\
\012\001\013\001\014\001\015\001\016\001\017\001\018\001\255\255\
\255\255\255\255\022\001\255\255\024\001\011\001\012\001\013\001\
\014\001\015\001\016\001\017\001\018\001\255\255\255\255\255\255\
\022\001\255\255\024\001"

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
# 379 "parser.ml"
               : Ast.program))
; (fun __caml_parser_env ->
    Obj.repr(
# 32 "parser.mly"
               ( [] )
# 385 "parser.ml"
               : 'expr_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr_list) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 33 "parser.mly"
                      ( _2 :: _1 )
# 393 "parser.ml"
               : 'expr_list))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 36 "parser.mly"
                       ( Let(_2, _3, _4) )
# 402 "parser.ml"
               : 'sexpr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 37 "parser.mly"
                     ( If(_2, _3, _4) )
# 411 "parser.ml"
               : 'sexpr))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'formals_opt) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 38 "parser.mly"
                                      ( Fdecl(List.rev _3, _5) )
# 419 "parser.ml"
               : 'sexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'call) in
    Obj.repr(
# 39 "parser.mly"
          ( _1 )
# 426 "parser.ml"
               : 'sexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atom) in
    Obj.repr(
# 42 "parser.mly"
          ( _1 )
# 433 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'list) in
    Obj.repr(
# 43 "parser.mly"
          ( _1 )
# 440 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'infix_expr) in
    Obj.repr(
# 44 "parser.mly"
                           ( _2 )
# 447 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'sexpr) in
    Obj.repr(
# 45 "parser.mly"
                       ( _2 )
# 454 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'args_opt) in
    Obj.repr(
# 48 "parser.mly"
                                ( List(List.rev _3) )
# 461 "parser.ml"
               : 'list))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'sexpr) in
    Obj.repr(
# 51 "parser.mly"
                      ( _2 )
# 468 "parser.ml"
               : 'rlist))
; (fun __caml_parser_env ->
    Obj.repr(
# 54 "parser.mly"
               ( [] )
# 474 "parser.ml"
               : 'formals_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'formal_list) in
    Obj.repr(
# 55 "parser.mly"
              ( _1 )
# 481 "parser.ml"
               : 'formals_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 58 "parser.mly"
        ( [_1] )
# 488 "parser.ml"
               : 'formal_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'formal_list) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 59 "parser.mly"
                  ( _2 :: _1 )
# 496 "parser.ml"
               : 'formal_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'constant) in
    Obj.repr(
# 62 "parser.mly"
            ( _1 )
# 503 "parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 63 "parser.mly"
       ( Id(_1) )
# 510 "parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    Obj.repr(
# 64 "parser.mly"
        ( Nil )
# 516 "parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'operator) in
    Obj.repr(
# 65 "parser.mly"
            ( Id(_1) )
# 523 "parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    Obj.repr(
# 68 "parser.mly"
         ( "__add" )
# 529 "parser.ml"
               : 'operator))
; (fun __caml_parser_env ->
    Obj.repr(
# 69 "parser.mly"
          ( "__sub" )
# 535 "parser.ml"
               : 'operator))
; (fun __caml_parser_env ->
    Obj.repr(
# 70 "parser.mly"
          ( "__mult" )
# 541 "parser.ml"
               : 'operator))
; (fun __caml_parser_env ->
    Obj.repr(
# 71 "parser.mly"
          ( "__div" )
# 547 "parser.ml"
               : 'operator))
; (fun __caml_parser_env ->
    Obj.repr(
# 72 "parser.mly"
          ( "__addf" )
# 553 "parser.ml"
               : 'operator))
; (fun __caml_parser_env ->
    Obj.repr(
# 73 "parser.mly"
          ( "__subf" )
# 559 "parser.ml"
               : 'operator))
; (fun __caml_parser_env ->
    Obj.repr(
# 74 "parser.mly"
           ( "__divf" )
# 565 "parser.ml"
               : 'operator))
; (fun __caml_parser_env ->
    Obj.repr(
# 75 "parser.mly"
          ( "__multf" )
# 571 "parser.ml"
               : 'operator))
; (fun __caml_parser_env ->
    Obj.repr(
# 76 "parser.mly"
        ( "__and" )
# 577 "parser.ml"
               : 'operator))
; (fun __caml_parser_env ->
    Obj.repr(
# 77 "parser.mly"
       ( "__or" )
# 583 "parser.ml"
               : 'operator))
; (fun __caml_parser_env ->
    Obj.repr(
# 78 "parser.mly"
          ( "__concat" )
# 589 "parser.ml"
               : 'operator))
; (fun __caml_parser_env ->
    Obj.repr(
# 81 "parser.mly"
          ( "__equal" )
# 595 "parser.ml"
               : 'two_args_operators))
; (fun __caml_parser_env ->
    Obj.repr(
# 82 "parser.mly"
          ( "__neq" )
# 601 "parser.ml"
               : 'two_args_operators))
; (fun __caml_parser_env ->
    Obj.repr(
# 83 "parser.mly"
          ( "__less" )
# 607 "parser.ml"
               : 'two_args_operators))
; (fun __caml_parser_env ->
    Obj.repr(
# 84 "parser.mly"
          ( "__leq" )
# 613 "parser.ml"
               : 'two_args_operators))
; (fun __caml_parser_env ->
    Obj.repr(
# 85 "parser.mly"
          ( "__greater" )
# 619 "parser.ml"
               : 'two_args_operators))
; (fun __caml_parser_env ->
    Obj.repr(
# 86 "parser.mly"
          ( "__geq" )
# 625 "parser.ml"
               : 'two_args_operators))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 89 "parser.mly"
         ( Int(_1) )
# 632 "parser.ml"
               : 'constant))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : float) in
    Obj.repr(
# 90 "parser.mly"
          ( Float(_1) )
# 639 "parser.ml"
               : 'constant))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : bool) in
    Obj.repr(
# 91 "parser.mly"
         ( Boolean(_1) )
# 646 "parser.ml"
               : 'constant))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 92 "parser.mly"
          ( String(_1) )
# 653 "parser.ml"
               : 'constant))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'args_opt) in
    Obj.repr(
# 95 "parser.mly"
               ( Eval(String(_1), List.rev _2) )
# 661 "parser.ml"
               : 'call))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'rlist) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'args_opt) in
    Obj.repr(
# 96 "parser.mly"
                   ( Eval(_1, List.rev _2) )
# 669 "parser.ml"
               : 'call))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'operator) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'args_opt) in
    Obj.repr(
# 97 "parser.mly"
                     ( Eval(String(_1), List.rev _2) )
# 677 "parser.ml"
               : 'call))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'two_args_operators) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'two_args) in
    Obj.repr(
# 98 "parser.mly"
                              ( Eval(String(_1), List.rev _2))
# 685 "parser.ml"
               : 'call))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'assign_args) in
    Obj.repr(
# 99 "parser.mly"
                     ( Assign(List.rev _2) )
# 692 "parser.ml"
               : 'call))
; (fun __caml_parser_env ->
    Obj.repr(
# 102 "parser.mly"
                ( [] )
# 698 "parser.ml"
               : 'args_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 103 "parser.mly"
         ( _1 )
# 705 "parser.ml"
               : 'args_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 106 "parser.mly"
          ( [_2; _1] )
# 713 "parser.ml"
               : 'two_args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 109 "parser.mly"
         ( [_1] )
# 720 "parser.ml"
               : 'args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'args) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 110 "parser.mly"
             ( _2 :: _1 )
# 728 "parser.ml"
               : 'args))
; (fun __caml_parser_env ->
    Obj.repr(
# 113 "parser.mly"
               ( [] )
# 734 "parser.ml"
               : 'assign_args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'assign_args) in
    Obj.repr(
# 114 "parser.mly"
                        ( _2 :: Id(_1) :: _3 )
# 743 "parser.ml"
               : 'assign_args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'constant) in
    Obj.repr(
# 117 "parser.mly"
             ( _1 )
# 750 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 118 "parser.mly"
        ( Id(_1) )
# 757 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 119 "parser.mly"
              ( Int(-1 * _2) )
# 764 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : float) in
    Obj.repr(
# 120 "parser.mly"
                ( Float(-1.0 *. _2) )
# 771 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'infix_expr) in
    Obj.repr(
# 121 "parser.mly"
                           ( _2 )
# 778 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 122 "parser.mly"
                        ( Assign([Id(_1); _3]) )
# 786 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 123 "parser.mly"
                                ( Eval(String("__concat"), [_1; _3]) )
# 794 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 124 "parser.mly"
                             ( Eval(String("__add"), [_1; _3]) )
# 802 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 125 "parser.mly"
                              ( Eval(String("__sub"), [_1; _3])  )
# 810 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 126 "parser.mly"
                              ( Eval(String("__mult"), [_1; _3]) )
# 818 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 127 "parser.mly"
                               ( Eval(String("__div"), [_1; _3])  )
# 826 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 128 "parser.mly"
                              ( Eval(String("__addf"), [_1; _3]) )
# 834 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 129 "parser.mly"
                               ( Eval(String("__subf"), [_1; _3]) )
# 842 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 130 "parser.mly"
                               ( Eval(String("__multf"), [_1; _3]) )
# 850 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 131 "parser.mly"
                                ( Eval(String("__divf"), [_1; _3]) )
# 858 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 132 "parser.mly"
                           ( Eval(String("__equal"), [_1; _3]) )
# 866 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 133 "parser.mly"
                            ( Eval(String("__neq"), [_1; _3]) )
# 874 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 134 "parser.mly"
                           ( Eval(String("__add"), [_1; _3]) )
# 882 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 135 "parser.mly"
                            ( Eval(String("__less"), [_1; _3]) )
# 890 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 136 "parser.mly"
                           ( Eval(String("__greater"), [_1; _3]) )
# 898 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 137 "parser.mly"
                            ( Eval(String("__geq"), [_1; _3]) )
# 906 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 138 "parser.mly"
                            ( Eval(String("__and"), [_1; _3]) )
# 914 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 139 "parser.mly"
                           ( Eval(String("__or"), [_1; _3]) )
# 922 "parser.ml"
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
