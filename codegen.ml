module L = Llvm
module A = Ast

module StringMap = Map.Make(String)

let translate (vardecls, funcdecls, entdecls, gboard, rules) =
	let context = L.global_context () in
  	let the_module = L.create_module context "Ballr"
  	and i32_t  = L.i32_type  context
  	and i8_t   = L.i8_type   context
  	and i1_t   = L.i1_type   context 
  	and flt_t = L.float_type context
  	and PTR = L.pointer_type 
  	and clr_t = L.struct_type context [|i32_t; i32_t; i32_t|]
	and vec_t = L.struct_type context [|i32_t; i32_t|]
	and ent_t = L.struct_type context [|  PTR i8_t; vec_t; vec_t; clr_t |]
	and gb_t = L.struct_type [|PTR i8_t; vec_t; clr_t; PTR ent_t;|] in

	let ltype_of_typ = function
      A.Int -> i32_t
    | A.Bool -> i1_t
    | A.Float -> flt_t
    | A.Vec -> vec_t
    | A.Color -> clr_t

(* Global Variables To Come *)
  (*   let global_vars =
    let global_var m (t, n, v) = 
      let init = L.const_int (ltype_of_typ t) 0
      in StringMap.add n (L.define_global n init the_module) m in
    List.fold_left global_var StringMap.empty vardecls in *)


(* gb_init and run_loop declared *)
  let gb_init_t = L.function_type L.void_type [| PTR gb_t; PTR i8_t; vec_t; clr_t|] in
  let gb_init_func = L.declare_function "gb_init" gb_init_t the_module in

  let run_loop_t = L.function_type i32_t [| |] in
  let run_loop_t_func = L.declare_function "run_loop" run_loop_t the_module in


(* this populates a StringMap with a L.function_type which bas *)
let function_decls =
    let function_decl m fdecl =
      let name = fdecl.A.fname
      and formal_types =
	Array.of_list (List.map (fun (t,_) -> ltype_of_typ t) fdecl.A.formals)
      in let ftype = L.function_type (ltype_of_typ fdecl.A.typ) formal_types in
      StringMap.add name (L.define_function name ftype the_module, fdecl) m in
    List.fold_left function_decl StringMap.empty funcdecls in


let build_function_body fdecl =
    let (the_function, _) = StringMap.find fdecl.A.fname function_decls in
    let builder = L.builder_at_end context (L.entry_block the_function) in

    let int_format_str = L.build_global_stringptr "%d\n" "fmt" builder in
    
    (* Construct the function's "locals": formal arguments and locally
       declared variables.  Allocate each on the stack, initialize their
       value, if appropriate, and remember their values in the "locals" map *)
    let local_vars =
      let add_formal m (t, n) p = L.set_value_name n p;
	let local = L.build_alloca (ltype_of_typ t) n builder in
	ignore (L.build_store p local builder);
	StringMap.add n local m in

      let add_local m (t, n) =
	let local_var = L.build_alloca (ltype_of_typ t) n builder
	in StringMap.add n local_var m in

      let formals = List.fold_left2 add_formal StringMap.empty fdecl.A.formals
          (Array.to_list (L.params the_function)) in
      List.fold_left add_local formals fdecl.A.locals in

    (* Return the value for a variable or formal argument *)
    let lookup n = try StringMap.find n local_vars
				   (* NO GLOBALS FOR NOW  *)
                   (* with Not_found -> StringMap.find n global_vars *)
    in


    (* Construct code for an expression; return its value *)
    let rec expr builder = function
	A.Literal i -> L.const_int i32_t i
	  | A.FLiteral i -> L.const_float flt_t i
      | A.BoolLit b -> L.const_int i1_t (if b then 1 else 0)
      (* DO WE USE THIS??? *)
      | A.Noexpr -> L.const_int i32_t 0
      | A.Id s -> L.build_load (lookup s) s builder
      | A.Clr (r,g,b) -> 
      		let r' = expr builder r
      		and g' = expr builder g
      		and b' = expr builder b in 
      		(* @Freddie is this right *)
      		r' g' b' "tmp" builder 
      | A.Vec (x,y) -> 
      		let x' = expr builder x
      		and y' = expr builder y in 
      		(* @Freddie is this right *)
      		x' y' "tmp" builder 

      | A.Binop (e1, op, e2) ->
	  let e1' = expr builder e1
	  and e2' = expr builder e2 in
	  (match op with
	    A.Add     -> L.build_add
	  | A.Sub     -> L.build_sub
	  | A.Mult    -> L.build_mul
      | A.Div     -> L.build_sdiv
      | A.Mod 	  -> L.build_urem
	  | A.And     -> L.build_and
	  | A.Or      -> L.build_or
	  | A.Equal   -> L.build_icmp L.Icmp.Eq
	  | A.Neq     -> L.build_icmp L.Icmp.Ne
	  | A.Less    -> L.build_icmp L.Icmp.Slt
	  | A.Leq     -> L.build_icmp L.Icmp.Sle
	  | A.Greater -> L.build_icmp L.Icmp.Sgt
	  | A.Geq     -> L.build_icmp L.Icmp.Sge
	  (* | A.Coll 	  -> ?? *)
	  ) e1' e2' "tmp" builder

      | A.Unop(op, e) ->
	  let e' = expr builder e in
	     (match op with
	   	    A.Neg     -> L.build_neg
          | A.Not     -> L.build_not
      	  ) e' "tmp" builder



