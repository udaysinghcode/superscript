%{ open Ast %}

%token PLUS MINUS TIMES DIVIDE EOF
%token ASSIGN
%token LPAREN RPAREN LBRACE RBRACE
%token <int> INT
%token <string> ID
%token <string> STRING
%token <float> FLOAT

%right ASSIGN
%left PLUS MINUS
%left TIMES DIVIDE

%start sexpr
%type < Ast.sexpr> sexpr

%%
sexpr: 
| INT		        { Int($1) }
| FLOAT			{ Float($1) }
| LPAREN sexpr RPAREN	{ $2 }
| ID			{ Symbol($1) }
| STRING		{ String($1) }
