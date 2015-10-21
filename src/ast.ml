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


