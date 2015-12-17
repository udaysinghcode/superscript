(* Type inference *)

open Ast;;

exception Type_error of string
exception Invalid_args of string

(** [type_error msg] reports a type error by raising [Type_error msg]. *)
let type_error msg = raise (Type_error msg)
(** [invalid_args_error msg] reports invalid argument exceptions by raising [Invalid_args msg]. *)
let invalid_args_error msg = raise(Invalid_args msg)

(** [fresh ()] returns an unused type parameter. *)
let fresh =
  let k = ref 0 in
    fun () -> incr k; TParam !k

(** [refresh t] replaces all parameters appearing in [t] with unused ones. *)
let refresh ty =
  let rec refresh s = function
    | TInt -> TInt, s
    | TFloat -> TFloat, s
    | TBool -> TBool, s
    | TString -> TString, s
    | TUnit -> TUnit, s
    | TSome -> TSome, s
    | TParam k ->
	(try
	   List.assoc k s, s
	 with Not_found -> let t = fresh () in t, (k,t)::s)
    | TArrow (t1, t2) ->
	let u1, s'  = refresh s t1 in
	let u2, s'' = refresh s' t2 in
	  TArrow (u1, u2), s''
    | TSomeList t ->
	let u, s' = refresh s t in
	  TSomeList u, s'
  in
    fst (refresh [] ty)

(** [occurs k t] returns [true] if parameter [TParam k] appears in type [t]. *)
let rec occurs k = function
  | TInt -> false
  | TFloat -> false
  | TString -> false
  | TBool -> false
  | TUnit -> false
  | TSome -> false
  | TParam j -> k = j
  | TArrow (t1, t2) -> occurs k t1 || occurs k t2
  | TSomeList t1 -> occurs k t1

