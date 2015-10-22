%{ open Ast %}

%token PLUS MINUS TIMES DIVIDE PLUSF MINUSF TIMESF DIVIDEF EOF
%token ASSIGN QUOTE AND OR EQ NEQ LT LEQ GT GEQ IF
%token LPAREN RPAREN LBRACE RBRACE LSQBRACE RSQBRACE
%token <int> INT
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

%start expr
%type < Ast.expr> expr

%%
expr:
  LPAREN expr RPAREN		{ $2 }
| num_expr			{ $1 }	
| BOOL				{ Boolean($1) }
| STRING			{ String($1) }
| ID				{ Id($1) }
| NIL				{ Nil }
| LPAREN expr expr expr_list RPAREN  { List($2::$3::List.rev($4)) } /* list must have 2+ elems */
| LSQBRACE infix_expr RSQBRACE	{ $2 } /* infix expr must be surrounded by square braces */


num_expr: 
  INT		        	{ Int($1) }
| FLOAT				{ Float($1) }

infix_expr:
  infix_num_expr		{ $1 }
| infix_bool_expr		{ $1 }

infix_num_expr:
  num_expr			{ $1 }
| LPAREN infix_num_expr RPAREN	{ $2  }
| ID ASSIGN infix_num_expr		{ Assign($1, $3) }
| infix_num_expr PLUS infix_num_expr	{ Binop($1, Add, $3) }
| infix_num_expr MINUS infix_num_expr	{ Binop($1, Sub, $3) }
| infix_num_expr TIMES infix_num_expr	{ Binop($1, Mult, $3) }
| infix_num_expr DIVIDE infix_num_expr	{ Binop($1, Div, $3) }
| infix_num_expr PLUSF infix_num_expr	{ Binop($1, Addf, $3) }
| infix_num_expr MINUSF infix_num_expr	{ Binop($1, Subf, $3) }
| infix_num_expr TIMESF infix_num_expr	{ Binop($1, Multf, $3) }
| infix_num_expr DIVIDEF infix_num_expr	{ Binop($1, Divf, $3) }
| infix_num_expr EQ infix_num_expr	{ Binop($1, Equal, $3) }
| infix_num_expr NEQ infix_num_expr	{ Binop($1, Neq, $3) }
| infix_num_expr LT infix_num_expr	{ Binop($1, Less, $3) }
| infix_num_expr LEQ infix_num_expr	{ Binop($1, Leq, $3) }
| infix_num_expr GT infix_num_expr	{ Binop($1, Greater, $3) }
| infix_num_expr GEQ infix_num_expr	{ Binop($1, Geq, $3) }

infix_bool_expr:
  BOOL					{ Boolean($1) }
| LPAREN infix_bool_expr RPAREN		{ $2 }
| ID ASSIGN infix_bool_expr		{ Assign($1, $3) }
| infix_bool_expr AND infix_bool_expr	{ Binop($1, And, $3) }
| infix_bool_expr OR infix_bool_expr	{ Binop($1, Or, $3) }

expr_list:
/* nothing */		{ [] }
| expr_list expr	{ $2 :: $1 }
