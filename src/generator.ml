(* Author: Samurdha Jayasinghe *)

open Ast;;
open Printf;;

let sprintf = Printf.sprintf;;

let cc l = String.concat "" l;;
let box t v = sprintf "({ __t: '%s', __v: %s })" t v;;

let generate_js_func fname =
  let helper fname =
    match fname with
      "prn" -> 
      ("'function() { Array.prototype.slice.call(arguments).forEach(function(i) { console.log(__unbox(i)); }); return __box(\\'unit\\', 0); }'",
        [TString], TUnit, [])
    | "exec" -> 
      ("'function() { var res; for(var i = 0; i < arguments.length; i++) { res = eval(\\'(\\' + __unbox(__unbox(arguments[i])[0]) + \\').apply(null, \\' + JSON.stringify(__unbox(arguments[i]).slice(1)) + \\')\\'); } return res; }'",
        [TSomeList(TSome)], TSome, ["evaluate"])
    | "pr" -> 
      ("'function(s) { Array.prototype.slice.call(arguments).forEach(function(i) { process.stdout.write(__unbox(i)); }); return __box(\\'unit\\', 0); }'",
        [TString], TUnit, [])
    | "type" -> 
      ("'function(o) { return __box(\\'string\\', o.__t); }'",
        [TSome], TString, [])
    | "head" -> 
      ("'function(l) { return __clone(__unbox(l)[0]); }'",
        [TSomeList(TSome)], TSome, [])
    | "tail" -> 
      ("'function(l) { return __box(\\'list\\', __unbox(l).slice(1)); }'",
        [TSomeList(TSome)], TSomeList(TSome), [])
    | "cons" -> 
      ("'function(i, l) { var __temp = __unbox(l); __temp.unshift(__clone(i)); return __box(\\'list\\', __temp); }'",
        [TSome; TSomeList(TSome)], TSomeList(TSome), [])
    | "__add" ->
      ("'function() { return __box(\\'int\\', arguments.length === 0 ? 0 : Array.prototype.slice.call(arguments).map(__unbox).reduce(function(a,b){return a+b;})); }'",
        [TInt; TInt], TInt, [])
    | "__sub" ->
      ("'function(a1) { return __box(\\'int\\', arguments.length === 0 ? 0 : arguments.length === 1 ? -1 * __unbox(a1) : Array.prototype.slice.call(arguments).map(__unbox).reduce(function(a,b){return a-b;})); }'",
        [TInt; TInt], TInt, [])
    | "__mult" ->
      ("'function() { return __box(\\'int\\', arguments.length === 0 ? 1 : Array.prototype.slice.call(arguments).map(__unbox).reduce(function(a,b){return a*b;})); }'",
        [TInt; TInt], TInt, [])
    | "__div" ->
      ("'function() { return __box(\\'int\\', Math.floor(Array.prototype.slice.call(arguments).map(__unbox).reduce(function(a,b){return a/b;}))); }'",
        [TInt; TInt], TInt, [])
    | "mod" ->
      ("'function(a1, a2) { return __box(\\'int\\', __unbox(a1) % __unbox(a2)); }'",
        [TInt; TInt], TInt, [])
    | "__addf" ->
      ("'function(a1) { return __box(\\'float\\', arguments.length === 0 ? 0 : Array.prototype.slice.call(arguments).map(__unbox).reduce(function(a,b){return a+b;})); }'",
        [TFloat; TFloat], TFloat, [])
    | "__subf" ->
      ("'function(a1) { return __box(\\'float\\', arguments.length === 0 ? 0 : arguments.length === 1 ? -1 * __unbox(a1) : Array.prototype.slice.call(arguments).map(__unbox).reduce(function(a,b){return a-b;})); }'",
        [TFloat; TFloat], TFloat, [])
    | "__multf" ->
      ("'function(a1) { return __box(\\'float\\', Array.prototype.slice.call(arguments).map(__unbox).reduce(function(a,b){return a*b;})); }'",
        [TFloat; TFloat], TFloat, [])
    | "__divf" ->
      ("'function(a1, a2) { return __box(\\'float\\', Array.prototype.slice.call(arguments).map(__unbox).reduce(function(a,b){return a/b;})); }'",
        [TFloat; TFloat], TFloat, [])
    | "__equal" ->
      ("'function(a1, a2) { return __box(\\'boolean\\', JSON.stringify(__unbox(a1)) === JSON.stringify(__unbox(a2))); }'",
        [TParam 1; TParam 1], TBool, [])
    | "__neq" ->
      ("'function(a1, a2) { return __box(\\'boolean\\', __unbox(a1) !== __unbox(a2)); }'",
        [TParam 1; TParam 1], TBool, [])
    | "__less" ->
      ("'function(a1, a2) { return __box(\\'boolean\\', __unbox(a1) < __unbox(a2)); }'",
        [TParam 1; TParam 1], TBool, [])
    | "__leq" ->
      ("'function(a1, a2) { return __box(\\'boolean\\', __unbox(a1) <= __unbox(a2)); }'",
        [TParam 1; TParam 1], TBool, [])
    | "__greater" ->
      ("'function(a1, a2) { return __box(\\'boolean\\', __unbox(a1) > __unbox(a2)); }'",
        [TParam 1; TParam 1], TBool, [])
    | "__geq" ->
      ("'function(a1, a2) { return __box(\\'boolean\\', __unbox(a1) >= __unbox(a2)); }'",
        [TParam 1; TParam 1], TBool, [])
    | "__and" ->
      ("'function(a1, a2) { return __box(\\'boolean\\', __unbox(a1) && __unbox(a2)); }'",
        [TBool; TBool], TBool, [])
    | "__or" ->
      ("'function(a1, a2) { return __box(\\'boolean\\', __unbox(a1) || __unbox(a2)); }'",
        [TBool; TBool], TBool, [])
    | "__not" ->
      ("'function(a) { return __box(\\'boolean\\', !__unbox(a); }'",
        [TBool], TBool, [])
    | "string_of_int" ->
      ("'function(i) { return __box(\\'string\\', \\'\\' + __unbox(i)); }'",
        [TInt], TString, [])
    | "int_of_string" ->
      ("'function(s) { return __box(\\'int\\', parseInt(__unbox(s))); }'",
        [TString], TInt, [])
    | "string_of_float" ->
      ("'function(f) { return __box(\\'string\\', \\'\\' + __unbox(f)); }'",
        [TFloat], TString, [])
    | "float_of_string" ->
      ("'function(s) { return __box(\\'float\\', parseFloat(__unbox(s))); }'",
        [TString], TFloat, [])
    | "string_of_boolean" ->
      ("'function(b) { return __box(\\'string\\', \\'\\' + __unbox(b)); }'",
        [TBool], TString, [])
    | "__concat" ->
      ("'function() { return __box(\\'string\\', Array.prototype.slice.call(arguments).map(__unbox).reduce(function(a,b){return a+b;})); }'",
        [TString; TString], TString, [])
    | "evaluate" ->
      ("'function(l) { return eval(\\'(\\' + __unbox(__unbox(l)[0]) + \\').apply(null, \\' + JSON.stringify(__unbox(l).slice(1)) + \\')\\'); }'",
        [TSomeList(TSome)], TSome, [])
    | "module" ->
      ("'function(n) { return __box(\\'module\\', require(__unbox(n))); }'",
        [TString], TSome, [])
    | "int" ->
      ("'function(i) { if (__fcall(\\'type\\', __box(\\'list\\', [i])).__v !== \\'int\\') { throw new TypeError(\\'not an int!\\'); } else { return i; } }'",
        [TSome], TInt, ["type"])
    | "string" ->
      ("'function(i) { if (__fcall(\\'type\\', __box(\\'list\\', [i])).__v !== \\'string\\') { throw new TypeError(\\'not a string!\\'); } else { return i; } }'",
        [TSome], TString, ["type"])
    | "float" ->
      ("'function(i) { if (__fcall(\\'type\\', __box(\\'list\\', [i])).__v !== \\'float\\') { throw new TypeError(\\'not a float!\\'); } else { return i; } }'",
        [TSome], TFloat, ["type"])
    | "boolean" ->
      ("'function(i) { if (__fcall(\\'type\\', __box(\\'list\\', [i])).__v !== \\'boolean\\') { throw new TypeError(\\'not a boolean!\\'); } else { return i; } }'",
        [TSome], TBool, ["type"])
    | _ -> ("", [], TSome, [])
  in
    let (fstr, arg_types, ret_type, deps) = helper fname in
    (box "function" fstr, arg_types, ret_type, deps)

