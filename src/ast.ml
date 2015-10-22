type op = Add | Sub | Mult | Div | Addf | Subf | Multf | Divf 
	| Equal | Neq | Less | Leq | Greater | Geq | And | Or
 
type bool = true | false

type expr =				(* Expressions *)
  Int of int				(* 4 *)
  | Float of float			(* 4.444 *)
  | Boolean of bool	 		(* true, false *)
  | String of string			(* "hello world" *)
  | Id of string			(* caml_riders *)
  | Assign of string * expr		(* x = 5 *)
  | Binop of expr * op * expr		(* x + 10 *)
  | Script of string * expr list	(* foo 5 21 *)
  | Nil					(* null datatype *)
  | List of expr list			(* list, mixed datatypes allowed in same list *)
  | Cond of expr * expr * expr		(* (if a) b c, equivalent to (if a then b else c) *)
