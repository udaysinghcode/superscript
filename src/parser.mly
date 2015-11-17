%{ open Ast %}

%token PLUS MINUS TIMES DIVIDE PLUSF MINUSF TIMESF DIVIDEF EOF
%token ASSIGN QUOTE AND OR EQ NEQ LT LEQ GT GEQ
%token SEMI LPAREN RPAREN LBRACE RBRACE
%token <int> INT
%token FUNC LET IF FOR WHILE
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
| FOR expr expr expr expr	{ For($2, $3, $4, $5)}
| WHILE expr expr		{ While($2, $3) }
| FUNC LPAREN formals_opt RPAREN expr { Fdecl(List.rev $3, $5) }
| call				{ $1 }

expr:
  atom				{ $1 }
| list				{ $1 }
| LBRACE infix_expr RBRACE	{ $2 }
| LPAREN sexpr RPAREN		{ $2 }

formals_opt:
/* nothing */ 	{ [] }
| formal_list	{ List.rev $1 }

formal_list:
  ID		  { [$1] }
| formal_list ID  { $2 :: $1 }

atom:
  constant		{ $1 }
| ID			{ Id($1) }
| NIL			{ Nil }

list:
  QUOTE LPAREN args_opt RPAREN { List(List.rev $3) }

constant: 
  INT 			{ Int($1) }
| FLOAT			{ Float($1) }
| BOOL			{ Boolean($1) }
| STRING		{ String($1) }

call:
  ID args_opt		{ Eval($1, List.rev $2) }
| PLUS args 		{ ListOp(Add, List.rev $2) }
| MINUS args    	{ ListOp(Sub, List.rev $2) }
| TIMES args    	{ ListOp(Mult, List.rev $2) }
| DIVIDE args    	{ ListOp(Div, List.rev $2) }
| PLUSF args 		{ ListOp(Addf, List.rev $2) }
| MINUSF args    	{ ListOp(Subf, List.rev $2) }
| TIMESF args    	{ ListOp(Multf, List.rev $2) }
| DIVIDEF args    	{ ListOp(Divf, List.rev $2) }
| EQ args 		{ ListOp(Equal, List.rev $2) }
| NEQ args 		{ ListOp(Neq, List.rev $2) }
| LT args 		{ ListOp(Less, List.rev $2) }
| LEQ args 		{ ListOp(Leq, List.rev $2) }
| GT args 		{ ListOp(Greater, List.rev $2) }
| GEQ args 		{ ListOp(Geq, List.rev $2) }
| AND args 		{ ListOp(And, List.rev $2) }
| OR args 		{ ListOp(Or, List.rev $2) }
| ASSIGN args		{ ListOp(Assign, List.rev $2) }

args_opt:
/* nothing */ 		{ [] }
| args			{ List.rev $1 }

args:
  expr			{ [$1] }
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
