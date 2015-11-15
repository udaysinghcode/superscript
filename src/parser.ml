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
  | SEMI
  | LPAREN
  | RPAREN
  | LBRACE
  | RBRACE
  | INT of (int)
  | FUNC
  | LET
  | IN
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
  275 (* SEMI *);
  276 (* LPAREN *);
  277 (* RPAREN *);
  278 (* LBRACE *);
  279 (* RBRACE *);
  281 (* FUNC *);
  282 (* LET *);
  283 (* IN *);
  284 (* IF *);
  285 (* FOR *);
  286 (* WHILE *);
  291 (* NIL *);
    0|]

let yytransl_block = [|
  280 (* INT *);
  287 (* ID *);
  288 (* STRING *);
  289 (* FLOAT *);
  290 (* BOOL *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\004\000\004\000\004\000\004\000\004\000\
\004\000\003\000\003\000\003\000\003\000\005\000\005\000\010\000\
\010\000\007\000\007\000\007\000\008\000\011\000\011\000\011\000\
\011\000\006\000\006\000\006\000\006\000\006\000\006\000\006\000\
\006\000\006\000\006\000\006\000\006\000\006\000\006\000\006\000\
\006\000\006\000\006\000\012\000\012\000\013\000\013\000\009\000\
\009\000\009\000\009\000\009\000\009\000\009\000\009\000\009\000\
\009\000\009\000\009\000\009\000\009\000\009\000\009\000\009\000\
\009\000\009\000\000\000"

let yylen = "\002\000\
\002\000\000\000\003\000\005\000\004\000\005\000\003\000\005\000\
\001\000\001\000\001\000\003\000\003\000\000\000\001\000\001\000\
\002\000\001\000\001\000\001\000\004\000\001\000\001\000\001\000\
\001\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
\002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
\002\000\002\000\002\000\000\000\001\000\001\000\002\000\001\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\003\000\002\000"

let yydefred = "\000\000\
\002\000\000\000\067\000\000\000\001\000\000\000\000\000\000\000\
\022\000\019\000\025\000\023\000\024\000\020\000\000\000\010\000\
\011\000\018\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\009\000\000\000\000\000\048\000\000\000\
\003\000\000\000\000\000\045\000\027\000\028\000\029\000\030\000\
\031\000\032\000\033\000\034\000\043\000\041\000\042\000\035\000\
\036\000\037\000\038\000\039\000\040\000\000\000\000\000\000\000\
\000\000\000\000\026\000\013\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\012\000\047\000\
\021\000\016\000\000\000\000\000\000\000\000\000\000\000\007\000\
\049\000\000\000\000\000\000\000\053\000\054\000\000\000\000\000\
\057\000\058\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\017\000\000\000\005\000\000\000\008\000\
\004\000\006\000"

let yydgoto = "\002\000\
\003\000\004\000\050\000\043\000\099\000\044\000\016\000\017\000\
\048\000\100\000\018\000\051\000\052\000"

let yysindex = "\003\000\
\000\000\000\000\000\000\001\000\000\000\242\254\099\255\105\000\
\000\000\000\000\000\000\000\000\000\000\000\000\014\255\000\000\
\000\000\000\000\112\255\112\255\112\255\112\255\112\255\112\255\
\112\255\112\255\112\255\112\255\112\255\112\255\112\255\112\255\
\112\255\112\255\112\255\112\255\039\255\003\255\112\255\112\255\
\112\255\112\255\042\255\000\000\105\000\051\255\000\000\170\255\
\000\000\112\255\043\255\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\034\255\112\255\112\255\
\112\255\112\255\000\000\000\000\059\000\105\000\105\000\105\000\
\105\000\105\000\105\000\105\000\105\000\105\000\105\000\105\000\
\105\000\105\000\105\000\105\000\105\000\105\000\000\000\000\000\
\000\000\000\000\045\255\040\255\062\255\112\255\112\255\000\000\
\000\000\002\000\054\255\054\255\000\000\000\000\054\255\054\255\
\000\000\000\000\098\000\080\000\116\000\116\000\024\255\024\255\
\024\255\024\255\112\255\000\000\112\255\000\000\112\255\000\000\
\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\069\255\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\069\255\000\000\000\000\000\000\147\255\000\000\000\000\
\000\000\070\255\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\071\255\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\072\255\000\000\000\000\000\000\000\000\
\000\000\238\254\189\255\212\255\000\000\000\000\235\255\036\000\
\000\000\000\000\190\000\097\255\182\000\186\000\130\000\143\000\
\156\000\169\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\252\255\000\000\000\000\000\000\250\255\000\000\
\218\255\000\000\000\000\052\000\244\255"

let yytablesize = 469
let yytable = "\015\000\
\005\000\047\000\050\000\001\000\050\000\019\000\077\000\053\000\
\054\000\055\000\056\000\057\000\058\000\059\000\060\000\061\000\
\062\000\063\000\064\000\065\000\066\000\067\000\068\000\069\000\
\079\000\080\000\081\000\082\000\083\000\084\000\085\000\086\000\
\049\000\071\000\072\000\073\000\074\000\096\000\047\000\106\000\
\107\000\108\000\109\000\110\000\111\000\112\000\113\000\114\000\
\115\000\116\000\117\000\118\000\119\000\120\000\121\000\122\000\
\081\000\082\000\070\000\078\000\085\000\086\000\076\000\097\000\
\098\000\123\000\101\000\102\000\103\000\104\000\124\000\047\000\
\047\000\047\000\047\000\047\000\047\000\047\000\047\000\047\000\
\047\000\047\000\047\000\047\000\047\000\047\000\047\000\047\000\
\125\000\044\000\046\000\014\000\015\000\075\000\000\000\000\000\
\000\000\126\000\127\000\020\000\021\000\022\000\023\000\024\000\
\025\000\026\000\027\000\028\000\066\000\029\000\030\000\031\000\
\032\000\033\000\034\000\035\000\036\000\066\000\128\000\066\000\
\129\000\006\000\130\000\037\000\038\000\000\000\039\000\040\000\
\041\000\042\000\000\000\007\000\000\000\008\000\000\000\009\000\
\000\000\000\000\000\000\000\000\000\000\000\000\010\000\011\000\
\012\000\013\000\014\000\019\000\019\000\019\000\019\000\019\000\
\019\000\019\000\019\000\000\000\000\000\019\000\019\000\019\000\
\019\000\019\000\019\000\019\000\019\000\000\000\000\000\019\000\
\000\000\019\000\079\000\080\000\081\000\082\000\083\000\084\000\
\085\000\086\000\000\000\000\000\087\000\088\000\089\000\090\000\
\091\000\092\000\093\000\094\000\000\000\051\000\051\000\000\000\
\095\000\051\000\051\000\000\000\000\000\000\000\000\000\051\000\
\051\000\051\000\051\000\051\000\051\000\051\000\051\000\000\000\
\000\000\051\000\000\000\051\000\052\000\052\000\000\000\000\000\
\052\000\052\000\000\000\000\000\000\000\000\000\052\000\052\000\
\052\000\052\000\052\000\052\000\052\000\052\000\000\000\000\000\
\052\000\000\000\052\000\055\000\055\000\000\000\000\000\055\000\
\055\000\000\000\000\000\000\000\000\000\055\000\055\000\055\000\
\055\000\055\000\055\000\055\000\055\000\000\000\000\000\055\000\
\000\000\055\000\079\000\080\000\081\000\082\000\083\000\084\000\
\085\000\086\000\006\000\000\000\087\000\088\000\089\000\090\000\
\091\000\092\000\093\000\094\000\007\000\000\000\008\000\000\000\
\009\000\000\000\000\000\000\000\000\000\000\000\000\000\010\000\
\011\000\012\000\013\000\014\000\056\000\056\000\000\000\000\000\
\056\000\056\000\000\000\000\000\000\000\000\000\056\000\056\000\
\056\000\056\000\056\000\056\000\056\000\056\000\000\000\000\000\
\056\000\000\000\056\000\079\000\080\000\081\000\082\000\083\000\
\084\000\085\000\086\000\000\000\000\000\087\000\088\000\089\000\
\090\000\091\000\092\000\093\000\094\000\000\000\000\000\105\000\
\079\000\080\000\081\000\082\000\083\000\084\000\085\000\086\000\
\000\000\000\000\087\000\000\000\089\000\090\000\091\000\092\000\
\093\000\094\000\079\000\080\000\081\000\082\000\083\000\084\000\
\085\000\086\000\000\000\000\000\000\000\000\000\089\000\090\000\
\091\000\092\000\093\000\094\000\079\000\080\000\081\000\082\000\
\083\000\084\000\085\000\086\000\045\000\000\000\000\000\000\000\
\009\000\000\000\091\000\092\000\093\000\094\000\000\000\046\000\
\011\000\012\000\013\000\014\000\061\000\061\000\061\000\061\000\
\061\000\061\000\061\000\061\000\000\000\000\000\061\000\000\000\
\061\000\062\000\062\000\062\000\062\000\062\000\062\000\062\000\
\062\000\000\000\000\000\062\000\000\000\062\000\063\000\063\000\
\063\000\063\000\063\000\063\000\063\000\063\000\000\000\000\000\
\063\000\000\000\063\000\064\000\064\000\064\000\064\000\064\000\
\064\000\064\000\064\000\000\000\000\000\064\000\000\000\064\000\
\059\000\059\000\059\000\059\000\060\000\060\000\060\000\060\000\
\065\000\065\000\059\000\000\000\059\000\000\000\060\000\000\000\
\060\000\000\000\065\000\000\000\065\000"

let yycheck = "\004\000\
\000\000\008\000\021\001\001\000\023\001\020\001\045\000\020\000\
\021\000\022\000\023\000\024\000\025\000\026\000\027\000\028\000\
\029\000\030\000\031\000\032\000\033\000\034\000\035\000\036\000\
\001\001\002\001\003\001\004\001\005\001\006\001\007\001\008\001\
\019\001\031\001\039\000\040\000\041\000\050\000\045\000\078\000\
\079\000\080\000\081\000\082\000\083\000\084\000\085\000\086\000\
\087\000\088\000\089\000\090\000\091\000\092\000\093\000\094\000\
\003\001\004\001\020\001\009\001\007\001\008\001\021\001\021\001\
\031\001\021\001\071\000\072\000\073\000\074\000\031\001\078\000\
\079\000\080\000\081\000\082\000\083\000\084\000\085\000\086\000\
\087\000\088\000\089\000\090\000\091\000\092\000\093\000\094\000\
\027\001\021\001\021\001\021\001\021\001\042\000\255\255\255\255\
\255\255\102\000\103\000\001\001\002\001\003\001\004\001\005\001\
\006\001\007\001\008\001\009\001\012\001\011\001\012\001\013\001\
\014\001\015\001\016\001\017\001\018\001\021\001\123\000\023\001\
\125\000\010\001\127\000\025\001\026\001\255\255\028\001\029\001\
\030\001\031\001\255\255\020\001\255\255\022\001\255\255\024\001\
\255\255\255\255\255\255\255\255\255\255\255\255\031\001\032\001\
\033\001\034\001\035\001\001\001\002\001\003\001\004\001\005\001\
\006\001\007\001\008\001\255\255\255\255\011\001\012\001\013\001\
\014\001\015\001\016\001\017\001\018\001\255\255\255\255\021\001\
\255\255\023\001\001\001\002\001\003\001\004\001\005\001\006\001\
\007\001\008\001\255\255\255\255\011\001\012\001\013\001\014\001\
\015\001\016\001\017\001\018\001\255\255\001\001\002\001\255\255\
\023\001\005\001\006\001\255\255\255\255\255\255\255\255\011\001\
\012\001\013\001\014\001\015\001\016\001\017\001\018\001\255\255\
\255\255\021\001\255\255\023\001\001\001\002\001\255\255\255\255\
\005\001\006\001\255\255\255\255\255\255\255\255\011\001\012\001\
\013\001\014\001\015\001\016\001\017\001\018\001\255\255\255\255\
\021\001\255\255\023\001\001\001\002\001\255\255\255\255\005\001\
\006\001\255\255\255\255\255\255\255\255\011\001\012\001\013\001\
\014\001\015\001\016\001\017\001\018\001\255\255\255\255\021\001\
\255\255\023\001\001\001\002\001\003\001\004\001\005\001\006\001\
\007\001\008\001\010\001\255\255\011\001\012\001\013\001\014\001\
\015\001\016\001\017\001\018\001\020\001\255\255\022\001\255\255\
\024\001\255\255\255\255\255\255\255\255\255\255\255\255\031\001\
\032\001\033\001\034\001\035\001\001\001\002\001\255\255\255\255\
\005\001\006\001\255\255\255\255\255\255\255\255\011\001\012\001\
\013\001\014\001\015\001\016\001\017\001\018\001\255\255\255\255\
\021\001\255\255\023\001\001\001\002\001\003\001\004\001\005\001\
\006\001\007\001\008\001\255\255\255\255\011\001\012\001\013\001\
\014\001\015\001\016\001\017\001\018\001\255\255\255\255\021\001\
\001\001\002\001\003\001\004\001\005\001\006\001\007\001\008\001\
\255\255\255\255\011\001\255\255\013\001\014\001\015\001\016\001\
\017\001\018\001\001\001\002\001\003\001\004\001\005\001\006\001\
\007\001\008\001\255\255\255\255\255\255\255\255\013\001\014\001\
\015\001\016\001\017\001\018\001\001\001\002\001\003\001\004\001\
\005\001\006\001\007\001\008\001\020\001\255\255\255\255\255\255\
\024\001\255\255\015\001\016\001\017\001\018\001\255\255\031\001\
\032\001\033\001\034\001\035\001\011\001\012\001\013\001\014\001\
\015\001\016\001\017\001\018\001\255\255\255\255\021\001\255\255\
\023\001\011\001\012\001\013\001\014\001\015\001\016\001\017\001\
\018\001\255\255\255\255\021\001\255\255\023\001\011\001\012\001\
\013\001\014\001\015\001\016\001\017\001\018\001\255\255\255\255\
\021\001\255\255\023\001\011\001\012\001\013\001\014\001\015\001\
\016\001\017\001\018\001\255\255\255\255\021\001\255\255\023\001\
\011\001\012\001\013\001\014\001\011\001\012\001\013\001\014\001\
\011\001\012\001\021\001\255\255\023\001\255\255\021\001\255\255\
\023\001\255\255\021\001\255\255\023\001"

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
  SEMI\000\
  LPAREN\000\
  RPAREN\000\
  LBRACE\000\
  RBRACE\000\
  FUNC\000\
  LET\000\
  IN\000\
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
# 28 "parser.mly"
                ( List.rev _1 )
# 346 "parser.ml"
               : Ast.program))
