type op = Add | Sub | Mult | Div | Equal | Neq | Less | Leq | Greater | Geq

type expr =
  Int of int
  | Float of float
  | Boolean of int
  | String of string
  | Nil
  | Id of string
  | Assign of string * expr
  | Binop of expr * op * expr
  | Script of string * expr list

type stmt = 				(* Statements *)
   Block of stmt list			(* newline-separated stmts *)
 | Expr of expr				(* x = 5 *)
 | Return of expr			(* automatically return last evaluated value *)
 | If of expr * stmt * stmt
