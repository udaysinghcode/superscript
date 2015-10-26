%{ open Ast %}

%token PLUS MINUS TIMES DIVIDE PLUSF MINUSF TIMESF DIVIDEF EOF
%token ASSIGN QUOTE AND OR EQ NEQ LT LEQ GT GEQ
%token SEMI LPAREN RPAREN LBRACE RBRACE
%token <int> INT
%token FUNC LET IN IF FOR WHILE
%token <string> ID
%token <string> STRING
%token <float> FLOAT
%token <bool> BOOL
%token NIL

%right ASSIGN
%left OR
%left AND
%left EQ NEQ
%left LT GT LEQ GEQ
%left PLUS MINUS PLUSF MINUSF
%left TIMES DIVIDE TIMESF DIVIDEF

%start program
%type < Ast.program> program

%%

program:
 expr_list EOF		{ List.rev $1 }

expr_list:
/* nothing */		{ [] }
| expr			{ [$1] }
| expr SEMI expr_list	{ $1 :: $3 }

expr:
  LET ID expr IN expr   { Let($2, $3, $5) }
| IF expr expr expr	{ If($2, $3, $4) }
| FOR expr expr expr	{ For($2, $3, $4) }
| WHILE expr expr	{ While($2, $3) }
| atom			{ $1 }
| list			{ $1 }
| LBRACE infix_expr RBRACE { $2 }
| FUNC ID formal_args LPAREN expr_list RPAREN { Fdecl($2, List.rev $3, $5) }

formal_args:
  ID		{ $1 }
| ID formal_args { $1 :: $2 }

atom:
  constant		{ $1 }
| ID			{ Id($1) }
| NIL			{ Nil }

list:
  QUOTE LPAREN args RPAREN { List.rev $3 }
| call			   { $1 }

constant: 
  INT			{ Int($1) }
| FLOAT			{ Float($1) }
| BOOL			{ Bool($1) }
| STRING		{ String($1) }

call:
  LPAREN ID args RPAREN	{ Eval($2, List.rev $3) }
| LPAREN PLUS args RPAREN { Eval(Add, List.rev $3) }

args:
  expr			{ $1 }
| expr args		{ $1 :: $2 }
  
infix_expr:
  atom				{ $1 }
| LPAREN infix_expr RPAREN	{ $2 }
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
