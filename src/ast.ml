type op = Add | Sub | Mult | Div | Addf | Subf | Multf | Divf 
	| Equal | Neq | Less | Leq | Greater | Geq | And | Or | Assign | Quote
 
type bool = true | false

type expr =				(* Expressions *)
  Int of int				(* 4 *)
  | Float of float			(* 4.444 *)
  | Boolean of bool	 		(* true, false *)
  | String of string			(* "hello world" *)
  | Id of string			(* caml_riders *)
  | Assign of string * expr		(* {x = 5} OR (= x 5) *)
  | Binop of expr * op * expr		(* {x + 10} *)
  | Eval of string * expr list		(* (foo 5 21) *)
  | Evalarith of op * expr list   	(* (+ 1 2 3 ) *)
  | Nil					(* null datatype *)
  | List of expr list			(* list, mixed datatypes allowed in same list *)
  | Fdecl of string list * expr 	(* (fn (a b) {a + b}) *)
  | If of expr * expr * expr		(* (if a b c) *)
  | For of expr * expr * expr * expr	(* (for a b c d) *)
  | While of expr * expr		(* (while a b) *)
  | Let of string * expr * expr		(* (let a b) *)

type program = expr list

let rec stringify e = 
  let stringify_op o = match o with
    Add -> "Add" | Sub -> "Sub" | Mult -> "Mult" | Div -> "Div"
    | Addf -> "Addf" | Subf -> "Subf" | Multf -> "Multf" | Divf -> "Divf"
    | Equal -> "Equal" | Neq -> "Neq" | Less -> "Less" | Leq -> "Leq"
    | Greater -> "Greater" | Geq -> "Geq" | And -> "And" | Or -> "Or" 
    | Assign -> "Assign" | Quote -> "Quote"
in
  let concat l = (String.concat "" l) in
  match e with
  | Int(x) -> concat ["Int("; string_of_int x; ")"]
  | Float(x) -> concat ["Float("; string_of_float x; ")"]
  | Boolean(x) -> concat ["Boolean("; if x = true then "true" else "false"; ")"]
  | String(x) -> concat ["String("; x; ")"]
  | Id(x) -> concat ["Id("; x; ")"]
  | Assign(str, exp) -> concat ["Assign("; str; ", "; stringify exp; ""]
  | Binop(exp1, op, exp2) -> concat ["Binop("; stringify exp1; ", "; stringify_op op; ", "; stringify exp2; ")"]
  | Nil -> "Nil"
  | List(expl) -> concat ["List("; (String.concat ", " (List.map (fun x -> stringify x) expl)); ")"]
