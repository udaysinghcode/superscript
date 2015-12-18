(* Type inference *)

open Ast;;

exception Type_error of string
exception Invalid_args of string
exception Unknown_variable of string * string

(** [type_error msg] reports a type error by raising [Type_error msg]. *)
let type_error msg = raise (Type_error msg)
(** [invalid_args_error msg] reports invalid argument exceptions by raising [Invalid_args msg]. *)
let invalid_args_error msg = raise(Invalid_args msg)
(** [unknown_var_error msg] reports unknown variable exceptions by raising [Unknown_variable msg]. *)
let unknown_var_error msg var = raise(Unknown_variable (msg, var))

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
    | TArrow t_list ->
    	let rec tarrow_refresh ts us s' = 
    		match ts with
    		| [] -> us, s'
    		| hd::tl -> let u,s'' = refresh s' hd in
    					tarrow_refresh tl (us@[u]) s'' in
    	let u_list, s = tarrow_refresh t_list [] s in
    	TArrow u_list, s
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
  | TArrow t_list -> 
  		let rec tarrow_occurs ts o =
  			match ts with
  			| [] -> o
  			| hd::tl -> (tarrow_occurs tl (o||occurs k hd)) in
  		tarrow_occurs t_list false
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
	      
      | (TArrow ty1, TArrow ty2) :: eq when (List.length ty1) = (List.length ty2) ->
      	let rec get_eq l1 l2 eq = 
      		match l1 with 
      		| [] -> eq
      		| hd::tl -> get_eq tl (List.tl l2) ((hd, (List.hd) l2)::eq) in 
      	solve (get_eq ty1 ty2 []) sbst
	    
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
    | Id x -> ( 
	(try
	   List.assoc x ctx, []
	 with Not_found ->
	   (try
	      (* we call [refresh] here to get let-polymorphism *)
	      refresh (List.assoc x gctx), []
	    with Not_found -> 
			unknown_var_error ("Unknown variable " ^ x) x)
	)
    )
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

    | Fdecl(x, e) ->
    	let eqs = List.rev (List.map (fun v -> (v, fresh ())) x)in
    	let ty1, eq = cnstr (eqs@ctx) e in
    	(match eqs with 
    		|[] -> TArrow [TUnit;ty1], eq
    		| _ -> let func_types = List.map (fun (a,b) -> b) eqs in
    					TArrow (func_types@[ty1]), eq
    	)

    | Assign(e) -> (* all ids/types were already added to ctx in the executor. just return the type of the last assignment *)
	let last = List.hd (List.rev e) in
	let ty, eq = cnstr ctx last in
	ty, eq
    | Eval(e1, e2) -> (
       match e1 with
       | Let(a,b,c) -> TUnit, [] 
       | If(a,b,c) -> TUnit, []
       | Fdecl(a,b) -> (
       		let ty1, eq1 = cnstr ctx e1 in
       		let ty2 = fresh () in
			match e2 with 
			| [] -> ty2, (ty1, TArrow [TUnit; ty2])::eq1
			| _ -> let tys = List.map (fun v -> let (ty,eq) = cnstr ctx v in ty) (List.rev e2) in
					let rec get_eqs exp_list eq_list = (
						match exp_list with
						| [] -> eq_list
						| hd::tl -> let (ty, eq) = cnstr ctx hd in 
							get_eqs tl (eq_list@eq)
					) in
					ty2, (ty1, TArrow (tys@[ty2]))::eq1@(get_eqs e2 [])
		)

       | Id(e1) -> 
       ( 
	    match e1 with

 	    | "__add" | "__sub" | "__mult"| "__div" | "mod"
	    | "__addf" | "__subf" | "__multf" | "__divf" 
	    | "__and" | "__or" | "__not" 
	    | "__concat" -> 
		
		let numargs = List.length e2 in
		if numargs != 2 && (String.compare e1 "mod")==0 then (ignore(print_int (List.length e2));
						 (invalid_args_error("Invalid arguments error: " ^
							      "mod takes 2 ints as arguments. ")))
		else(

  		  if numargs != 1 && (String.compare e1 "__not")==0 then (ignore(print_int (List.length e2));
						(invalid_args_error("Invalid arguments error: " ^
							"not takes 1 boolean expression as argument. ")))
		  else (
		     let tarrow = Generator.arrow_of(e1) in
		     match tarrow with
		     | TArrow(x) -> (let a = List.hd x in
				let b = List.hd (List.tl x) in
				let c = List.hd (List.rev x) in

			match e2 with
			| [] -> c, []
			| hd::tl -> let ty1, eq1 = cnstr ctx hd in
			    let ty2, eq2 = cnstr ctx (Eval(Id(e1), tl)) in
			    c, (ty1,a) :: (ty2,b) :: eq1 @ eq2)
		     | _ -> raise(Failure "Error: Generation of typing for built-in function failed. ")
		  )
		) 

	    | "__equal" | "__neq" | "__less" | "__leq" 
	    | "__greater" | "__geq" -> 
		let ty1, eq1 = cnstr ctx (List.hd e2) in
		let ty2, eq2 = cnstr ctx (List.hd(List.tl e2)) in
		  TBool, (ty1, ty2) :: eq1 @ eq2

      	    | "cons" -> (
		if List.length e2 <> 2 then (invalid_args_error("Invalid arguments error: " ^ "cons takes 2 arguments. "))
		else (
			let newhd = List.hd e2
			and thelist = List.hd (List.rev e2) in
				let ty1, eq1 = cnstr ctx newhd in	(* ty1 can be anything *)
				let ty2, eq2 = cnstr ctx thelist in
					TSomeList(TSome), (ty2,TSomeList(TSome)) :: eq1 @ eq2
		)	
	    )

	    (* check that every arg to print is of type TString, and every arg to exec is TSomeList(TSome) *)
	    | "pr" | "prn" | "exec" -> ( 
		let tarrow = Generator.arrow_of e1 in
			match tarrow with
			| TArrow(x) -> let a = List.hd(x) in
					let b = List.hd(List.tl x) in
				let rec addcnstr = function
				    | [] -> []
				    | hd::tl -> let ty1, eq1 = cnstr ctx hd in
			    		(ty1,a) :: eq1 @ addcnstr tl
		    		in b, addcnstr e2
			| _ -> raise(Failure "Error: Generation of typing for built-in function failed. ")
	    )
	 
	    | "int_of_string"
	    | "string_of_float"
	    | "float_of_string"
	    | "string_of_boolean"
	    | "boolean_of_string"
	    | "string_of_int" -> 
	    (
		if List.length e2 <> 1 then (invalid_args_error("Invalid arguments error: " ^ 
								e1 ^ " takes 1 argument. "))
		else (
			let arg = List.hd e2 in
			let ty, eq = cnstr ctx arg in
			let tarrow = (Generator.arrow_of e1) in
				match tarrow with
				  | TArrow(x) -> (let a = List.hd(x) in
					let b = List.hd(List.tl x) in
					b, (ty, a) :: eq)
				  | _ -> raise(Failure "Error: Generation of typing for built-in function failed. ")
		)
	    )

	    | "tail"
	    | "head"
	    | "evaluate" ->
		if List.length e2 <> 1 then (  
			let fname =  
					if (String.compare e1 "evaluate") == 0 then "eval"
					else e1
				in
				invalid_args_error("Invalid arguments error: " ^ fname ^ " takes 1 list as argument. ")) 
		else (
			let thelist = (List.hd e2) in
			  let ty, eq = cnstr ctx thelist in
			    let tarrow = (Generator.arrow_of e1) in
				match tarrow with
				| TArrow(x) -> (let a = List.hd(x) in
						let b = List.hd(List.tl x) in
						b, (ty, a) :: eq)
				| _ -> raise(Failure "Error: Generation of typing for built-in function failed. ")
		)

	    | "int" | "float" | "boolean" | "string" | "list"
	    | "type" ->
	    ( 
		if List.length e2 <> 1 then
			(invalid_args_error("Invalid arguments error: " ^ e1 ^ " takes 1 argument." ))
		else (
			let x = List.hd e2 in
			let ty1, eq1 = cnstr ctx x in
			let tarrow = (Generator.arrow_of e1) in
				match tarrow with
			 		| TArrow(x) -> List.hd(List.rev x), eq1
					| _ -> raise(Failure "Error: Generation of typing for built-in function failed. ")
		)
	    ) 
	    | _ -> ( let ty1, eq1 = cnstr ctx (Id e1) in
			let ty2 = fresh () in
			match e2 with 
			| [] -> ty2, (ty1, TArrow [TUnit; ty2])::eq1
			| _ -> let tys = List.map (fun v -> let (ty,eq) = cnstr ctx v in ty) (List.rev e2) in
					let rec get_eqs exp_list eq_list = (
						match exp_list with
						| [] -> eq_list
						| hd::tl -> let (ty, eq) = cnstr ctx hd in 
							get_eqs tl (eq_list@eq)
					) in
					ty2, (ty1, TArrow (tys@[ty2]))::eq1@(get_eqs e2 [])
	           )
        ) (* end pattern matching for Id *)

	| _ -> raise(Failure "Error: The first element of an unquoted list must either be a function identifier or an S-expression. ")

    ) (* end pattern matching for Eval *)
      in
        cnstr []

(** [type_of ctx e] computes the principal type of expression [e] in
    context [ctx]. *)
let type_of ctx e =
  let ty, eq = constraints_of ctx e in
    let ans = solve eq in
    tsubst (ans) ty
