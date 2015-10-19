type sexpr =
  Int of int
  | Float of float
  | Symbol of string
  | String of string
  | Quote
  | Nil
  | Cons of sexpr * sexpr

