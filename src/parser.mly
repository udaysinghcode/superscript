%{ open Ast %}

%token PLUS MINUS TIMES DIVIDE PLUSF MINUSF TIMESF DIVIDEF EOF
%token ASSIGN QUOTE AND OR NOT EQ NEQ LT LEQ GT GEQ IF
%token LPAREN RPAREN LBRACE RBRACE LSQBRACE RSQBRACE
%token <int> INT
%token <string> ID
%token <string> STRING
%token <float> FLOAT
%token <string> BOOL

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
  LPAREN expr RPAREN    	{ $2 }
| INT		        	{ Int($1) }
| FLOAT				{ Float($1) }
| BOOL				{ Boolean($1) }
| STRING			{ String($1) }
| ID				{ Id($1) }

(* infix operations *)
| LSQBRACE ID ASSIGN expr RSQBRACE 	{ Assign($1, $3) }
| LSQBRACE expr PLUS expr RSQBRACE	{ Binop($1, Add, $3) }
| LSQBRACE expr MINUS expr RSQBRACE	{ Binop($1, Sub, $3) }
| LSQBRACE expr TIMES expr RSQBRACE	{ Binop($1, Mult, $3) }
| LSQBRACE expr DIVIDE expr RSQBRACE	{ Binop($1, Div, $3) }
| LSQBRACE expr EQ expr	RSQBRACE	{ Binop($1, Equal, $3) }
| LSQBRACE expr NEQ expr RSQBRACE	{ Binop($1, Neq, $3) }
| LSQBRACE expr LT expr	RSQBRACE	{ Binop($1, Less, $3) }
| LSQBRACE expr LEQ expr RSQBRACE	{ Binop($1, Leq, $3) }
| LSQBRACE expr GT expr	RSQBRACE	{ Binop($1, Greater, $3) }
| LSQBRACE expr GEQ expr RSQBRACE	{ Binop($1, Geq, $3) }
