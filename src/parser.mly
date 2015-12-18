%{ open Ast %}

%token PLUS MINUS TIMES DIVIDE PLUSF MINUSF TIMESF DIVIDEF EOF
%token ASSIGN QUOTE AND OR EQ NEQ LT LEQ GT GEQ CONCAT
%token SEMI LPAREN RPAREN LBRACE RBRACE
%token <int> INT
%token FUNC LET IF DO EVAL
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
%left CONCAT

%start program
%type <Ast.program> program

%%

program:
 expr_list EOF		{ List.rev $1 }

expr_list:
/* nothing */		{ [] }
| expr_list expr SEMI	{ $2 :: $1 }

sexpr:
  LET ID expr expr   		{ Let($2, $3, $4) }
| IF expr expr expr		{ If($2, $3, $4) }
| FUNC LPAREN formals_opt RPAREN expr { Fdecl(List.rev $3, $5) }
| call				{ $1 }

expr:
  atom				{ $1 }
| list				{ $1 }
| LBRACE infix_expr RBRACE	{ $2 }
| unquoted_list			{ $1 }

list:
  QUOTE LPAREN args_opt RPAREN 	{ List(List.rev $3) }

unquoted_list:
  LPAREN sexpr RPAREN		{ $2 }

formals_opt:
/* nothing */ 	{ [] }
| formal_list	{ $1 }

 formal_list:
  ID		  { [$1] }
| formal_list ID  { $2 :: $1 }

atom:
  constant		{ $1 }
| ID			{ Id($1) }
| NIL			{ Nil }
| operator		{ Id($1) }
| two_args_operators	{ Id($1) }

operator:
| PLUS			{ "__add" }
| MINUS			{ "__sub" } 
| TIMES			{ "__mult" }
| DIVIDE		{ "__div" }
| PLUSF			{ "__addf" }
| MINUSF		{ "__subf" }
| DIVIDEF		{ "__divf" } 
| TIMESF		{ "__multf" }
| AND			{ "__and" }
| OR			{ "__or" }
| CONCAT		{ "__concat" }
| DO			{ "exec" }
| EVAL			{ "evaluate" }

two_args_operators:
| EQ      { "__equal" }
| NEQ     { "__neq" }
| LT      { "__less" }
| LEQ     { "__leq" }
| GT      { "__greater" }
| GEQ     { "__geq" }

constant: 
  INT 			{ Int($1) } 
| FLOAT			{ Float($1) }
| BOOL			{ Boolean($1) }
| STRING		{ String($1) }

call:
  ID args_opt			{ Eval(Id($1), List.rev $2) }
| unquoted_list args_opt	{ Eval($1, List.rev $2) }
| operator args_opt 		{ Eval(Id($1), List.rev $2) }
| two_args_operators two_args 	{ Eval(Id($1), List.rev $2)}
| ASSIGN assign_args		{ Assign($2) }

args_opt:
/* nothing */ 		{ [] }
| args			{ $1 }

two_args:
expr expr { [$2; $1] }

args:
  expr			{ [$1] }
| args expr		{ $2 :: $1 }
  
assign_args:
  ID expr		{ [Id($1); $2] }
| ID expr assign_args   { Id($1) :: $2 :: $3 }

infix_expr:
  constant			{ $1 }
| LPAREN ID args_opt RPAREN	{ Eval(Id($2), List.rev $3) }
| ID				{ Id($1) }
| MINUS INT			{ Int(-1 * $2) }
| MINUS FLOAT			{ Float(-1.0 *. $2) }
| LBRACE infix_expr RBRACE	{ $2 }
| ID ASSIGN infix_expr		{ Assign([Id($1); $3]) }
| infix_expr CONCAT infix_expr  { Eval(Id("concat"), [$1; $3]) }
| infix_expr PLUS infix_expr	{ Eval(Id("__add"), [$1; $3]) }
| infix_expr MINUS infix_expr	{ Eval(Id("__sub"), [$1; $3])  }
| infix_expr TIMES infix_expr	{ Eval(Id("__mult"), [$1; $3]) }
| infix_expr DIVIDE infix_expr	{ Eval(Id("__div"), [$1; $3])  }
| infix_expr PLUSF infix_expr	{ Eval(Id("__addf"), [$1; $3]) }
| infix_expr MINUSF infix_expr	{ Eval(Id("__subf"), [$1; $3]) }
| infix_expr TIMESF infix_expr	{ Eval(Id("__multf"), [$1; $3]) }
| infix_expr DIVIDEF infix_expr	{ Eval(Id("__divf"), [$1; $3]) }
| infix_expr EQ infix_expr	{ Eval(Id("__equal"), [$1; $3]) }
| infix_expr NEQ infix_expr	{ Eval(Id("__neq"), [$1; $3]) }
| infix_expr LT infix_expr	{ Eval(Id("__add"), [$1; $3]) }
| infix_expr LEQ infix_expr	{ Eval(Id("__less"), [$1; $3]) }
| infix_expr GT infix_expr	{ Eval(Id("__greater"), [$1; $3]) }
| infix_expr GEQ infix_expr	{ Eval(Id("__geq"), [$1; $3]) }
| infix_expr AND infix_expr	{ Eval(Id("__and"), [$1; $3]) }
| infix_expr OR infix_expr	{ Eval(Id("__or"), [$1; $3]) } 
