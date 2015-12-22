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
      ("'function() {\
          for(var i=0; i < arguments.length; i++) {\
            __assert_type(\\'string\\', arguments[i], \\'prn\\', (i+1) + \\'\\');\
            console.log(__unbox(arguments[i]));\
          }\
          return __box(\\'unit\\', 0);\
        }'", [TString], TUnit, [])

    | "exec" -> 
      ("'function() {\
          var res;\
          for(var i = 0; i < arguments.length; i++) { \
            __assert_type(\\'list\\', arguments[i], \\'do\\', (i+1) + \\'\\'); \
            var str = JSON.stringify(__unbox(arguments[i]).slice(1)); \
            res = eval(\\'(\\' + __unbox(__unbox(arguments[i])[0]) + \\').apply(null, \\' + str + \\')\\'); \
          } \
          return res; \
        }'", [TSomeList(TSome)], TSome, ["evaluate"])

    | "pr" -> 
      ("'function(s) { \
          for(var i=0; i < arguments.length; i++) {\
            __assert_type(\\'string\\', arguments[i], \\'pr\\', (i+1) + \\'\\'); \
            process.stdout.write(__unbox(arguments[i]));\
          } \
          return __box(\\'unit\\', 0); \
        }'", [TString], TUnit, [])

    | "type" -> 
      ("'function(o) { \
          __assert_arguments_num(arguments.length, 1, \\'type\\'); \
          return __box(\\'string\\', o.__t); \
        }'", [TSome], TString, [])

    | "head" -> 
      ("'function(l) { \
          __assert_arguments_num(arguments.length, 1, \\'head\\'); \
          __assert_type(\\'list\\', l, \\'head\\', \\'1\\'); \
          return __clone(__unbox(l)[0]); \
        }'", [TSomeList(TSome)], TSome, [])

    | "tail" -> 
      ("'function(l) { \
          __assert_arguments_num(arguments.length, 1, \\'tail\\'); \
          __assert_type(\\'list\\', l, \\'tail\\', \\'1\\'); \
          return __box(\\'list\\', __unbox(l).slice(1)); \
        }'", [TSomeList(TSome)], TSomeList(TSome), [])

    | "cons" -> 
      ("'function(i, l) { \
          __assert_arguments_num(arguments.length, 2, \\'cons\\'); \
          __assert_type(\\'list\\', l, \\'cons\\', \\'2\\'); \
          var __temp = __unbox(l); \
          __temp.unshift(__clone(i)); \
          return __box(\\'list\\', __temp); \
        }'", [TSome; TSomeList(TSome)], TSomeList(TSome), [])

    | "__add" ->
      ("'function() { \
          for(var i=0; i < arguments.length; i++) { \
            __assert_type(\\'int\\', arguments[i], \\'+\\', (i+1) + \\'\\');\
          } \
          return __box(\\'int\\', arguments.length === 0 ? 0 : \
            Array.prototype.slice.call(arguments).map(__unbox).reduce(function(a,b){return a+b;}));\
        }'", [TInt; TInt], TInt, [])

    | "__sub" ->
      ("'function(a1) { \
          for(var i=0; i < arguments.length; i++) { \
            __assert_type(\\'int\\', arguments[i], \\'-\\', (i+1) + \\'\\');\
          } \
          return __box(\\'int\\', arguments.length === 0 ? 0 : arguments.length === 1 ? -1 * __unbox(a1) : \
            Array.prototype.slice.call(arguments).map(__unbox).reduce(function(a,b){return a-b;}));\
        }'", [TInt; TInt], TInt, [])

    | "__mult" ->
      ("'function() { \
          for(var i=0; i < arguments.length; i++) { \
            __assert_type(\\'int\\', arguments[i], \\'*\\', (i+1) + \\'\\');\
          } \
          return __box(\\'int\\', arguments.length === 0 ? 1 : \
            Array.prototype.slice.call(arguments).map(__unbox).reduce(function(a,b){return a*b;})); \
        }'", [TInt; TInt], TInt, [])

    | "__div" ->
      ("'function() { \
          for(var i=0; i < arguments.length; i++) { \
            __assert_type(\\'int\\', arguments[i], \\'/\\', (i+1) + \\'\\');\
          } \
          return __box(\\'int\\', \
            Math.floor(Array.prototype.slice.call(arguments).map(__unbox).reduce(function(a,b){return a/b;}))); \
        }'", [TInt; TInt], TInt, [])

    | "mod" ->
      ("'function(a1, a2) { \
          for(var i=0; i < arguments.length; i++) { \
            __assert_arguments_num(arguments.length, 2, \\'mod\\'); \
            __assert_type(\\'int\\', arguments[i], \\'mod\\', (i+1) + \\'\\');\
          }  \
          return __box(\\'int\\', __unbox(a1) % __unbox(a2)); \
          }'", [TInt; TInt], TInt, [])

    | "__addf" ->
      ("'function(a1) { \
          for(var i=0; i < arguments.length; i++) { \
            __assert_type(\\'float\\', arguments[i], \\'+.\\', (i+1) + \\'\\');\
          }  \
          return __box(\\'float\\', arguments.length === 0 ? 0 : \
            Array.prototype.slice.call(arguments).map(__unbox).reduce(function(a,b){return a+b;})); \
        }'", [TFloat; TFloat], TFloat, [])

    | "__subf" ->
      ("'function(a1) { \
          for(var i=0; i < arguments.length; i++) { \
            __assert_type(\\'float\\', arguments[i], \\'-.\\', (i+1) + \\'\\');\
          } \
          return __box(\\'float\\', arguments.length === 0 ? 0 : arguments.length === 1 ? -1 * __unbox(a1) : 
            Array.prototype.slice.call(arguments).map(__unbox).reduce(function(a,b){return a-b;})); \
        }'", [TFloat; TFloat], TFloat, [])

    | "__multf" ->
      ("'function(a1) { \
          for(var i=0; i < arguments.length; i++) { \
            __assert_type(\\'float\\', arguments[i], \\'*.\\', (i+1) + \\'\\');\
          } \
          return __box(\\'float\\', Array.prototype.slice.call(arguments).map(__unbox).reduce(function(a,b){return a*b;})); \
          }'", [TFloat; TFloat], TFloat, [])

    | "__divf" ->
      ("'function(a1, a2) { \
          for(var i=0; i < arguments.length; i++) { \
            __assert_type(\\'float\\', arguments[i], \\'/.\\', (i+1) + \\'\\');\
          } \
          return __box(\\'float\\', Array.prototype.slice.call(arguments).map(__unbox).reduce(function(a,b){return a/b;})); \
        }'", [TFloat; TFloat], TFloat, [])

    | "__equal" ->
      ("'function(a1, a2) { \
          __assert_arguments_num(arguments.length, 2, \\'is\\'); \
          if (a1.__t !== a2.__t) { \
            throw new TypeError(\\'expected arguments of function is to be the same, \
              but found \\' + a1.__t + \\' and \\' + a2.__t +\\'.\\'); \
          } \
          return __box(\\'boolean\\', JSON.stringify(__unbox(a1)) === JSON.stringify(__unbox(a2))); \
        }'", [TParam 1; TParam 1], TBool, [])

    | "__neq" ->
      ("'function(a1, a2) { \
          __assert_arguments_num(arguments.length, 2, \\'isnt\\'); \
          if (a1.__t !== a2.__t) { \
            throw new TypeError(\\'expected arguments of function isnt to be the same, \
              but found \\' + a1.__t + \\' and \\' + a2.__t +\\'.\\'); \
          } \
          return __box(\\'boolean\\', __unbox(a1) !== __unbox(a2)); \
        }'", [TParam 1; TParam 1], TBool, [])

    | "__less" ->
      ("'function(a1, a2) { \
          __assert_arguments_num(arguments.length, 2, \\'<\\'); \
          if (a1.__t !== a2.__t) { \
            throw new TypeError(\\'expected arguments of function < to be the same, \
              but found \\' + a1.__t + \\' and \\' + a2.__t +\\'.\\'); \
          } \
          return __box(\\'boolean\\', __unbox(a1) < __unbox(a2)); \
        }'", [TParam 1; TParam 1], TBool, [])

    | "__leq" ->
      ("'function(a1, a2) { \
          __assert_arguments_num(arguments.length, 2, \\'<=\\'); \
          if (a1.__t !== a2.__t) { \
            throw new TypeError(\\'expected arguments of function <= to be the same, \
              but found \\' + a1.__t + \\' and \\' + a2.__t +\\'.\\'); \
          } \
          return __box(\\'boolean\\', __unbox(a1) <= __unbox(a2)); \
        }'",[TParam 1; TParam 1], TBool, [])

    | "__greater" ->
      ("'function(a1, a2) { \
          __assert_arguments_num(arguments.length, 2, \\'>\\'); \
          if (a1.__t !== a2.__t) { \
            throw new TypeError(\\'expected arguments of function > to be the same, \
              but found \\' + a1.__t + \\' and \\' + a2.__t +\\'.\\'); \
          } \
          return __box(\\'boolean\\', __unbox(a1) > __unbox(a2)); \
        }'", [TParam 1; TParam 1], TBool, [])

    | "__geq" ->
      ("'function(a1, a2) { \
          __assert_arguments_num(arguments.length, 2, \\'<=\\'); \
          if (a1.__t !== a2.__t) { \
            throw new TypeError(\\'expected arguments of function >= to be the same, \
              but found \\' + a1.__t + \\' and \\' + a2.__t +\\'.\\'); \
          } \
          return __box(\\'boolean\\', __unbox(a1) >= __unbox(a2)); \
        }'", [TParam 1; TParam 1], TBool, [])

    | "__and" ->
      ("'function(a1, a2) { \
          __assert_arguments_num(arguments.length, 2, \\'and\\'); \
          __assert_type(\\'boolean\\', a1, \\'and\\', \\'1\\'); \
          __assert_type(\\'boolean\\', a2, \\'and\\', \\'2\\'); \
          return __box(\\'boolean\\', __unbox(a1) && __unbox(a2)); \
        }'", [TBool; TBool], TBool, [])

    | "__or" ->
      ("'function(a1, a2) { \
          __assert_arguments_num(arguments.length, 2, \\'or\\'); \
          __assert_type(\\'boolean\\', a1, \\'or\\', \\'1\\'); \
          __assert_type(\\'boolean\\', a2, \\'or\\', \\'2\\'); \
          return __box(\\'boolean\\', __unbox(a1) || __unbox(a2)); \
        }'", [TBool; TBool], TBool, [])

    | "__not" ->
      ("'function(a) { \
          __assert_arguments_num(arguments.length, 1, \\'not\\'); \
          __assert_type(\\'boolean\\', a, \\'not\\', \\'1\\'); \
          return __box(\\'boolean\\', !__unbox(a)); \
        }'", [TBool], TBool, [])

    | "string_of_int" ->
      ("'function(i) { \
          __assert_arguments_num(arguments.length, 1, \\'string_of_int\\'); \
          __assert_type(\\'int\\', i, \\'string_of_int\\', \\'1\\'); \
          return __box(\\'string\\', \\'\\' + __unbox(i)); \
        }'", [TInt], TString, [])

    | "int_of_string" ->
      ("'function(s) { \
          __assert_arguments_num(arguments.length, 1, \\'int_of_string\\'); \
          __assert_type(\\'string\\', s, \\'int_of_string\\', \\'1\\'); \
          return __box(\\'int\\', parseInt(__unbox(s))); \
        }'", [TString], TInt, [])

    | "string_of_float" ->
      ("'function(f) { \
          __assert_arguments_num(arguments.length, 1, \\'string_of_float\\'); \
          __assert_type(\\'float\\', f, \\'string_of_float\\', \\' 1\\'); \
          return __box(\\'string\\', \\'\\' + __unbox(f)); \
        }'", [TFloat], TString, [])

    | "float_of_string" ->
      ("'function(s) { \
          __assert_arguments_num(arguments.length, 1, \\'float_of_string\\'); \
          __assert_type(\\'string\\', s, \\'float_of_string\\', \\'1\\'); \
          return __box(\\'float\\', parseFloat(__unbox(s))); \
        }'", [TString], TFloat, [])

    | "string_of_boolean" ->
      ("'function(b) { \
          __assert_arguments_num(arguments.length, 1, \\'string_of_boolean\\'); \
          __assert_type(\\'boolean\\', b, \\'string_of_boolean\\', \\'1\\'); \
          return __box(\\'string\\', \\'\\' + __unbox(b)); \
        }'", [TBool], TString, [])

    | "__concat" ->
      ("'function() { \
          for(var i=0; i < arguments.length; i++) { \
            __assert_type(\\'string\\', arguments[i], \\'++\\', (i+1) + \\'\\');\
          } \
          return __box(\\'string\\', arguments.length === 0 ? \\'\\' : \
            Array.prototype.slice.call(arguments).map(__unbox).reduce(function(a,b){return a+b;})); \
        }'", [TString; TString], TString, [])

    | "evaluate" ->
      ("'function(l) { \
          __assert_arguments_num(arguments.length, 1, \\'eval\\'); \
          __assert_type(\\'list\\', l, \\'eval\\', \\'1\\');\
          return eval(\\'(\\' + __unbox(__unbox(l)[0]) + \\').apply(null, \\' + JSON.stringify(__unbox(l).slice(1)) + \\')\\'); \
        }'", [TSomeList(TSome)], TSome, [])

    | "module" ->
      ("'function(n) { \
          __assert_arguments_num(arguments.length, 1, \\'module\\'); \
          __assert_type(\\'string\\', n, \\'module\\', \\'1\\'); \
          return __box(\\'module\\', require(__unbox(n))); \
        }'", [TString], TJblob, [])

    | "list" ->
      ("'function(i) { \
          __assert_arguments_num(arguments.length, 1, \\'list\\'); \
          if (__fcall(\\'type\\', __box(\\'list\\', [i])).__v !== \\'list\\') { \
            throw new TypeError(\\'not a list!\\'); \
          } else { \
            return i; \
          } \
        }'", [TSome], TSomeList(TSome), ["type"])

    | "int" ->
      ("'function(i) { \
          __assert_arguments_num(arguments.length, 1, \\'int\\'); \
          if (__fcall(\\'type\\', __box(\\'list\\', [i])).__v !== \\'int\\') { \
            throw new TypeError(\\'not an int!\\'); \
          } else { \
            return i; \
          } \
        }'", [TSome], TInt, ["type"])

    | "string" ->
      ("'function(i) { \
          __assert_arguments_num(arguments.length, 1, \\'string\\'); \
          if (__fcall(\\'type\\', __box(\\'list\\', [i])).__v !== \\'string\\') { \
            throw new TypeError(\\'not a string!\\'); \
          } else { \
            return i; \
          } \
        }'", [TSome], TString, ["type"])

    | "float" ->
      ("'function(i) { \
          __assert_arguments_num(arguments.length, 1, \\'float\\'); \
          if (__fcall(\\'type\\', __box(\\'list\\', [i])).__v !== \\'float\\') { \
            throw new TypeError(\\'not a float!\\'); \
          } else { \
            return i; \
          } \
        }'", [TSome], TFloat, ["type"])

    | "boolean" ->
      ("'function(i) { \
          __assert_arguments_num(arguments.length, 1, \\'boolean\\'); \
          if (__fcall(\\'type\\', __box(\\'list\\', [i])).__v !== \\'boolean\\') { \
            throw new TypeError(\\'not a boolean!\\'); \
          } else { \
            return i; \
          } \
        }'", [TSome], TBool, ["type"])

    | "exception" ->
      ("'function(i) { \
          __assert_arguments_num(arguments.length, 1, \\'exception\\'); \
          __assert_type(\\'string\\', i, \\'exception\\', \\'1\\'); \
          throw new Error(i); \
        }'", [TString], TUnit, [])

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
                      | If(c, t, e) -> get_fnames (If(c, t, e))
                      | _ -> []) @ (get_fnames (List(el)))
    | Id(s) -> [s]
    | Assign(el) -> get_fnames (List(el))
    | List(el) -> List.flatten (List.map get_fnames el)
    | Fdecl(argl, exp) -> get_fnames exp
    | If(cond, thenb, elseb) -> (get_fnames cond) @ (get_fnames thenb) @ (get_fnames elseb)
    | _ -> [] in
  let generatable = (List.filter is_generatable (List.flatten (List.map get_fnames prog))) in
  let dependencies = List.map get_deps generatable in
  List.sort_uniq compare (generatable @ (List.flatten dependencies))

