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
  LPAREN expr RPAREN		{ $2 }
| INT		        	{ Int($1) }
| FLOAT				{ Float($1) }
| BOOL				{ Boolean($1) }
| STRING			{ String($1) }
| ID				{ Id($1) }
| LPAREN RPAREN			{ Nil }

| LSQBRACE ID ASSIGN expr RSQBRACE 	{ Assign($2, $4) }
| LSQBRACE expr PLUS expr RSQBRACE	{ Binop($2, Add, $4) }
| LSQBRACE expr MINUS expr RSQBRACE	{ Binop($2, Sub, $4) }
| LSQBRACE expr TIMES expr RSQBRACE	{ Binop($2, Mult, $4) }
| LSQBRACE expr DIVIDE expr RSQBRACE	{ Binop($2, Div, $4) }
| LSQBRACE expr PLUSF expr RSQBRACE     { Binop($2, Addf, $4) }
| LSQBRACE expr MINUSF expr RSQBRACE    { Binop($2, Subf, $4) }
| LSQBRACE expr TIMESF expr RSQBRACE    { Binop($2, Multf, $4) }
| LSQBRACE expr DIVIDEF expr RSQBRACE   { Binop($2, Divf, $4) }

| LSQBRACE expr AND expr RSQBRACE	{ Binop($2, And, $4) }
| LSQBRACE expr OR expr RSQBRACE	{ Binop($2, Or, $4) }
| LSQBRACE expr EQ expr	RSQBRACE	{ Binop($2, Equal, $4) }
| LSQBRACE expr NEQ expr RSQBRACE	{ Binop($2, Neq, $4) }
| LSQBRACE expr LT expr	RSQBRACE	{ Binop($2, Less, $4) }
| LSQBRACE expr LEQ expr RSQBRACE	{ Binop($2, Leq, $4) }
| LSQBRACE expr GT expr	RSQBRACE	{ Binop($2, Greater, $4) }
| LSQBRACE expr GEQ expr RSQBRACE	{ Binop($2, Geq, $4) }
