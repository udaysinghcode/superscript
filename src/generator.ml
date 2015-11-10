open Ast

let op_name o =
  match o with
    Add -> "__add"
  | Sub -> "__sub"
  | Mult -> "__mult"
  | Div -> "__div"
  | Addf -> "__addf"
  | Subf -> "__subf"
  | Multf -> "__multf"
  | Divf -> "__divf"
  | Equal -> "__equal"
  | Neq -> "__neq"
  | Less -> "__less"
  | Leq -> "__leq"
  | Greater -> "__greater"
  | Geq -> "__geq"
  | And -> "__and"
  | Or -> "__or"


let rec generate e = 
  let concat l = String.concat "" l in
  match e with
    Int(i) -> concat ["{ type: 'Int', value: "; string_of_int i; " }"]
  | Float(f) -> concat ["{ type: 'Float', value: "; string_of_float f; " }"]
  | Boolean(b) -> if b = true then "true" else "false"
  | String(s) -> concat ["'"; s; "'"]
  | Id(s) -> s
  | Assign(s, exp) -> concat ["var "; s; " = "; generate exp]
  | Binop(e1, o, e2) -> generate (Func(op_name o, [e1; e2]))
  | Func(fname, el) -> concat [fname; ".apply(null, __unbox("; generate (List(el)); "))"]
  | Nil -> "{ type: 'Nil' }"
  | List(el) -> concat ["{ type: 'List', value: ["; (String.concat ", " (List.map generate el)); "] }"]