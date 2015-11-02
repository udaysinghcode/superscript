open Ast

let generate_op o =
  match o with
    Add -> " + "
  | Sub -> " - "
  | Mult -> " * "
  | Div -> " / "
  | Addf -> " + "
  | Subf -> " - "
  | Multf -> " * "
  | Divf -> " / "
  | Equal -> " === "
  | Neq -> " !== "
  | Less -> " < "
  | Leq -> " <= "
  | Greater -> " > "
  | Geq -> " >= "
  | And -> " && "
  | Or -> " || "

let rec generate e = 
  let concat l = String.concat "" l in
  match e with
    Int(i) -> concat ["{ type: 'Int', value: "; string_of_int i; " }"]
  | Float(f) -> concat ["{ type: 'Float', value: "; string_of_float f; " }"]
  | Boolean(b) -> if b = true then "true" else "false"
  | String(s) -> concat ["'"; s; "'"]
  | Id(s) -> s
  | Assign(s, exp) -> concat ["var "; s; " = "; generate exp]
  | Binop(e1, o, e2) -> concat [generate e1; generate_op o; generate e2]
  | Func(fname, el) -> concat [fname; ".apply(null, "; generate (List(el)); ")"]
  | Nil -> "{ type: 'Nil' }"
  | List(el) -> concat ["["; (String.concat ", " (List.map generate el)); "]"]

