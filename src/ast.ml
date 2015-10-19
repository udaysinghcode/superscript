type sexpr =
  Int of int
  | Float of float
  | Symbol of string
  | String of string
  | Quote
  | Nil
  | Cons of sexpr * sexpr

(* must write something for evaluating cons *) 
(* must write let rec string_of_s function *)
