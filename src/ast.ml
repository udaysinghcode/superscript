type op = Add | Sub | Mult | Div | Equal | Neq | Less | Leq | Greater | Geq

type expr =				(* Expressions *)
  Int of int				(* 4 *)
  | Float of float			(* 4.444 *)
  | True				(* true *)
  | String of string			(* "hello world" *)
  | Nil					(* (): empty list, false *)
  | Id of string			(* caml_riders *)
  | Assign of string * expr		(* x = 5 *)
  | Binop of expr * op * expr		(* x + 10 *)
  | Script of string * expr list	(* foo 5 21 *)
  | Cond of expr * expr * expr		(* (if a) b c, equivalent to (if a then b else c) *)
