%{ open Ast %}

%token PLUS MINUS TIMES DIVIDE PLUSF MINUSF TIMESF DIVIDEF EOF
%token ASSIGN QUOTE AND OR EQ NEQ LT LEQ GT GEQ IF
%token LPAREN RPAREN LBRACE RBRACE LSQBRACE RSQBRACE
%token <int> INT
%token <string> ID
%token <string> STRING
%token <float> FLOAT
%token <string> BOOL
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
  LPAREN expr RPAREN		{$2}
| num_expr	
| bool_expr
| STRING			{ String($1) }
| ID				{ Id($1) }
| LPAREN expr_list RPAREN	{ List(List.rev $2) }
| LSQBRACE ID ASSIGN expr RSQBRACE { Assign($2, $4) }

num_expr: 
  INT		        	{ Int($1) }
| FLOAT				{ Float($1) }
| LSQBRACE num_expr PLUS expr RSQBRACE	    { Binop($2, Add, $4) }
| LSQBRACE num_expr MINUS expr RSQBRACE	    { Binop($2, Sub, $4) }
| LSQBRACE num_expr TIMES expr RSQBRACE	    { Binop($2, Mult, $4) }
| LSQBRACE num_expr DIVIDE expr RSQBRACE    { Binop($2, Div, $4) }
| LSQBRACE num_expr PLUSF expr RSQBRACE	    { Binop($2, Addf, $4) }
| LSQBRACE num_expr MINUSF expr RSQBRACE    { Binop($2, Subf, $4) }
| LSQBRACE num_expr TIMESF expr RSQBRACE    { Binop($2, Multf, $4) }
| LSQBRACE num_expr DIVIDEF expr RSQBRACE   { Binop($2, Divf, $4) }
| LSQBRACE num_expr EQ expr RSQBRACE	{ Binop($2, Equal, $4) }
| LSQBRACE num_expr NEQ expr RSQBRACE	{ Binop($2, Neq, $4) }
| LSQBRACE num_expr LT expr RSQBRACE	{ Binop($2, Less, $4) }
| LSQBRACE num_expr LEQ expr RSQBRACE	{ Binop($2, Leq, $4) }
| LSQBRACE num_expr GT expr RSQBRACE	{ Binop($2, Greater, $4) }
| LSQBRACE num_expr GEQ expr RSQBRACE	{ Binop($2, Geq, $4) }

bool_expr:
  BOOL		{ Boolean($1) }
| LSQBRACE bool_expr AND bool_expr RSQBRACE 	{ Binop($2, And, $4) }
| LSQBRACE bool_expr OR bool_expr RSQBRACE	{ Binop($2, Or, $4) }

expr_list:
  expr_list expr	{ $2 :: $1 }