let is_generatable fname =
  let (_, argtypes, _, _) = generate_js_func fname in
  argtypes != []

let get_generatable_fnames prog =
  let rec get_deps fname =
    let (_, _, _, deps) = generate_js_func fname in
    deps @ (List.flatten (List.map get_deps deps)) in
  let rec get_fnames e = match e with
      Eval(f, el) -> (match f with 
                        Id(x) -> [x]
                      | Fdecl(x, y) -> get_fnames y 
                      | Eval(x, y) -> get_fnames (Eval(x, y))
                      | Let(n, v, e) -> get_fnames (Let(n, v, e)) 
                      | _ -> []) @ (get_fnames (List(el)))
    | Id(s) -> [s]
    | Assign(el) -> get_fnames (List(el))
    | List(el) -> List.flatten (List.map get_fnames el)
    | Fdecl(argl, exp) -> get_fnames exp
    | If(cond, thenb, elseb) -> (get_fnames cond) @ (get_fnames thenb) @ (get_fnames elseb)
    | Let(n, v, exp) -> (get_fnames v) @ (get_fnames exp)
    | _ -> [] in
  let generatable = (List.filter is_generatable (List.flatten (List.map get_fnames prog))) in
  let dependencies = List.map get_deps generatable in
  List.sort_uniq compare (generatable @ (List.flatten dependencies))

