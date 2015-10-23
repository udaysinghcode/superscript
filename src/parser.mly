%{ open Ast %}

%token PLUS MINUS TIMES DIVIDE PLUSF MINUSF TIMESF DIVIDEF EOF
%token ASSIGN QUOTE AND OR EQ NEQ LT LEQ GT GEQ IF
%token LPAREN RPAREN LBRACE RBRACE LSQBRACE RSQBRACE
%token <int> INT
%token <string> ID
%token <string> STRING
%token <float> FLOAT
%token <bool> BOOL

%right ASSIGN
%left OR
%left AND
%left EQ NEQ
%left LT GT LEQ GEQ
%left PLUS MINUS PLUSF MINUSF
%left TIMES DIVIDE TIMESF DIVIDEF

%start expr
%type < Ast.expr> expr

%%
expr:
  LPAREN expr RPAREN		{ $2 }
| INT				{ Int($1) }
| FLOAT				{ Float($1) }
| BOOL				{ Boolean($1) }
| STRING			{ String($1) }
| ID				{ Id($1) }
| LPAREN RPAREN			{ Nil }
| LPAREN expr expr expr_list RPAREN  { List($2 :: $3 :: List.rev($4)) }
| LSQBRACE infix_expr RSQBRACE	{ $2 }
| ID LBRACE expr_list RBRACE    { Func($1, $3) }
| IF expr expr expr		{ If($2, $3, $4) }

infix_expr:
  expr				{ $1 }
| ID ASSIGN infix_expr		{ Assign($1, $3) }
| infix_expr PLUS infix_expr	{ Binop($1, Add, $3) }
| infix_expr MINUS infix_expr	{ Binop($1, Sub, $3) }
| infix_expr TIMES infix_expr	{ Binop($1, Mult, $3) }
| infix_expr DIVIDE infix_expr	{ Binop($1, Div, $3) }
| infix_expr PLUSF infix_expr	{ Binop($1, Addf, $3) }
| infix_expr MINUSF infix_expr	{ Binop($1, Subf, $3) }
| infix_expr TIMESF infix_expr	{ Binop($1, Multf, $3) }
| infix_expr DIVIDEF infix_expr	{ Binop($1, Divf, $3) }
| infix_expr EQ infix_expr	{ Binop($1, Equal, $3) }
| infix_expr NEQ infix_expr	{ Binop($1, Neq, $3) }
| infix_expr LT infix_expr	{ Binop($1, Less, $3) }
| infix_expr LEQ infix_expr	{ Binop($1, Leq, $3) }
| infix_expr GT infix_expr	{ Binop($1, Greater, $3) }
| infix_expr GEQ infix_expr	{ Binop($1, Geq, $3) }
| infix_expr AND infix_expr	{ Binop($1, And, $3) }
| infix_expr OR infix_expr	{ Binop($1, Or, $3) }

expr_list:
/* nothing */		{ [] }
| expr_list expr	{ $2 :: $1 }
