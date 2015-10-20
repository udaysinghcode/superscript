%{ open Ast %}

%token PLUS MINUS TIMES DIVIDE EOF
%token ASSIGN
%token <int> LITERAL
%token <int> ID

%left COMMA
%right ASSIGN
%left PLUS MINUS
%left TIMES DIVIDE

%start expr
%type < Ast.expr> expr

%%
expr: 
  expr PLUS expr     	{ Binop($1, Add, $3)  }
| expr MINUS expr	{ Binop($1, Sub, $3)  }
| expr TIMES expr	{ Binop($1, Mult, $3) }
| expr DIVIDE expr	{ Binop($1, Div, $3)  }
| ID assign expr	{ Assign($1, $3) }
| LITERAL		{ Literal($1) }
| ID		        { Id($1) }
| LPAREN expr RPAREN	{ $2 }
