type op = Add | Sub | Mult | Div | Addf | Subf | Multf | Divf 
	| Equal | Neq | Less | Leq | Greater | Geq | And | Or | Assign | Concat

type htype =
  | TInt                     (** integers [int] *)
  | TFloat		     (** floats [floats] *)
  | TBool                    (** booleans [bool] *)
  | TString		     (** strings [string] *)
  | TParam of int            (** parameter *)
  | TArrow of htype * htype  (** Function type [a -> b -> c -> ... -> e] *)
  | TSomeList of htype          (** Lists *)
  | TUnit			(* unit type for printing *)
  | TSome			(* sometype - used only for lists *)

type expr =				(* Expressions *)
  Int of int				(* 4 *)
  | Float of float			(* 4.444 *)
  | Boolean of bool	 		(* true, false *)
  | String of string			(* "hello world" *)
  | Id of string			(* caml_riders *)
  | Assign of expr list			(* {x = 5} OR (= x 5 y 6 z 7) *)
  | Eval of expr * expr list		(* (foo 5 21) *)
  | Nil					(* null datatype *)
  | List of expr list			(* list, mixed datatypes allowed in same list *)
  | Fdecl of string list * expr 	(* (fn (a b) {a + b}) *)
  | If of expr * expr * expr		(* (if a b c) *)
  | Let of string * expr * expr		(* (let a b) *)

type program = expr list

(** [rename t] renames parameters in type [t] so that they count from
    [0] up. This is useful for pretty printing. *)
let rename (ty: htype) = 
  let rec ren ((j,s) as c) = function
    | TInt -> TInt, c
    | TBool -> TBool, c
    | TFloat -> TFloat, c
    | TString -> TString, c
    | TSome -> TSome, c
    | TParam k ->
	(try
	   TParam (List.assoc k s), c
	 with 
	     Not_found -> TParam j, (j+1, (k, j)::s))
    | TArrow (t1, t2) ->
	let u1, c'  = ren c t1 in
	let u2, c'' = ren c' t2 in
	  TArrow (u1,u2), c''
    | TSomeList t -> let u, c' = ren c t in TSomeList u, c'
    | TUnit -> TUnit, c 
  in
    fst (ren (0,[]) ty)

(** [rename t1 t2] simultaneously renames types [t1] and [t2] so that
    parameters appearing in them are numbered from [0] on. *)
let rename2 t1 t2 =
match rename (TArrow (t1,t2)) with
      TArrow (u1, u2) -> u1, u2
    | _ -> assert false

(** [string_of_type] converts a Poly type to string. *)
let string_of_type ty =
  let a = [|"a";"b";"c";"d";"e";"f";"g";"h";"i";
	    "j";"k";"l";"m";"n";"o";"p";"q";"r";
	    "s";"t";"u";"v";"w";"x";"y";"z"|]
  in
  let rec to_str n ty =
    let (m, str) =
      match ty with
	| TSome -> (3, "sometype")
	| TSomeList ty -> (3, to_str 3 ty ^ " list") 
 	| TUnit -> (4, "unit")
	| TInt -> (4, "int")
	| TFloat -> (4, "float")
	| TString -> (4, "string")
	| TBool -> (4, "bool")
	| TParam k -> (4, (if k < Array.length a then "'" ^ a.(k) else "'ty" ^ string_of_int k))
	| TArrow (ty1, ty2) -> (1, (to_str 1 ty1) ^ " -> " ^ (to_str 0 ty2))
    in
      if m > n then str else "(" ^ str ^ ")"
  in
    to_str (-1) ty

(** [string_of_expr e] converts expression [e] to string. *)
let string_of_expr e =
  let rec to_str n e =
    let (m, str) =
      match e with
	  Int n ->          (10, string_of_int n)
	| List l -> 	    (10, "list from ast.ml line 98")
	| Boolean b ->         (10, string_of_bool b)
	| String s -> 	(10, s)
	| Id x ->          (10, x)
	| Nil ->            (10, "[]")
	(*
	| Assign (e1, e2) -> (10, "assignment")
	| Eval (e1, e2) ->  (10, "<app>")
	    (* (9, (to_str 8 e1) ^ " " ^ (to_str 9 e2)) *)
	| Divide (e1, e2) -> (8, (to_str 7 e1) ^ " / " ^ (to_str 8 e2))
	| Mod (e1, e2) ->    (8, (to_str 7 e1) ^ " % " ^ (to_str 8 e2))
	| Plus (e1, e2) ->   (7, (to_str 6 e1) ^ " + " ^ (to_str 7 e2))
	| Minus (e1, e2) ->  (7, (to_str 6 e1) ^ " - " ^ (to_str 7 e2))
	| Cons (e1, e2) ->   (6, (to_str 6 e1) ^ " :: " ^ (to_str 5 e2))
	| Equal (e1, e2) ->  (5, (to_str 5 e1) ^ " = " ^ (to_str 5 e2))
	| Less (e1, e2) ->   (5, (to_str 5 e1) ^ " < " ^ (to_str 5 e2))
	| If (e1, e2, e3) -> (4, "if " ^ (to_str 4 e1) ^ " then " ^
				(to_str 4 e2) ^ " else " ^ (to_str 4 e3))
	| Match (e1, e2, x, y, e3) ->
	    (3, "match " ^ (to_str 3 e1) ^ " with " ^
	       "[] -> " ^ (to_str 3 e2) ^ " | " ^
	       x ^ "::" ^ y ^ " -> " ^ (to_str 3 e3))
	| Fun (x, e) -> (10, "<fun>")
	    (* (2, "fun " ^ x ^  " -> " ^ (to_str 0 e)) *)
	| Rec (x, e) -> (10, "<rec>")
	    (* (1, "rec " ^ x ^ " is " ^ (to_str 0 e)) *)
	*)
	| _ -> (20, "TO DO")   
    in
      if m > n then str else "(" ^ str ^ ")"
  in
    to_str (-1) e

(** [tsubst [(k1,t1); ...; (kn,tn)] t] replaces in type [t] parameters
    [TParam ki] with types [ti]. *)
let rec tsubst s = function
  | (TInt | TBool | TFloat | TString | TUnit | TSome ) as t -> t
  | TParam k -> (try List.assoc k s with Not_found -> TParam k)
  | TArrow (t1, t2) -> TArrow (tsubst s t1, tsubst s t2)
  | TSomeList t -> TSomeList (tsubst s t)
