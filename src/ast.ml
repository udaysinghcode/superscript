type op = Add | Sub | Mult | Div | Addf | Subf | Multf | Divf 
	| Equal | Neq | Less | Leq | Greater | Geq | And | Or | Assign | Concat

type htype =
  | TInt                     (** integers [int] *)
  | TFloat		     (** floats [floats] *)
  | TBool                    (** booleans [bool] *)
  | TString		     (** strings [string] *)
  | TParam of int            (** parameter *)
  | TArrow of htype list  (** Function type [s -> t] *)
  | TSomeList of htype          (** Lists *)
  | TUnit			(* unit type for printing *)
  | TSome			(* sometype - used only for lists *)
  | TJblob			(* JavaScript object type *)
  | TException 			(* Exceptions *)

type expr =				(* Expressions *)
  Int of int				(* 4 *)
  | Float of float			(* 4.444 *)
  | Boolean of bool	 		(* true, false *)
  | String of string			(* "hello world" *)
  | Id of string			(* caml_riders *)
  | Assign of expr list			(* {x = 5} OR (= x 5 y 6 z 7) *)
  | Eval of expr * expr list		(* (foo 5 21) *)
  | Nil					(* empty list '() *)
  | List of expr list			(* heterogeneous list '(1 true 2.4) *)
  | Fdecl of string list * expr 	(* (fn (a b) {a + b}) *)
  | If of expr * expr * expr		(* (if a b c) *)

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
    | TJblob -> TJblob, c
    | TException -> TException, c
    | TParam k ->
	(try
	   TParam (List.assoc k s), c
	 with 
	     Not_found -> TParam j, (j+1, (k, j)::s))
    | TArrow t_list ->
        let rec tarrow_ren ts us c' =
          match ts with
          | [] -> us, c'
          | hd::tl -> 
            (let u1, c'' = ren c' hd in
            tarrow_ren tl (us@[u1]) c'')
        in let u_list, final_c = (tarrow_ren t_list [] c) in
        TArrow u_list, final_c
    | TSomeList t -> let u, c' = ren c t in TSomeList u, c'
    | TUnit -> TUnit, c 
  in
    fst (ren (0,[]) ty)

(** [rename t1 t2] simultaneously renames types [t1] and [t2] so that
    parameters appearing in them are numbered from [0] on. *)

let rename2 t1 t2 =
match rename (TArrow [t1;t2]) with
      TArrow [u1;u2] -> u1, u2
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
	| TJblob -> (4, "JavaScript object")
	| TParam k -> (4, (if k < Array.length a then "'" ^ a.(k) else "'ty" ^ string_of_int k))
        | TException -> (1, "exception")
	| TArrow t_list -> let len = (List.length t_list)-1 in
                      let rec tarrow_type ts s =
                        match ts with
                        | [] -> s
                        | hd::tl ->
				if (List.length tl > 0) then
                            		tarrow_type tl (s^(to_str ((List.length ts)-1) hd)^" -> ")
                        	else (
                            		tarrow_type tl (s^(to_str ((List.length ts)-1) hd))
				)
                      in
                      (len, tarrow_type t_list "")
    in
      if m > n then str else "(" ^ str ^ ")"
  in
    to_str (-1) ty

(** [tsubst [(k1,t1); ...; (kn,tn)] t] replaces in type [t] parameters
    [TParam ki] with types [ti]. *)
let rec tsubst s = function
  | (TInt | TBool | TFloat | TString | TUnit | TSome | TJblob | TException ) as t -> t
  | TParam k -> (try List.assoc k s with Not_found -> TParam k)
  | TArrow t_list -> let u_list = List.map (fun t -> tsubst s t) t_list
                      in TArrow u_list 
  | TSomeList t -> TSomeList (tsubst s t)
