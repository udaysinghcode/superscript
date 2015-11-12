let generate_js_func fname = match fname with
    "prn"     -> ("function prn(s) { console.log(s); return s; };", ["string"], "string", [])
  | "pr"      -> ("function pr(s) { process.stdout.write(s); return s; };", ["string"], "string", [])
  | "type"    -> ("function type(o) { return o.type; };", ["ss_boxed"], "string", [])
  | "__clone" -> ("function __clone(o) { return JSON.parse(JSON.stringify(o)); };", ["any"], "same", []) (* *)
  | "__box"   -> ("function __box(t, v) { return { __t: t, __v: __clone(v) }; };", ["string"; "ss_unboxed"], "ss_boxed", ["clone"])
  | "__unbox" -> ("function __unbox(o) { return __clone(o.__v); };", ["ss_boxed"], "ss_unboxed", ["clone"])
  | "head"    -> ("function head(l) { return __clone(__unbox(l)[0]); };", ["list"], "ss_boxed", ["__clone"; "__unbox"])
  | "tail"    -> ("function tail(l) { return __box('list', __unbox(l).slice(1)); };", ["list"], "list", ["__box"; "__unbox"])
  | "cons"    -> ("function cons(i, l) { return __box('list', __unbox(l).unshift(__clone(i))); };", ["ss_boxed"; "list"], "list", ["__box"; "__unbox"; "__clone"])
  | "__add"   -> ("function __add(a1, a2) { return __box('int', __unbox(a1) + __unbox(a2)); };", ["int"; "int"], "int", ["__box"; "__unbox"])
  | "__sub"   -> ("function __sub(a1, a2) { return __box('int', __unbox(a1) - __unbox(a2)); };", ["int"; "int"], "int", ["__box"; "__unbox"])
  | "__mult"  -> ("function __mult(a1, a2) { return __box('int', __unbox(a1) * __unbox(a2)); };", ["int"; "int"], "int", ["__box"; "__unbox"])
  | "__div"   -> ("function __div(a1, a2) { return __box('int', __unbox(a1) / __unbox(a2)); };", ["int"; "int"], "int", ["__box"; "__unbox"])
  | "mod"     -> ("function mod(a1, a2) { return __box('int', __unbox(a1) % __unbox(a2)); };", ["int"; "int"], "int", ["__box"; "__unbox"])
  | "__addf"  -> ("function __addf(a1, a2) { return __box('float', __unbox(a1) + __unbox(a2)); };", ["float"; "float"], "float", ["__box"; "__unbox"])
  | "__subf"  -> ("function __subf(a1, a2) { return __box('float', __unbox(a1) - __unbox(a2)); };", ["float"; "float"], "float", ["__box"; "__unbox"])
  | "__multf" -> ("function __multf(a1, a2) { return __box('float', __unbox(a1) * __unbox(a2)); };", ["float"; "float"], "float", ["__box"; "__unbox"])
  | "__divf"  -> ("function __divf(a1, a2) { return __box('float', __unbox(a1) / __unbox(a2)); };", ["float"; "float"], "float", ["__box"; "__unbox"])

let generate_prog p =
  let op_name o = match o with
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
    | Or -> "__or" in
  let cc l = String.concat "" l in
  let box t v = cc ["{ __t: '"; t; "', __v: "; v; " }"] in
  let rec generate e = match e with
      Int(i) -> box "int" (string_of_int i)
    | Float(f) -> box "float" (string_of_float f)
    | Boolean(b) -> box "boolean" (if b = true then "true" else "false")
    | String(s) -> box "string" (cc ["'"; s; "'"])
    | Id(s) -> s
    | Assign(s, exp) -> cc ["var "; s; " = "; generate exp; "\n"]
    | Binop(e1, o, e2) -> generate (Eval(op_name o, [e1; e2]))
    | Eval(fname, el) -> cc [fname; ".apply(null, __unbox("; generate (List(el)); "))"]
    | Evalarith(o, el) -> generate (List(el))
    | Nil -> box "nil" "[]"
    | List(el) -> box "list" (cc ["["; (String.concat ", " (List.map generate el)); "]"])
    | Fdecl(argl, exp) -> cc ["function("; String.concat ", " argl; ") { return "; generate exp; "; }"]
    | If(cond, thenb, elseb) -> cc [generate cond; " ? "; generate thenb; " : "; generate elseb]
    | For(init, cond, update, exp) -> cc ["return "; generate Nil; ";"]
    | While(cond, exp) -> cc ["return "; generate Nil; ";"] 
    | Let(n, v, exp) -> cc ["(function () { "; generate (Assign(n, v)); "return "; generate exp; "; })();"] in
  let generate_head pg = "" in
  let wrap_exp e = cc [generate e; ";\n"] in
  cc ((generate_head p)::(List.map wrap_exp p))