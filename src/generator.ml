open Ast;;

let cc l = String.concat "" l

let box t v = cc ["({ __t: '"; t; "', __v: "; v; " })"]

let generate_js_func fname =
  let helper fname = match fname with
      "prn"       -> ("'function(s) { console.log(__unbox(s)); return s; }'", ["string"], "string", [])
    | "pr"        -> ("'function(s) { process.stdout.write(__unbox(s)); return s; }'", ["string"], "string", [])
    | "type"      -> ("'function(o) { return __box(\\'string\\', o.__t); }'", ["ss_boxed"], "string", [])
    | "head"      -> ("'function(l) { return __clone(__unbox(l)[0]); }'", ["list"], "ss_boxed", [])
    | "tail"      -> ("'function(l) { return __box(\\'list\\', __unbox(l).slice(1)); }'", ["list"], "list", [])
    | "cons"      -> ("'function(i, l) { return __box(\\'list\\', __unbox(l).unshift(__clone(i))); }'", ["ss_boxed"; "list"], "list", [])
    | "__add"     -> ("'function() { return __box(\\'int\\', arguments.length === 0 ? 0 : Array.prototype.slice.call(arguments).map(__unbox).reduce(function(a,b){return a+b;})); }'", ["int"; "int"], "int", [])
    | "__sub"     -> ("'function(a1) { return __box(\\'int\\', arguments.length === 1 ? -1 * __unbox(a1) : Array.prototype.slice.call(arguments).map(__unbox).reduce(function(a,b){return a-b;})); }'", ["int"; "int"], "int", [])
    | "__mult"    -> ("'function() { return __box(\\'int\\', arguments.length === 0 ? 1 : Array.prototype.slice.call(arguments).map(__unbox).reduce(function(a,b){return a*b;})); }'", ["int"; "int"], "int", [])
    | "__div"     -> ("'function() { return __box(\\'int\\', Math.floor(Array.prototype.slice.call(arguments).map(__unbox).reduce(function(a,b){return a/b;}))); }'", ["int"; "int"], "int", [])
    | "mod"       -> ("'function(a1, a2) { return __box(\\'int\\', __unbox(a1) % __unbox(a2)); }'", ["int"; "int"], "int", [])
    | "__addf"    -> ("'function(a1, a2) { return __box(\\'float\\', Array.prototype.slice.call(arguments).map(__unbox).reduce(function(a,b){return a+b;})); }'", ["float"; "float"], "float", [])
    | "__subf"    -> ("'function(a1, a2) { return __box(\\'float\\', arguments.length === 1 ? -1 * __unbox(a1) : Array.prototype.slice.call(arguments).map(__unbox).reduce(function(a,b){return a-b;})); }'", ["float"; "float"], "float", [])
    | "__multf"   -> ("'function(a1, a2) { return __box(\\'float\\', Array.prototype.slice.call(arguments).map(__unbox).reduce(function(a,b){return a*b;})); }'", ["float"; "float"], "float", [])
    | "__divf"    -> ("'function(a1, a2) { return __box(\\'float\\', Array.prototype.slice.call(arguments).map(__unbox).reduce(function(a,b){return a/b;})); }'", ["float"; "float"], "float", [])
    | "__equal"   -> ("'function(a1, a2) { return __box(\\'boolean\\', JSON.stringify(__unbox(a1)) === JSON.stringify(__unbox(a2))); }'", ["ss_boxed"; "ss_boxed"], "boolean", [])
    | "__neq"     -> ("'function(a1, a2) { return __box(\\'boolean\\', __unbox(a1) !== __unbox(a2)); }'", ["ss_boxed"; "ss_boxed"], "boolean", [])
    | "__less"    -> ("'function(a1, a2) { return __box(\\'boolean\\', __unbox(a1) < __unbox(a2)); }'", ["ss_boxed"; "ss_boxed"], "boolean", [])
    | "__leq"     -> ("'function(a1, a2) { return __box(\\'boolean\\', __unbox(a1) <= __unbox(a2)); }'", ["ss_boxed"; "ss_boxed"], "boolean", [])
    | "__greater" -> ("'function(a1, a2) { return __box(\\'boolean\\', __unbox(a1) > __unbox(a2)); }'", ["ss_boxed"; "ss_boxed"], "boolean", [])
    | "__geq"     -> ("'function(a1, a2) { return __box(\\'boolean\\', __unbox(a1) >= __unbox(a2)); }'", ["ss_boxed"; "ss_boxed"], "boolean", [])
    | "__and"     -> ("'function(a1, a2) { return __box(\\'boolean\\', __unbox(a1) && __unbox(a2)); }'", ["ss_boxed"; "ss_boxed"], "boolean", [])
    | "__or"      -> ("'function(a1, a2) { return __box(\\'boolean\\', __unbox(a1) || __unbox(a2)); }'", ["ss_boxed"; "ss_boxed"], "boolean", [])
    | "str_of_int"   -> ("'function(i) { return __box(\\'string\\', \\'\\' + __unbox(i)); }'", ["int"], "string", [])
    | "int_of_str"   -> ("'function(s) { return __box(\\'int\\', parseInt(__unbox(s))); }'", ["string"], "int", [])
    | "str_of_float" -> ("'function(f) { return __box(\\'string\\', '' + __unbox(f)); }'", ["float"], "string", [])
    | "float_of_str" -> ("'function(s) { return __box(\\'float\\', parseFloat(__unbox(s))); }'", ["string"], "float", [])
    | "str_of_bool"   -> ("'function(b) { return __box(\\'string\\', \\'\\' + __unbox(b)); }'", ["boolean"], "string", [])
    | "__concat"     -> ("'function() { return __box(\\'string\\', Array.prototype.slice.call(arguments).map(__unbox).reduce(function(a,b){return a+b;})); }'", ["string"; "string"], "string", [])
    | _ -> ("", [], "", []) in
  let (fstr, arg_types, ret_type, deps) = helper fname in
  (box "function" fstr, arg_types, ret_type, deps)

