%{ open Ast %}

%token PLUS MINUS TIMES DIVIDE PLUSF MINUSF TIMESF DIVIDEF EOF
%token ASSIGN QUOTE AND OR NOT TRUE FALSE EQ NEQ LT LEQ GT GEQ IF
%token LPAREN RPAREN LBRACE RBRACE
%token <int> INT
%token <string> ID
%token <string> STRING
%token <float> FLOAT

%right ASSIGN
%left OR
%left AND
%left EQ NEQ
%left LT GT LEQ GEQ
%left PLUS MINUS PLUSF MINUSF
%left TIMES DIVIDE TIMESF DIVIDEF

%start sexpr
%type < Ast.sexpr> sexpr

%%
sexpr: 
| INT		        { Int($1) }
| FLOAT			{ Float($1) }
| LPAREN sexpr RPAREN	{ $2 }
| ID			{ Symbol($1) }
| STRING		{ String($1) }
