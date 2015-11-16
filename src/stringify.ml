open Ast

let rec stringify e = 
  let stringify_op o = match o with
    Add -> "Add" | Sub -> "Sub" | Mult -> "Mult" | Div -> "Div"
    | Addf -> "Addf" | Subf -> "Subf" | Multf -> "Multf" | Divf -> "Divf"
    | Equal -> "Equal" | Neq -> "Neq" | Less -> "Less" | Leq -> "Leq"
    | Greater -> "Greater" | Geq -> "Geq" | And -> "And" | Or -> "Or" 
    | Assign -> "Assign"
in
  let concat l = (String.concat "" l) in
  match e with
    Int(x) -> concat ["Int("; string_of_int x; ")"]
  | Float(x) -> concat ["Float("; string_of_float x; ")"]
  | Boolean(x) -> concat ["Boolean("; if x = true then "true" else "false"; ")"]
  | String(x) -> concat ["String(\""; x; "\")"]
  | Id(x) -> concat ["Id(\""; x; "\")"]
  | Assign(str, exp) -> concat ["Assign("; str; ", "; stringify exp; ""]
  | Binop(exp1, op, exp2) -> concat ["Binop("; stringify exp1; ", "; stringify_op op; ", "; stringify exp2; ")"]
  | Eval(str, el) -> concat ["Eval("; str; ", "; stringify (List(el)); ")"]
  | ListOp(o, el) -> concat ["ListOp("; stringify_op o; ", "; stringify (List(el)); ")"]
  | Nil -> "Nil"
  | List(expl) -> concat ["List("; (String.concat ", " (List.map (fun x -> stringify x) expl)); ")"]
  | Fdecl(args, e) -> concat ["Fdecl(["; String.concat ", " (List.map (fun x -> concat ["\""; x; "\""]) args); "], "; stringify e; ")"]
  | If(cond, thenb, elseb) -> concat ["If("; stringify cond; ", "; stringify thenb; ", "; stringify elseb; ")"]
  | For(init, cond, update, exp) -> concat ["For("; stringify init; ", "; stringify cond; ", "; stringify update; ", "; stringify exp; ")"]
  | While(cond, exp) -> concat ["While("; stringify cond; ", "; stringify exp; ")"]
  | Let(str, exp1, exp2) -> concat ["Let(\""; str; "\", "; stringify exp1; ", "; stringify exp2; ")"]

let stringify_prog exp_list =
  String.concat "" ["["; (String.concat ", " (List.map stringify exp_list)); "]"]