(** [solve [(t1,u1); ...; (tn,un)] solves the system of equations
    [t1=u1], ..., [tn=un]. The solution is represented by a list of
    pairs [(k,t)], meaning that [TParam k] equals [t]. A type error is
    raised if there is no solution. The solution found is the most general
    one.
*)
let solve eq =
  let rec solve eq sbst =
    match eq with
      | [] -> sbst
	  
      | (t1, t2) :: eq when t1 = t2 -> solve eq sbst
	  
      | ((TParam k, t) :: eq | (t, TParam k) :: eq) when (not (occurs k t)) ->
	  let ts = Ast.tsubst [(k,t)] in
	    solve
	      (List.map (fun (ty1,ty2) -> (ts ty1, ts ty2)) eq)
	      ((k,t)::(List.map (fun (n, u) -> (n, ts u)) sbst))
	      
      | (TArrow (u1,v1), TArrow (u2,v2)) :: eq ->
	  solve ((u1,u2)::(v1,v2)::eq) sbst
	    
      | (TSomeList t1, TSomeList t2) :: eq ->
        	solve ((t1,t2) :: eq) sbst
      | (t1,t2)::_ ->
	  let u1, u2 = rename2 t1 t2 in
	    type_error ("The types " ^ string_of_type u1 ^ " and " ^
			  string_of_type u2 ^ " are incompatible")  
in
    solve eq []

(** [constraints_of gctx e] infers the type of expression [e] and a set
    of constraints, where [gctx] is global context of values that [e]
    may refer to. *)
let rec constraints_of gctx = 
  let rec cnstr ctx = function
    | Id x ->  
	(try
	   List.assoc x ctx, []
	 with Not_found ->
	   (try
	      (* we call [refresh] here to get let-polymorphism *)
	      refresh (List.assoc x gctx), []
	    with Not_found -> type_error ("Unknown variable " ^ x)))
	  
    | Int _ ->  TInt, []
    | Float _ -> TFloat, []
    | String _ -> TString, []
    | Boolean _ -> TBool, []
    | Nil -> TSomeList (fresh ()), []
    | List thelist -> let rec addcnstr = function
	| [] -> []
	| hd::tl -> let ty1, eq1 = cnstr ctx hd in
		eq1 @ addcnstr tl
	in TSomeList(TSome), addcnstr thelist

    | If (e1, e2, e3) ->
	let ty1, eq1 = cnstr ctx e1 in
	let ty2, eq2 = cnstr ctx e2 in
	let ty3, eq3 = cnstr ctx e3 in
	  ty2, (ty1, TBool) :: (ty2, ty3) :: eq1 @ eq2 @ eq3

    | Fdecl(x, e) -> TInt, [] (*
	let ty1 = fresh () in
	let ty2, eq = cnstr ((x,ty1)::ctx) e in
	  ty1, (ty1, ty2) :: eq *)

    | Assign(e) -> (* all ids/types were already added to ctx in the executor. just return the type of the last assignment *)
	let last = List.hd (List.rev e) in
	let ty, eq = cnstr ctx last in
	ty, eq
    | Eval(e1, e2) -> (
       match e1 with
       | Let(a,b,c) -> TUnit, [] 
       | If(a,b,c) -> TUnit, []
       | Fdecl(a,b) -> TUnit, []
       | Id(e1) -> match e1 with
 	  "__add"
	| "__sub"
	| "__mult"
	| "__div" -> ( match e2 with
		| [] -> TInt, []
		| hd::tl -> let ty1, eq1 = cnstr ctx hd in
			    let ty2, eq2 = cnstr ctx (Eval(Id(e1), tl)) in
			    TInt, (ty1,TInt) :: (ty2,TInt) :: eq1 @ eq2
	)
	| "__addf"
	| "__subf"
	| "__multf"
	| "__divf" -> ( match e2 with
		| [] -> TFloat, []
		| hd::tl -> let ty1, eq1 = cnstr ctx hd in
			    let ty2, eq2 = cnstr ctx (Eval(Id(e1), tl)) in
			    TFloat, (ty1,TFloat) :: (ty2,TFloat) :: eq1 @ eq2  
	)
	| "__equal"
	| "__neq"
	| "__less"
	| "__leq"
	| "__greater"
	| "__geq" -> 
		let ty1, eq1 = cnstr ctx (List.hd e2) in
		let ty2, eq2 = cnstr ctx (List.hd(List.tl e2)) in
		  TBool, (ty1, ty2) :: eq1 @ eq2
	| "__and"
	| "__or"
	| "not" -> ( match e2 with
		| [] -> TBool, []
		| hd::tl -> let ty1, eq1 = cnstr ctx hd in
			    let ty2, eq2 = cnstr ctx (Eval(Id(e1), tl)) in
			    TBool, (ty1,TBool) :: (ty2,TBool) :: eq1 @ eq2  
	)
	| "__concat" -> ( match e2 with
		| [] -> TString, []
		| hd::tl -> let ty1, eq1 = cnstr ctx hd in
			    let ty2, eq2 = cnstr ctx (Eval(Id(e1), tl)) in
			    TString, (ty1,TString) :: (ty2,TString) :: eq1 @ eq2
	)  
	| "cons" -> (
		if List.length e2 <> 2 then (invalid_args_error("Invalid arguments error: " ^ "cons takes 2 arguments. "))
		else (
			let newhd = List.hd e2
			and thelist = List.hd (List.rev e2) 
			in
			let ty1, eq1 = cnstr ctx newhd in	(* ty1 can be anything *)
			let ty2, eq2 = cnstr ctx thelist in
			TSomeList(TSome), (ty2,TSomeList(TSome)) :: eq1 @ eq2
		)	
	)
	| "pr" 
	| "prn" -> ( 
		let rec addcnstr = function
		| [] -> []
		| hd::tl -> let ty1, eq1 = cnstr ctx hd in
			    (ty1,TString) :: eq1 @ addcnstr tl
		in TUnit, addcnstr e2
		)

	| "int_of_string"
	| "string_of_float"
	| "float_of_string"
	| "string_of_boolean"
	| "boolean_of_string"
	| "string_of_int" -> (
		if List.length e2 <> 1 then (invalid_args_error("Invalid arguments error: " ^ 
								e1 ^ " takes 1 argument. "))
		else (
			let arg = List.hd e2 in
			let ty, eq = cnstr ctx arg in
			match e1 with
				| "int_of_string" -> TInt, (ty, TString) :: eq
				| "string_of_float" -> TString, (ty, TFloat) :: eq
				| "float_of_string" -> TFloat, (ty, TString) :: eq
				| "string_of_boolean" -> TString, (ty, TBool) :: eq
				| "boolean_of_string" -> TBool, (ty, TString) :: eq
				| "string_of_int" -> TString, (ty, TInt) :: eq
		)
	)
	| "head" ->
	   (
		if List.length e2 <> 1 then 
			(invalid_args_error("Invalid arguments error: head takes one list as argument. ")) 
		else (
			let thelist = (List.hd e2) in
			  let ty, eq = cnstr ctx thelist in
				TSome, (ty, TSomeList(TSome)) :: eq
		)
	   )
	| "tail" -> 
		if List.length e2 <> 1 then
			(invalid_args_error("Invalid arguments error: tail takes one list as argument. "))
		else (
			let thelist = (List.hd e2) in
			let ty, eq = cnstr ctx thelist in
			TSomeList(TSome), (ty, TSomeList(TSome)) :: eq
		)
	| "type" -> if List.length e2 <> 1 then
			(invalid_args_error("Invalid arguments error: type takes one argument. "))
		else (
			let x = (List.hd e2) in
			let ty, eq = cnstr ctx x in
			TString, eq
		)
	| "int"
	| "float"
	| "boolean"
	| "string"
	| "list" ->
	  ( 
		if List.length e2 <> 1 then
			(invalid_args_error("Invalid arguments error: int takes 1 atom as argument." ))
		else (
			let x = List.hd e2 in
			let ty1, eq1 = cnstr ctx x in
			match e1 with
			  | "int" -> TInt, eq1
			  | "float" -> TFloat, eq1
			  | "boolean" -> TBool, eq1
			  | "string" -> TString, eq1
			  | "list" -> TSomeList(TSome), eq1
		)	
	  )
	(* User-defined functions *)
	| _ -> TInt, [] (*let e = Id(e1) in let ty1, eq1 = (cnstr ctx e) in
				 let ty = fresh () in 
				ty, (ty1, TArrow(e2,ty)) :: eq1
  *)  )
  in
    cnstr []

(** [type_of ctx e] computes the principal type of expression [e] in
    context [ctx]. *)
let type_of ctx e =
  let ty, eq = constraints_of ctx e in
    let ans = solve eq in
	    let rec printType = function
                  | TInt -> "TInt"
		  | TBool -> "TBool"
		  | TParam k -> "TypeVar" ^ (string_of_int k)
		  | TSome -> "SomeType"
		  | TSomeList _ -> "List of sometype"
		  | TArrow(c, d) -> (printType c) ^ "->" ^ (printType d)
		in let printpairs p = 
		  print_int(fst p); print_endline(printType (snd p))
	in ignore(List.iter (printpairs) ans);
    tsubst (ans) ty