let is_generatable fname =
  List.mem fname ["prn"; "pr"; "type";
                  "head"; "tail"; "cons"; "__add"; "__sub"; "__mult";
                  "__div"; "mod"; "__addf"; "__subf"; "__multf"; "__divf";
                  "__equal"; "__neq"; "__less"; "__leq"; "__greater";
                  "__geq"; "__and"; "__or"; "str_of_int"; "int_of_str";
                  "str_of_float"; "float_of_str"; "str_of_bool"; "__concat"]

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
    | Or -> "__or"
    | Assign -> "__ASSIGN__"

let generate_prog p =
  let rec generate e = match e with
      Int(i) -> box "int" (string_of_int (i))
    | Float(f) -> box "float" (string_of_float (f))
    | Boolean(b) -> box "boolean" (if b = true then "true" else "false")
    | String(s) -> box "string" (cc ["'"; s; "'"])
    | Id(s) -> s
    | Assign(el) -> let rec gen_pairs l = match l with
                      [] -> []
                    | h1::h2::tl -> (h1, h2)::(gen_pairs tl)
                    | _::[] -> raise (Failure("= operator used on odd numbered list!")) in
                    String.concat ";" (List.map (fun (Id(s), e) -> cc ["var "; s; " = "; generate e]) (gen_pairs el))
    | Binop(e1, o, e2) -> generate (Eval(op_name o, [e1; e2]))
    | Eval(fname, el) -> cc ["__fcall('"; fname; "', "; generate (List(el)); ")"]
    | Nil -> box "list" "[]"
    | List(el) -> box "list" (cc ["["; (String.concat ", " (List.map generate el)); "]"])
    | Fdecl(argl, exp) -> box "function" (cc ["(function("; String.concat ", " (List.rev argl); ") { return "; generate exp; "; }).toString()"])
    | If(cond, thenb, elseb) -> cc ["__unbox("; generate cond; ") ? "; generate thenb; " : "; generate elseb]
    | For(init, cond, update, exp) -> cc ["return "; generate Nil; ";"]
    | While(cond, exp) -> cc ["return "; generate Nil; ";"] 
    | Let(n, v, exp) -> cc ["(function () { var "; n; " = "; generate v; "; return "; generate exp; "; })()"] in
  let generate_head p =
    let rec get_deps fname =
      let (_, _, _, deps) = generate_js_func fname in
      deps @ (List.flatten (List.map get_deps deps)) in
    let get_def fname =
      let (body, _, _, _) = generate_js_func fname in
      cc ["var "; fname; " = "; body] in
    let rec get_fnames e = match e with
        Eval(fname, el) -> [fname] @ (get_fnames (List(el)))
      | Assign(el) -> get_fnames (List(el))
      | Binop(e1, o, e2) -> get_fnames (Eval(op_name o, [e1; e2]))
      | List(el) -> List.flatten (List.map get_fnames el)
      | Fdecl(argl, exp) -> get_fnames exp
      | If(cond, thenb, elseb) -> (get_fnames cond) @ (get_fnames thenb) @ (get_fnames elseb)
      | For(init, cond, update, exp) -> (get_fnames init) @ (get_fnames cond) @ (get_fnames update) @ (get_fnames exp)
      | While(cond, exp) -> (get_fnames cond) @ (get_fnames exp)
      | Let(n, v, exp) -> (get_fnames v) @ (get_fnames exp)
      | _ -> [] in
    let generatable = (List.filter is_generatable (List.flatten (List.map get_fnames p))) in
    String.concat ";\n" (List.map get_def (List.sort_uniq compare (generatable @ (List.flatten (List.map get_deps generatable))))) in
  let wrap_exp e = cc [generate e; ";"] in
  cc ("function __box(t, v) { return ({ __t: t, __v: __clone(v) }); };\n"::
      "function __clone(o) { return JSON.parse(JSON.stringify(o)); };\n"::
      "function __unbox(o) { return __clone(o.__v); };\n"::
      "function __fcall(name, args) { return eval('(' + __unbox(eval(name)) + ').apply(null, __unbox(args))'); };\n"::(generate_head p)::";\n"::(List.map wrap_exp p))