(* will somehow need to fix for x.pos = blah, will this work for now? *)
      | A.Assign (s, e) -> let e' = expr builder e in
	                   ignore (L.build_store e' (lookup s) builder); e'

	  (* | A.Access (s1,s2) -> 
	  | A.ArrayAccess (e1,e2) -> *)

(* HIGHLY LIKELY THIS IS WRONG *)
      | A.Call ("gb_init", [e]) ->
	  L.build_call gb_init_func [| (expr builder e) |] "gb_init" builder
      
      | A.Call ("run_loop", [e]) ->
	  L.build_call gb_init_func [| (expr builder e) |] "run_loop" builder

      | A.Call (f, act) ->
         let (fdef, fdecl) = StringMap.find f function_decls in
	 let actuals = List.rev (List.map (expr builder) (List.rev act)) in
	 let result = f ^ "_result") in
         L.build_call fdef (Array.of_list actuals) result builder
    in

  (* Invoke "f builder" if the current block doesn't already
       have a terminal (e.g., a branch). *)
    let add_terminal builder f =
      match L.block_terminator (L.insertion_block builder) with
	Some _ -> ()
      | None -> ignore (f builder) in
	
    (* Build the code for the given statement; return the builder for
       the statement's successor *)
    let rec stmt builder = function
	A.Block sl -> List.fold_left stmt builder sl
      | A.Expr e -> ignore (expr builder e); builder
      | A.Return e -> ignore (L.build_ret (expr builder e) builder); builder
      | A.If (predicate, then_stmt, else_stmt) ->
         let bool_val = expr builder predicate in
	 let merge_bb = L.append_block context "merge" the_function in

	 let then_bb = L.append_block context "then" the_function in
	 add_terminal (stmt (L.builder_at_end context then_bb) then_stmt)
	   (L.build_br merge_bb);

	 let else_bb = L.append_block context "else" the_function in
	 add_terminal (stmt (L.builder_at_end context else_bb) else_stmt)
	   (L.build_br merge_bb);

	 ignore (L.build_cond_br bool_val then_bb else_bb builder);
	 L.builder_at_end context merge_bb

      | A.While (predicate, body) ->
	  let pred_bb = L.append_block context "while" the_function in
	  ignore (L.build_br pred_bb builder);

	  let body_bb = L.append_block context "while_body" the_function in
	  add_terminal (stmt (L.builder_at_end context body_bb) body)
	    (L.build_br pred_bb);

	  let pred_builder = L.builder_at_end context pred_bb in
	  let bool_val = expr pred_builder predicate in

	  let merge_bb = L.append_block context "merge" the_function in
	  ignore (L.build_cond_br bool_val body_bb merge_bb pred_builder);
	  L.builder_at_end context merge_bb

    in

    (* Build the code for each statement in the function *)
    let builder = stmt builder (A.Block fdecl.A.body) in

    (* by commenting out, makes them have to have trailing return? *)
    (* Add a return if the last block falls off the end *)
   (*  add_terminal builder (match fdecl.A.typ with
        A.Void -> L.build_ret_void
      | t -> L.build_ret (L.const_int (ltype_of_typ t) 0))
  in *)

  List.iter build_function_body funcdecls;

  let 



  the_module



