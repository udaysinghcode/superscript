open Ast;;
open Printf;;
(* add (get '(1 2 3) 0) to return 1*)
let sprintf = Printf.sprintf;;

let cc l = String.concat "" l;;
let box t v = sprintf "({ __t: '%s', __v: %s })" t v;;

let generate_js_func fname =
  let helper fname =
    match fname with
      "prn"       -> ("'function(s) { console.log(__unbox(s)); return s; }'", ["string"], "string", [])
    | "exec"      -> ("'function() { var res; for(var i = 0; i < arguments.length; i++) { res = __fcall(\\'evaluate\\', [arguments[i]]); } return res; }'", ["string"], "string", ["evaluate"])
    | "pr"        -> ("'function(s) { process.stdout.write(__unbox(s)); return s; }'", ["string"], "string", [])
    | "type"      -> ("'function(o) { return __box(\\'string\\', o.__t); }'", ["ss_boxed"], "string", [])
    | "head"      -> ("'function(l) { return __clone(__unbox(l)[0]); }'", ["list"], "ss_boxed", [])
    | "tail"      -> ("'function(l) { return __box(\\'list\\', __unbox(l).slice(1)); }'", ["list"], "list", [])
    | "cons"      -> ("'function(i, l) { var __temp = __unbox(l); __temp.unshift(__clone(i)); return __box(\\'list\\', __temp); }'", ["ss_boxed"; "list"], "list", [])
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
    | "str_of_bool"  -> ("'function(b) { return __box(\\'string\\', \\'\\' + __unbox(b)); }'", ["boolean"], "string", [])
    | "__concat"     -> ("'function() { return __box(\\'string\\', Array.prototype.slice.call(arguments).map(__unbox).reduce(function(a,b){return a+b;})); }'", ["string"; "string"], "string", [])
    | "evaluate"     -> ("'function(l) { return eval(\\'(\\' + __unbox(__unbox(l)[0]) + \\').apply(null, \\' + JSON.stringify(__unbox(l).slice(1)) + \\')\\'); }'", ["string"], "string", [])
    | "module"       -> ("'function(n) { return __box(\\'module\\', require(__unbox(n))); }'", ["string"], "string", [])
    | "call"          -> ("'function(m) {  }'", ["string"], "string", [])
    | "dot"           -> ("'function(s,e) {  }'", ["string"], "string", [])
    | _ -> ("", [], "", [])
  in
    let (fstr, arg_types, ret_type, deps) = helper fname in
    (box "function" fstr, arg_types, ret_type, deps)

let is_generatable fname =
  let (_, argtypes, _, _) = generate_js_func fname in
  argtypes != []

let generate_prog p =
  let escape_quotes s =
    Str.global_replace (Str.regexp "\\([^\\\\]?\\)'") "\\1\\'" (Str.global_replace (Str.regexp "\\([\\\\]+\\)'") "\\1\\1'" s) in
  let rec generate e =
    match e with
      Nil -> box "list" "[]"
    | List(el) -> box "list" (sprintf "[%s]" (String.concat ", " (List.map generate el)))
    | Int(i) -> box "int" (string_of_int (i))
    | Float(f) -> box "float" (string_of_float (f))
    | Boolean(b) -> box "boolean" (if b = true then "true" else "false")
    | String(s) -> box "string" (sprintf "'%s'" s)
    | Id(s) -> sprintf "eval('%s')" s

    | Assign(el) -> let rec gen_pairs l =
                      match l with
                        [] -> []
                      | h1::h2::tl -> (h1, h2)::(gen_pairs tl)
                      | _::[] -> raise (Failure("= operator used on odd numbered list!"))
                    in
                      String.concat "; " (List.map 
                                            (fun (Id(s), e) -> sprintf "eval('var %s = %s; %s;')" s (escape_quotes (generate e)) s)
                                            (gen_pairs el))

    | Eval(first, el) -> (match first with
                          String(x) -> (match x with 
                                          "dot" -> sprintf "__dot(%s)" (generate (List(el)))
                                        | "call" -> sprintf "__call(%s)" (generate (List(el)))
                                        | _ -> sprintf "(function(_i, _a) { return _i.__t === 'module' ? __box('module', __unbox(_i).apply(null, __unbox(_a).map(__unbox))) : eval('(' + __unbox(_i) + ').apply(null, ' + JSON.stringify(__unbox(_a)) + ')'); })(eval('%s'), %s)" x (generate (List(el))))
                        | Fdecl(x, y) -> sprintf "eval('(' + __unbox(%s) + ').apply(null, ' + JSON.stringify(__unbox(%s)) + ')')" (generate (Fdecl(x, y))) (generate (List(el)))
                        | Eval(x, y) -> sprintf "eval('(' + __unbox(%s) + ').apply(null, ' + JSON.stringify(__unbox(%s)) + ')')" (generate (Eval(x, y))) (generate (List(el)))
                        | _ -> raise (Failure "foo"))
                           
    | Fdecl(argl, exp) -> box "function"
        (sprintf
          "(function(%s) { return %s; }).toString()"
          (String.concat ", " argl)
          (generate exp))

    | If(cond, thenb, elseb) ->
        sprintf
          "(function() { var __c = __unbox(%s); return (!(Array.isArray(__c) && __c.length === 0) && __c) ? %s : %s; })()"
          (generate cond)
          (generate thenb)
          (generate elseb)

    | For(init, cond, update, exp) -> cc ["return "; generate Nil; ";"]
    | While(cond, exp) -> cc ["return "; generate Nil; ";"] 

    | Let(n, v, exp) ->
        sprintf
          "(function() { var %s = %s; return %s; })()"
          n
          (generate v)
          (generate exp)
  in
  let generate_head p =
    let rec get_deps fname =
      let (_, _, _, deps) = generate_js_func fname in
      deps @ (List.flatten (List.map get_deps deps)) in
    let get_def fname =
      let (body, _, _, _) = generate_js_func fname in
      cc ["var "; fname; "="; body] in
    let rec get_fnames e = match e with
        Eval(f, el) -> (match f with String(x) -> [x] | Fdecl(x, y) -> [] | Eval(x, y) -> get_fnames (Eval(x, y))) @ (get_fnames (List(el)))
      | Id(s) -> [s]
      | Assign(el) -> get_fnames (List(el))
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
  cc ("function getOwnPropertyDescriptors(object) { var keys = Object.getOwnPropertyNames(object), returnObj = {}; keys.forEach(getPropertyDescriptor); return returnObj; function getPropertyDescriptor(key) { var pd = Object.getOwnPropertyDescriptor(object, key); returnObj[key] = pd; } }"::
      "Object.getOwnPropertyDescriptors = getOwnPropertyDescriptors;"::
      "function __dup(o) { return Object.create(Object.getPrototypeOf(o), Object.getOwnPropertyDescriptors(o)); }"::
      "function __flatten(o) { var result = Object.create(o); for(var key in result) { result[key] = result[key]; } return result; }"::
      "function __box(t,v){ return ({ __t: t, __v: (t === 'module') ? v : __clone(v) }); };"::
      "function __clone(o){return JSON.parse(JSON.stringify(o));};"::
      "function __unbox(o){ return (o.__t === 'module') ? o.__v : __clone(o.__v); };"::
      "function __tojs(o) { if (o.__t === 'function') { return function() { var __temp = Array.prototype.slice.call(arguments); return eval('(' + o.__v + ').apply(null, __temp)'); }; } else { return __unbox(o); } };"::
      "function __call(args) { var __temp = !args.__v[0].__t ? args.__v[0] : __unbox(args.__v[0]); __temp[__unbox(args.__v[1])].apply(__temp, args.__v.slice(2).map(__tojs)); };"::
      "function __dot(args) { var __temp = args.__v; var res; for(var i = 1; i < __temp.length; i++) { res = (i === 1 ? __temp[0] : res)[__unbox(__temp[i])]; } return __box('json', res); };"::
      "function __test() {};"::
      "function __fcall(name,args){ var __temp = eval(name); return (__temp.__t === 'module') ? __box('module', __unbox(__temp).apply(null, __unbox(args).map(__unbox))) : name === 'dot' ? __dot(args) : name === 'call' ? __call(args) : eval('('+__unbox(__temp)+').apply(null,__unbox(args))'); };\n"::(generate_head p)::";\n"::(List.map wrap_exp p))