let arrow_of fname =
  let (_, arg_types, ret_type, _) = generate_js_func fname in
  match arg_types, ret_type with
  | [t1], t2 -> TArrow([t1; t2])
  | [t1; t2], t3 -> TArrow([t1; t2; t3])
  | _ -> raise(Failure ("Unknown identifier: '" ^ fname ^ "' "))

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
                    | _ -> sprintf "(function(_i, _a) { \
                                      return _i.__t === 'module' ? __box('module', __unbox(_i).apply(null, __unbox(_a).map(__unbox))) : \
                                        eval('(' + __unbox(_i) + ').apply(null, ' + JSON.stringify(__unbox(_a)) + ')'); \
                                    })\
                                    (eval('%s'), %s)" x argl)
        
        | x -> sprintf
                  "eval('(' + __unbox(%s) + ').apply(null, ' + JSON.stringify(__unbox(%s)) + ')')"
                  (match x with
                    Fdecl(a, e) -> generate (Fdecl(a, e))
                  | Eval(f, e) -> generate (Eval(f, e))
                  | If(c, t, e) -> generate (If(c, t, e))
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

  in
  let generate_head p =
    let get_def fname =
      let (body, _, _, _) = generate_js_func fname in
      cc ["var "; fname; "="; body] in
    String.concat ";\n" (List.map get_def (get_generatable_fnames p)) in
  let wrap_exp e = cc [generate e; ";"] in
  cc (
        "try {

        function getOwnPropertyDescriptors(object) {\
          var keys = Object.getOwnPropertyNames(object), returnObj = {}; \
          keys.forEach(getPropertyDescriptor); \
          return returnObj; \
          function getPropertyDescriptor(key) { \
            var pd = Object.getOwnPropertyDescriptor(object, key); \
            returnObj[key] = pd; \
          } }"::

        "Object.getOwnPropertyDescriptors = getOwnPropertyDescriptors;"::

        "function __dup(o) { \
          return Object.create(Object.getPrototypeOf(o), Object.getOwnPropertyDescriptors(o)); \
        }"::

        "function __flatten(o) { \
          var result = Object.create(o); \
          for(var key in result) { result[key] = result[key]; } \
          return result; \
        }"::

        "function __box(t,v){ \
          return ({ __t: t, __v: (t === 'module') ? v : __clone(v) }); \
        };"::

        "function __clone(o){\
          return JSON.parse(JSON.stringify(o));\
        };"::

        "function __unbox(o){ \
          return (o.__t === 'module') ? o.__v : __clone(o.__v); \
        };"::

        "function __assert_type(t, o, f, nth) { \
          if (o.__t !== t) { \
            throw new TypeError('expected type of argument ' + nth + ' of function ' + f + \
              ' to be ' + t + ' but found ' + o.__t); \
          } else { \
            return true; \
          }\
        }"::

        "function __assert_arguments_num(actual, expected, f) { \
          if (actual !== expected) { \
            throw new TypeError('expected ' + expected + ' arguments to function ' + f + \
              ' but found ' + actual + ' arguments. '); \
          } else { \
            return true; \
          } \
        };"::

        "function __tojs(o) { \
          if (o.__t === 'function') { \
            return function() { \
              var __temp = Array.prototype.slice.call(arguments); \
              return eval('(' + o.__v + ').apply(null, __temp)'); \
            }; \
          } else { \
            return __unbox(o); \
          } \
        };"::

        "function __call(args) { \
          var __temp = !args.__v[0].__t ? args.__v[0] : __unbox(args.__v[0]); \
          __temp[__unbox(args.__v[1])].apply(__temp, args.__v.slice(2).map(__tojs)); \
        };"::

        "function __dot(args) { \
          var __temp = args.__v; \
          var res; \
          for(var i = 1; i < __temp.length; i++) { \
            res = (i === 1 ? __temp[0] : res)[__unbox(__temp[i])]; \
          } \
          return __box('json', res); \
        };"::

        "function __fcall(name,args){ \
          var __temp = eval(name); \
          return (__temp.__t === 'module') ? __box('module', __unbox(__temp).apply(null, __unbox(args).map(__unbox))) : \
            name === 'dot' ? __dot(args) : name === 'call' ? __call(args) : \
            eval('('+__unbox(__temp)+').apply(null,__unbox(args))'); \
        };\n"::

      (generate_head p)::";\n"::(List.map wrap_exp p) @ ["} catch (e) { console.log('RuntimeError: ' + e.message); }"])