let arrow_of fname =
  let (_, arg_types, ret_type, _) = generate_js_func fname in
  match arg_types, ret_type with
  | [t1], t2 -> TArrow([t1; t2])
  | [t1; t2], t3 -> TArrow([t1; t2; t3])
  | _ -> raise(Failure "unknown identifier")

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
                      sprintf "eval('%s')" (cc (List.map 
                                                  (function
                                                   | (Id(s), e) -> sprintf "var %s = %s; %s;" s (escape_quotes (generate e)) s
                                                   | _ -> raise (Failure "can only assign to identifier"))
                                                  (gen_pairs el)))

    | Eval(first, el) -> 
        let argl = generate (List(el)) in
        (match first with
          Id(x) -> (match x with 
                      "dot" -> sprintf "__dot(%s)" argl
                    | "call" -> sprintf "__call(%s)" argl
                    | _ -> sprintf "(function(_i, _a) { return _i.__t === 'module' ? __box('module', __unbox(_i).apply(null, __unbox(_a).map(__unbox))) : eval('(' + __unbox(_i) + ').apply(null, ' + JSON.stringify(__unbox(_a)) + ')'); })(eval('%s'), %s)" x argl)
        
        | x -> sprintf
                  "eval('(' + __unbox(%s) + ').apply(null, ' + JSON.stringify(__unbox(%s)) + ')')"
                  (match x with
                    Fdecl(a, e) -> generate (Fdecl(a, e))
                  | Eval(f, e) -> generate (Eval(f, e))
                  | Let(n, v, e) -> generate (Let(n, v, e))
                  | _ -> raise (Failure "foo"))
                  argl)

    | Fdecl(argl, exp) -> box "function"
        (sprintf
          "(function(%s) { return %s; }).toString()"
          (String.concat ", " argl)
          (generate exp))

    | If(cond, thenb, elseb) ->
        sprintf
          "(function() { var __c = __unbox(%s); return !(Array.isArray(__c) && __c.length === 0) && __c ? %s : %s; })()"
          (generate cond)
          (generate thenb)
          (generate elseb)

    | Let(n, v, e) ->
        sprintf
          "(function() { var %s = %s; return %s; })()"
          n
          (generate v)
          (generate e)
  in
  let generate_head p =
    let get_def fname =
      let (body, _, _, _) = generate_js_func fname in
      cc ["var "; fname; "="; body] in
    String.concat ";\n" (List.map get_def (get_generatable_fnames p)) in
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