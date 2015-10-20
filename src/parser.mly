%{ open Ast %}

%token PLUS MINUS TIMES DIVIDE EOF
%token ASSIGN
%token LPAREN RPAREN LBRACE RBRACE
%token <int> LITERAL
%token <int> ID

%right ASSIGN
%left PLUS MINUS
%left TIMES DIVIDE

%start sexpr
%type < Ast.sexpr> sexpr

%%
sexpr: 
| LITERAL		{ Literal($1) }
| ID		        { Id($1) }
| LPAREN sexpr RPAREN	{ $2 }
