type op = Add | Sub | Mult | Div | Addf | Subf | Multf | Divf 
	| Equal | Neq | Less | Leq | Greater | Geq | And | Or | Assign

type expr =				(* Expressions *)
  Int of int				(* 4 *)
  | Float of float			(* 4.444 *)
  | Boolean of bool	 		(* true, false *)
  | String of string			(* "hello world" *)
  | Id of string			(* caml_riders *)
  | Assign of string * expr		(* {x = 5} OR (= x 5) *)
  | Binop of expr * op * expr		(* {x + 10} *)
  | Eval of string * expr list		(* (foo 5 21) *)
  | Nil					(* null datatype *)
  | List of expr list			(* list, mixed datatypes allowed in same list *)
  | Fdecl of string list * expr 	(* (fn (a b) {a + b}) *)
  | If of expr * expr * expr		(* (if a b c) *)
  | For of expr * expr * expr * expr	(* (for a b c d) *)
  | While of expr * expr		(* (while a b) *)
  | Let of string * expr * expr		(* (let a b) *)

type program = expr list