; (fun __caml_parser_env ->
    Obj.repr(
# 31 "parser.mly"
               ( [] )
# 352 "parser.ml"
               : 'expr_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr_list) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 32 "parser.mly"
                      ( _2 :: _1 )
# 360 "parser.ml"
               : 'expr_list))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 35 "parser.mly"
                         ( Let(_2, _3, _5) )
# 369 "parser.ml"
               : 'sexpr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 36 "parser.mly"
                     ( If(_2, _3, _4) )
# 378 "parser.ml"
               : 'sexpr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 37 "parser.mly"
                          ( For(_2, _3, _4, _5))
# 388 "parser.ml"
               : 'sexpr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 38 "parser.mly"
                   ( While(_2, _3) )
# 396 "parser.ml"
               : 'sexpr))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'formals_opt) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 39 "parser.mly"
                                      ( Fdecl(List.rev _3, _5) )
# 404 "parser.ml"
               : 'sexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'call) in
    Obj.repr(
# 40 "parser.mly"
          ( _1 )
# 411 "parser.ml"
               : 'sexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atom) in
    Obj.repr(
# 43 "parser.mly"
          ( _1 )
# 418 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'list) in
    Obj.repr(
# 44 "parser.mly"
          ( _1 )
# 425 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'infix_expr) in
    Obj.repr(
# 45 "parser.mly"
                           ( _2 )
# 432 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'sexpr) in
    Obj.repr(
# 46 "parser.mly"
                       ( _2 )
# 439 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 49 "parser.mly"
               ( [] )
# 445 "parser.ml"
               : 'formals_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'formal_list) in
    Obj.repr(
# 50 "parser.mly"
              ( List.rev _1 )
# 452 "parser.ml"
               : 'formals_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 53 "parser.mly"
        ( [_1] )
# 459 "parser.ml"
               : 'formal_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'formal_list) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 54 "parser.mly"
                  ( _2 :: _1 )
# 467 "parser.ml"
               : 'formal_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'constant) in
    Obj.repr(
# 57 "parser.mly"
            ( _1 )
# 474 "parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 58 "parser.mly"
       ( Id(_1) )
# 481 "parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    Obj.repr(
# 59 "parser.mly"
        ( Nil )
# 487 "parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'args_opt) in
    Obj.repr(
# 62 "parser.mly"
                               ( List(List.rev _3) )
# 494 "parser.ml"
               : 'list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 65 "parser.mly"
        ( Int(_1) )
# 501 "parser.ml"
               : 'constant))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : float) in
    Obj.repr(
# 66 "parser.mly"
          ( Float(_1) )
# 508 "parser.ml"
               : 'constant))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : bool) in
    Obj.repr(
# 67 "parser.mly"
         ( Boolean(_1) )
# 515 "parser.ml"
               : 'constant))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 68 "parser.mly"
          ( String(_1) )
# 522 "parser.ml"
               : 'constant))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'args_opt) in
    Obj.repr(
# 71 "parser.mly"
               ( Eval(_1, List.rev _2) )
# 530 "parser.ml"
               : 'call))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 72 "parser.mly"
              ( ListOp(Add, List.rev _2) )
# 537 "parser.ml"
               : 'call))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 73 "parser.mly"
                 ( ListOp(Sub, List.rev _2) )
# 544 "parser.ml"
               : 'call))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 74 "parser.mly"
                 ( ListOp(Mult, List.rev _2) )
# 551 "parser.ml"
               : 'call))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 75 "parser.mly"
                  ( ListOp(Div, List.rev _2) )
# 558 "parser.ml"
               : 'call))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 76 "parser.mly"
               ( ListOp(Addf, List.rev _2) )
# 565 "parser.ml"
               : 'call))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 77 "parser.mly"
                  ( ListOp(Subf, List.rev _2) )
# 572 "parser.ml"
               : 'call))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 78 "parser.mly"
                  ( ListOp(Multf, List.rev _2) )
# 579 "parser.ml"
               : 'call))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 79 "parser.mly"
                   ( ListOp(Divf, List.rev _2) )
# 586 "parser.ml"
               : 'call))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 80 "parser.mly"
            ( ListOp(Equal, List.rev _2) )
# 593 "parser.ml"
               : 'call))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 81 "parser.mly"
             ( ListOp(Neq, List.rev _2) )
# 600 "parser.ml"
               : 'call))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 82 "parser.mly"
            ( ListOp(Less, List.rev _2) )
# 607 "parser.ml"
               : 'call))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 83 "parser.mly"
             ( ListOp(Leq, List.rev _2) )
# 614 "parser.ml"
               : 'call))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 84 "parser.mly"
            ( ListOp(Greater, List.rev _2) )
# 621 "parser.ml"
               : 'call))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 85 "parser.mly"
             ( ListOp(Geq, List.rev _2) )
# 628 "parser.ml"
               : 'call))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 86 "parser.mly"
             ( ListOp(And, List.rev _2) )
# 635 "parser.ml"
               : 'call))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 87 "parser.mly"
            ( ListOp(Or, List.rev _2) )
# 642 "parser.ml"
               : 'call))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 88 "parser.mly"
               ( ListOp(Assign, List.rev _2) )
# 649 "parser.ml"
               : 'call))
; (fun __caml_parser_env ->
    Obj.repr(
# 91 "parser.mly"
                ( [] )
# 655 "parser.ml"
               : 'args_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 92 "parser.mly"
         ( List.rev _1 )
# 662 "parser.ml"
               : 'args_opt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 95 "parser.mly"
         ( [_1] )
# 669 "parser.ml"
               : 'args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'args) in
    Obj.repr(
# 96 "parser.mly"
             ( _1 :: _2 )
# 677 "parser.ml"
               : 'args))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atom) in
    Obj.repr(
# 99 "parser.mly"
          ( _1 )
# 684 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'infix_expr) in
    Obj.repr(
# 100 "parser.mly"
                           ( _2 )
# 691 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 101 "parser.mly"
                        ( Assign(_1, _3) )
# 699 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 102 "parser.mly"
                             ( Binop(_1, Add, _3) )
# 707 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 103 "parser.mly"
                              ( Binop(_1, Sub, _3) )
# 715 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 104 "parser.mly"
                              ( Binop(_1, Mult, _3) )
# 723 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 105 "parser.mly"
                               ( Binop(_1, Div, _3) )
# 731 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 106 "parser.mly"
                              ( Binop(_1, Addf, _3) )
# 739 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 107 "parser.mly"
                               ( Binop(_1, Subf, _3) )
# 747 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 108 "parser.mly"
                               ( Binop(_1, Multf, _3) )
# 755 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 109 "parser.mly"
                                ( Binop(_1, Divf, _3) )
# 763 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 110 "parser.mly"
                           ( Binop(_1, Equal, _3) )
# 771 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 111 "parser.mly"
                            ( Binop(_1, Neq, _3) )
# 779 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 112 "parser.mly"
                           ( Binop(_1, Less, _3) )
# 787 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 113 "parser.mly"
                            ( Binop(_1, Leq, _3) )
# 795 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 114 "parser.mly"
                           ( Binop(_1, Greater, _3) )
# 803 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 115 "parser.mly"
                            ( Binop(_1, Geq, _3) )
# 811 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 116 "parser.mly"
                            ( Binop(_1, And, _3) )
# 819 "parser.ml"
               : 'infix_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'infix_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'infix_expr) in
    Obj.repr(
# 117 "parser.mly"
                           ( Binop(_1, Or, _3) )
# 827 "parser.ml"
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
