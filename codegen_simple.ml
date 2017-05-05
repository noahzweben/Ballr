module L = Llvm
module A = Ast

module StringMap = Map.Make(String)

exception Blr_err of string;;

let print_map m =
  print_string ("Map:\n");
  let print_key k v =
    print_string (k ^ "\n")
  in
  StringMap.iter print_key m;;

let translate (vardecls, fdecls, ents, gboard) =
  let context = L.global_context () in
  let the_module = L.create_module context "Ballr" in
  let i64_t  = L.i64_type  context in
  let i32_t  = L.i32_type  context in
  let i8_t   = L.i8_type   context in 
  let i1_t   = L.i1_type   context in
  let flt_t = L.float_type context in
  let ut_hash_handle_t = L.named_struct_type context "UT_hash_handle" in 
  let ut_hash_table_t = L.named_struct_type context "UT_hash_table" in
  let ut_hash_bucket_t = L.named_struct_type context "UT_hash_bucket" in
    L.struct_set_body ut_hash_handle_t [|L.pointer_type ut_hash_table_t; L.pointer_type i8_t; L.pointer_type i8_t; L.pointer_type ut_hash_handle_t; L.pointer_type ut_hash_handle_t; L.pointer_type i8_t; i32_t; i32_t|] false; 
    L.struct_set_body ut_hash_table_t  [|L.pointer_type ut_hash_bucket_t; i32_t; i32_t; i32_t; L.pointer_type ut_hash_handle_t; i64_t; i32_t; i32_t; i32_t; i32_t; i32_t|] false;
    L.struct_set_body ut_hash_bucket_t [|L.pointer_type ut_hash_handle_t; i32_t; i32_t|] false;
  let clr_t = L.named_struct_type context "blr_color_t" in
    L.struct_set_body clr_t [|i32_t; i32_t; i32_t|] false;
  let vec_t = L.named_struct_type context "blr_size_t" in
    L.struct_set_body vec_t [|i32_t; i32_t|] false;
  let ent_t = L.named_struct_type context "blr_entity_t" in
    L.struct_set_body ent_t [|  L.pointer_type i8_t; vec_t; vec_t; clr_t; L.pointer_type (L.function_type (L.void_type context) [| L.pointer_type ent_t |]); L.pointer_type i8_t; L.pointer_type ent_t; ut_hash_handle_t |] false;
  let gb_t = L.named_struct_type context "blr_gameboard_t" in
    L.struct_set_body gb_t [| L.pointer_type i8_t; vec_t; clr_t; L.pointer_type ent_t; L.pointer_type (L.function_type (L.void_type context) [| L.pointer_type gb_t |]);  ut_hash_handle_t |] false;

  let ltype_of_typ = function
      A.Int -> i32_t
    | A.Bool -> i1_t
    | A.Float -> flt_t
    | A.Color -> clr_t  
    | A.Vector -> vec_t
  in

  let keycode_of_keyname name =
    if name = "key_UP" then 82 else
    if name = "key_DOWN" then 81 else
    if name = "key_LEFT" then 80 else
    if name = "key_RIGHT" then 79 else
    if name = "key_SPACE" then 44 else
    if name = "key_A" then 4 else
    if name = "key_D" then 7 else
    if name = "key_S" then 22 else
    if name = "key_W" then 26 else
    0
  in

  let printf_t = L.var_arg_function_type i32_t [| L.pointer_type i8_t |] in 
  let printf_func = L.declare_function "printf" printf_t the_module in

  let run_loop_t = L.function_type i32_t [| |] in
  let run_loop_func = L.declare_function "run_loop" run_loop_t the_module in

  let register_gb_t = L.function_type (L.void_type context) [| (L.pointer_type gb_t) |] in
  let register_gb_func = L.declare_function "register_gb" register_gb_t the_module in

  let add_fn_t = L.function_type (L.void_type context) [| (L.pointer_type ent_t) |] in
  let add_fn = L.declare_function "ent_add" add_fn_t the_module in

  let remove_fn_t = L.function_type (L.void_type context) [| (L.pointer_type ent_t) |] in
  let remove_fn = L.declare_function "ent_remove" remove_fn_t the_module in

  let restart_fn_t = L.function_type (L.void_type context) [| |] in
  let restart_fn = L.declare_function "restart" restart_fn_t the_module in

  let chk_kp_t = L.function_type i32_t [| i32_t |] in
  let chk_kp_fn = L.declare_function "chk_keypress" chk_kp_t the_module in

  let coll_callback_t = L.function_type (L.void_type context) [| L.pointer_type ent_t |] in
  let chk_coll_t = L.function_type (L.void_type context) [| L.pointer_type ent_t; L.pointer_type i8_t; L.pointer_type coll_callback_t |] in
  let chk_coll_fn = L.declare_function "chk_collision" chk_coll_t the_module in

  let get_decl name decls =
    match List.filter (fun (A.VarInit (t, s, e)) -> s = name) decls with
      | A.VarInit (t, s, e) :: tl -> e
      | [] -> A.Noexpr in

  let clr_lit = function
    | A.Clr (A.Literal r, A.Literal g, A.Literal b) -> Some([|L.const_int i32_t r; L.const_int i32_t g; L.const_int i32_t b|])
    | _ -> None in

  let vec_lit = function
    | A.Vec (A.Literal v1, A.Literal v2) -> Some([|L.const_int i32_t v1; L.const_int i32_t v2|])
    | _ -> None in 

  let int_format_str builder = L.build_global_stringptr "%d\n" "fmt" builder in (* format string for printf calls *)

  let add_terminal builder f =
    match L.block_terminator (L.insertion_block builder) with
      Some _ -> ()
      | None -> ignore (f builder) in

  let ensureInt c = 
    if L.type_of c = flt_t then (L.const_fptosi c i32_t) else c in

  (* BUILD EXPRESSIONS *)
  let rec expr builder m mem_m ent = function
      A.Literal i -> L.const_int i32_t i
    | A.FLiteral f -> L.const_float flt_t f
    | A.BoolLit b -> L.const_int i1_t (if b then 1 else 0)
    | A.Noexpr  -> L.const_int i32_t 0
    | A.Id s    -> L.build_load (StringMap.find s m) s builder 

    | A.Call ("print", [e]) | A.Call ("printb", [e]) ->
      L.build_call printf_func 
        [| int_format_str builder ; (expr builder m mem_m ent e) |]
        "printf" builder (* build_call fn args name b creates %name = call %fn(args...) *)

    | A.Call ("add", [e1; e2]) ->
      let e2' = expr builder m mem_m ent e2 in
      (match e1 with
        A.Id (name) ->
          let creat_fn = StringMap.find (name ^ "_create") m in
          let ent_ptr = L.build_call creat_fn [| |] name builder in
          let pos_ptr = L.build_struct_gep ent_ptr 2 "pos" builder in
          ignore (L.build_store e2' pos_ptr builder);
          ignore (L.build_call add_fn [| ent_ptr |] "" builder);
          L.const_int i32_t 0
        | _ -> raise (Blr_err "expected identifier"))

    | A.Call ("remove", []) -> 
          let (ent_ptr, _, _) = StringMap.find ent mem_m in 
          L.build_call remove_fn [| ent_ptr |] "" builder
    | A.Call ("restart", []) ->
          L.build_call restart_fn [||] "" builder
    | A.Call (name, args) ->
      let func = StringMap.find name m in
      let arg_arr = Array.of_list (List.map (expr builder m mem_m ent) args) in
      L.build_call func arg_arr name builder

    | A.Binop (e1, op, e2) ->
      let e1' = expr builder m mem_m ent e1
      and e2' = expr builder m mem_m ent e2 in
      (match op with
        A.Add     -> L.build_add
      | A.Sub     -> L.build_sub
      | A.Mult    -> L.build_mul
      | A.Mod     -> L.build_srem
      | A.Div     -> L.build_sdiv
      | A.And     -> L.build_and
      | A.Or      -> L.build_or
      | A.Equal   -> L.build_icmp L.Icmp.Eq
      | A.Neq     -> L.build_icmp L.Icmp.Ne
      | A.Less    -> L.build_icmp L.Icmp.Slt
      | A.Leq     -> L.build_icmp L.Icmp.Sle
      | A.Greater -> L.build_icmp L.Icmp.Sgt
      | A.Geq     -> L.build_icmp L.Icmp.Sge
      ) e1' e2' "tmp" builder 
    
    | A.Unop(op, e) ->
      let e' = expr builder m mem_m ent e in
      (match op with
          A.Neg     -> L.build_neg
        | A.Not     -> L.build_not) e' "tmp" builder

    | A.Clr (e1, e2, e3) as clr -> 
      (match (clr_lit clr) with
        Some(vals) -> L.const_named_struct clr_t vals
        | None ->
	  let e1' = ensureInt (expr builder m mem_m ent e1)
	  and e2' = ensureInt (expr builder m mem_m ent e2)
    and e3' = ensureInt (expr builder m mem_m ent e3) in
          let clr_ptr = L.build_alloca clr_t "tmp" builder in
  	  let r_ptr = L.build_struct_gep clr_ptr 0 "r" builder in
  	  ignore (L.build_store e1' r_ptr builder);
          let g_ptr = L.build_struct_gep clr_ptr 1 "g" builder in
	  ignore (L.build_store e2' g_ptr builder);
          let b_ptr = L.build_struct_gep clr_ptr 2 "b" builder in
          ignore (L.build_store e3' b_ptr builder);
	  L.build_load clr_ptr "c" builder)

    | A.Vec (e1, e2) as vec -> 
      (match (vec_lit vec) with
        Some(vals) -> L.const_named_struct vec_t vals
        | None ->
          let e1' = ensureInt (expr builder m mem_m ent e1)
          and e2' = ensureInt (expr builder m mem_m ent e2) in
          let vec_ptr = L.build_alloca vec_t "tmp" builder in
          let x_ptr = L.build_struct_gep vec_ptr 0 "x" builder in
          ignore (L.build_store e1' x_ptr builder);
          let y_ptr = L.build_struct_gep vec_ptr 1 "y" builder in
          ignore (L.build_store e2' y_ptr builder);
          L.build_load vec_ptr "v" builder)

    | A.Assign (e1, e2) -> 
      let e' = expr builder m mem_m ent e2 in
      (match e1 with
        | A.Id (s) -> L.build_store e' (StringMap.find s m) builder
        | A.Access (s1, s2) -> 
          (match s1 with 
            | "self" -> 
              (match s2 with 
                | "size" -> let (ent_ptr, _, _) = StringMap.find ent mem_m in 
                            let size_ptr = L.build_struct_gep ent_ptr 1 ("ent_size_ptr") builder in  
                            L.build_store e' size_ptr builder;
                | "clr" -> let (ent_ptr, _, _) = StringMap.find ent mem_m in 
                            let clr_ptr = L.build_struct_gep ent_ptr 3 ("ent_clr_ptr") builder in  
                            L.build_store e' clr_ptr builder;
                | "pos" -> let (ent_ptr, _, _) = StringMap.find ent mem_m in 
                            let pos_ptr = L.build_struct_gep ent_ptr 2 ("ent_pos_ptr") builder in  
                            L.build_store e' pos_ptr builder;
                |_ -> let (ent_mem_ptr, index, m_t) = StringMap.find s2 mem_m in
                        let mem_struct_ptr = L.build_load ent_mem_ptr "mem_struct_ptr" builder in
                        let mem_struct_ptr = L.build_pointercast mem_struct_ptr (L.pointer_type m_t) "cast_ptr" builder in 
                        let mem_ptr = L.build_struct_gep mem_struct_ptr index (s2 ^ "_ptr") builder in  
                        L.build_store e' mem_ptr builder;
              )
            | _ -> L.const_int i32_t 0       
          )
 
        | A.ArrayAccess (e1', e2') ->      
          let arr_ptr = 
          (match e1' with 
            | A.Access (s1, s2) -> 
              (match s1 with 
                | "self" -> 
                  ( match s2 with 
                    | "size" -> let (ent_ptr, _, _) = StringMap.find ent mem_m in 
                                L.build_struct_gep ent_ptr 1 ("ent_size_ptr") builder   
                    | "clr" -> let (ent_ptr, _, _) = StringMap.find ent mem_m in 
                                L.build_struct_gep ent_ptr 3 ("ent_clr_ptr") builder   
                    | "pos" -> let (ent_ptr, _, _) = StringMap.find ent mem_m in 
                                L.build_struct_gep ent_ptr 2 ("ent_pos_ptr") builder   
                    |_ -> let (ent_mem_ptr, index, m_t) = StringMap.find s2 mem_m in
                          let mem_struct_ptr = L.build_load ent_mem_ptr "mem_struct_ptr" builder in
                          let mem_struct_ptr = L.build_pointercast mem_struct_ptr (L.pointer_type m_t) "cast_ptr" builder in 
                          L.build_struct_gep mem_struct_ptr index (s2 ^ "_ptr") builder
                  )
                  
                | _ -> L.const_int i32_t 0 
              ) 
            | A.Id (s) -> L.build_gep (StringMap.find s m) [|L.const_int i32_t 0|] s builder
            | _ -> L.const_int i32_t 0
          ) 

          in

          let index = 
            ( match e2' with 
            | A.Literal i -> i 
            | _ -> 0
            )
          in

          let el_accessed = L.build_struct_gep arr_ptr index ("el_"^string_of_int index) builder in  
          L.build_store e' el_accessed builder;

        | _ -> L.const_int i32_t 0
      )
    
    | A.Access (s1, s2) ->
    (match s1 with 
      | "self" -> 
        (match s2 with 
          | "size" -> let (ent_ptr, _, _) = StringMap.find ent mem_m in 
                      let size_ptr = L.build_struct_gep ent_ptr 1 ("ent_size_ptr") builder in  
                      L.build_load size_ptr s2 builder;
          | "clr" -> let (ent_ptr, _, _) = StringMap.find ent mem_m in 
                      let clr_ptr = L.build_struct_gep ent_ptr 3 ("ent_clr_ptr") builder in  
                      L.build_load clr_ptr s2 builder;
          | "pos" -> let (ent_ptr, _, _) = StringMap.find ent mem_m in 
                      let pos_ptr = L.build_struct_gep ent_ptr 2 ("ent_pos_ptr") builder in  
                      L.build_load pos_ptr s2 builder;
          |_ -> let (ent_mem_ptr, index, m_t) = StringMap.find s2 mem_m in
                  let mem_struct_ptr = L.build_load ent_mem_ptr "mem_struct_ptr" builder in
                  let mem_struct_ptr = L.build_pointercast mem_struct_ptr (L.pointer_type m_t) "cast_ptr" builder in 
                  let mem_ptr = L.build_struct_gep mem_struct_ptr index (s2 ^ "_ptr") builder in  
                  L.build_load mem_ptr s2 builder;
        )
      | _ -> L.const_int i32_t 0 
    ) 

    | A.ArrayAccess (e1, e2) -> 

      let arr_ptr = 
        (match e1 with 
          | A.Access (s1, s2) ->
            (match s1 with 
              | "self" -> 
                (match s2 with 
                  | "size" -> let (ent_ptr, _, _) = StringMap.find ent mem_m in 
                              L.build_struct_gep ent_ptr 1 ("ent_size_ptr") builder   
                  | "clr" -> let (ent_ptr, _, _) = StringMap.find ent mem_m in 
                              L.build_struct_gep ent_ptr 3 ("ent_clr_ptr") builder   
                  | "pos" -> let (ent_ptr, _, _) = StringMap.find ent mem_m in 
                              L.build_struct_gep ent_ptr 2 ("ent_pos_ptr") builder  
                  |_ -> let (ent_mem_ptr, index, m_t) = StringMap.find s2 mem_m in
                          let mem_struct_ptr = L.build_load ent_mem_ptr "mem_struct_ptr" builder in
                          let mem_struct_ptr = L.build_pointercast mem_struct_ptr (L.pointer_type m_t) "cast_ptr" builder in 
                          L.build_struct_gep mem_struct_ptr index (s2 ^ "_ptr") builder
                )

              | _ -> L.const_int i32_t 0 
            ) 
          | A.Id (s) -> L.build_gep (StringMap.find s m) [|L.const_int i32_t 0|] s builder 
          | _ -> L.const_int i32_t 0
        ) 

      in

      let index = 
        ( match e2 with 
        | A.Literal i -> i 
        | _ -> 0
        )
      in

      let el_accessed = L.build_struct_gep arr_ptr index ("el_"^string_of_int index) builder in  
      L.build_load el_accessed "ptr" builder;
  in

  let int_of_bool b = if b then 1 else 0 in 

  (* BUILD STATEMENTS *)
  let rec stmt builder func m mem_m ent = function
      A.Block sl -> List.fold_left (fun b s -> stmt b func m mem_m ent s) builder sl 
    | A.Expr e -> ignore (expr builder m mem_m ent e); builder
    | A.Return e -> ignore (L.build_ret (expr builder m mem_m ent e) builder); builder
                
    | A.If (predicate, then_stmt, else_stmt) ->
      let bool_val = expr builder m mem_m ent predicate in 
      let merge_bb = L.append_block context "merge" func in 
        let then_bb = L.append_block context "then" func in
        add_terminal 
          (stmt (L.builder_at_end context then_bb) func m mem_m ent then_stmt) 
          (L.build_br merge_bb); 

        let else_bb = L.append_block context "else" func in
        add_terminal 
          (stmt (L.builder_at_end context else_bb) func m mem_m ent else_stmt)
          (L.build_br merge_bb);

      ignore (L.build_cond_br bool_val then_bb else_bb builder); 
      L.builder_at_end context merge_bb

    | A.While (predicate, body) ->
      let pred_bb = L.append_block context "while" func in
      ignore (L.build_br pred_bb builder);

      let body_bb = L.append_block context "while_body" func in
      add_terminal (stmt (L.builder_at_end context body_bb) func m mem_m ent body)
          (L.build_br pred_bb);

      let pred_builder = L.builder_at_end context pred_bb in
      let bool_val = expr pred_builder m mem_m ent predicate in

      let merge_bb = L.append_block context "merge" func in
      ignore (L.build_cond_br bool_val body_bb merge_bb pred_builder);
        L.builder_at_end context merge_bb
    
  in

  let add_locals m mem_m ent decls builder = 
    let add_local m (A.VarInit(t, n, e)) =
      let e' = expr builder m mem_m ent e in
      let local_var = L.build_alloca (ltype_of_typ t) n builder in
      ignore (L.build_store e' local_var builder);
      StringMap.add n local_var m
    in
    List.fold_left add_local m decls
  in

  let rec get_init_val = function 
    A.Literal i -> L.const_int i32_t i
    | A.FLiteral f -> L.const_float flt_t f 
    | A.BoolLit b -> L.const_int i1_t (int_of_bool b)
    | A.Noexpr    -> L.const_int i32_t 0
    | A.Clr (e1, e2, e3) as clr -> 
      (match (clr_lit clr) with
        Some(vals) -> L.const_named_struct clr_t vals
        | None -> L.const_named_struct clr_t [|L.const_int i32_t 0; L.const_int i32_t 0; L.const_int i32_t 0|](* shouldnt get here if passed semant *)
      )
    | A.Vec (e1, e2) as vec -> 
      (match (vec_lit vec) with
        Some(vals) -> L.const_named_struct vec_t vals
        | None -> L.const_named_struct vec_t [|L.const_int i32_t 0; L.const_int i32_t 0|]
      ) 
    | A.Unop(op, e) ->
      let e' = get_init_val e in
      ( match op with
          A.Neg     -> (match e with 
                          A.Literal i -> L.const_neg e'
                        | A.FLiteral f -> L.const_fneg e'
                        | _ -> L.const_int i32_t 0 ) 
        | _ -> L.const_int i32_t 0 
      )
    | _ -> L.const_int i32_t 0 (* semant shouldn't let it get here *)
  in

  (* GLOBAL VAR DECLARATIONS *)
  let global_vars = 
    let global_var m (A.VarInit(t, n, e)) = 
      let initval = get_init_val e in 
      StringMap.add n (L.define_global n initval the_module) m 
    in 
    List.fold_left global_var StringMap.empty vardecls
  in 

  (* FUNCTION DECLARATIONS *)

  let func_create f m =
    let name = f.A.fname
    and formal_types = Array.of_list (List.map (fun (t,_) -> ltype_of_typ t) f.A.formals) in 
    let ftype = L.function_type (ltype_of_typ f.A.typ) formal_types in
    let func = L.define_function name ftype the_module in
    (StringMap.add name func m, func) 
  in  
  
  (* Fill in the body of the given function *)
  let fill_func_body f m =
    let (map, func) = func_create f m in
    let builder = L.builder_at_end context (L.entry_block func) in

    let map =
      let add_formal m (t, n) p = L.set_value_name n p; 
          let local = L.build_alloca (ltype_of_typ t) n builder 
          in ignore (L.build_store p local builder); 
            StringMap.add n local m 
      in List.fold_left2 add_formal map f.A.formals (Array.to_list (L.params func))
    in 
    let map = add_locals map StringMap.empty "" f.A.locals builder in
    ignore (stmt builder func map StringMap.empty "" (A.Block f.A.body)); map
  in
 
  (* ENTITY DECLARATIONS *)

  let decl_type = function A.VarInit(t,s,e) -> ltype_of_typ(t) in
  let decl_name = function A.VarInit(t,s,e) -> s in
  let decl_expr = function A.VarInit(t,s,e) -> e in

  (* make struct <ename>_mems_t for each entity *)
  let define_emembers_type e m =
    let add_mem_type a mem = 
      let name = decl_name mem in
      if name = "clr" || name = "size" then a 
      else Array.append a [|(decl_type mem)|] 
    in

    (* array of member types (not including clr, size) *)
    let mem_types = List.fold_left add_mem_type [||] e.A.members in
    (* define named struct *)
    let mems_t = L.named_struct_type context (e.A.ename ^ "_mems_t") in
    L.struct_set_body mems_t mem_types false;
    (* add to map *)
    StringMap.add e.A.ename mems_t m
  in

  (** make struct name_mems_t structs for each entity and put in a map *)
  let ent_mem_types = List.fold_left (fun m e -> define_emembers_type e m) StringMap.empty ents in

  (* build a map of accessible member names to corresponding struct gep *)
    let remove_first l = match l with
      | [] -> [] 
      | hd::rest -> rest
    in

  let ent_collision e oname m =
    let name = e.A.ename ^ "." ^ oname ^ ".collision" in
    let ftype = L.function_type (L.void_type context) [| L.pointer_type ent_t |] in
    let func = L.define_function name ftype the_module in
    (StringMap.add name func m, func)
  in

  let ent_keypress e k m =
    let name = e.A.ename ^ ".keypress" ^ k in
    let ftype = L.function_type (L.void_type context) [| L.pointer_type ent_t |] in
    let func = L.define_function name ftype the_module in
    (StringMap.add name func m, func)
  in

  let ent_frame e m =
    let name = e.A.ename ^ "_frame" in
    let ftype = L.function_type (L.void_type context) [| L.pointer_type ent_t |] in
    let func = L.define_function name ftype the_module in
    (StringMap.add name func m, func)
  in

  let event_decls = function A.Event(e,v,s) -> v in
  let event_stmts = function A.Event(e,v,s) -> s in
  let first l = match l with | hd::tl -> hd in

  let build_mem_map e sp ep =
    let mems_t = StringMap.find e.A.ename ent_mem_types in
    
    let rec index_of x l = match l with 
      | [] -> 0
      | hd :: tl -> if x = hd then 0 else 1 + index_of x tl
    in

    let add_mem map mem = 
      let index = (index_of mem e.A.members) - 2 in 
      StringMap.add (decl_name mem) (sp, index, mems_t) map;
    in

    (* members list without clr and pos *)
    let members = remove_first e.A.members in 
    let members = remove_first members in
    let map = List.fold_left add_mem StringMap.empty members in
    StringMap.add e.A.ename (ep, 0, mems_t) map

  in 

  let fill_ent_collision_func e (A.Event(A.Collision(name1, name2), v, s))  m =
    let (map, func) = ent_collision e name2 m in
    let builder = L.builder_at_end context (L.entry_block func) in
    let self_ptr = L.param func 0 in
    let mem_struct_ptr = L.build_struct_gep self_ptr 5 ("members_ptr") builder in

    let mem_map = build_mem_map e mem_struct_ptr self_ptr in

    let map = add_locals map mem_map e.A.ename v builder in
    ignore (stmt builder func map mem_map e.A.ename (A.Block s));
    ignore (L.build_ret_void builder);
    func
  in

  let fill_ent_keypress_func e (A.Event(A.KeyPress(k), v, s)) m =

    let (map, func) = ent_keypress e k m in
    let builder = L.builder_at_end context (L.entry_block func) in
    let self_ptr = L.param func 0 in
    let mem_struct_ptr = L.build_struct_gep self_ptr 5 ("members_ptr") builder in

    let mem_map = build_mem_map e mem_struct_ptr self_ptr in

    let map = add_locals map mem_map e.A.ename v builder in
    ignore (stmt builder func map mem_map e.A.ename (A.Block s));
    ignore (L.build_ret_void builder);
    func
  in
  
  let build_event e ep (A.Event(ec,v,s) as ev) m mem_map f builder = match ec with
    | A.Collision(_, s2) ->
      let func = fill_ent_collision_func e ev m in
      let str_ptr = L.build_global_stringptr s2 "namestr" builder in
      ignore (L.build_call chk_coll_fn [| ep;  str_ptr; func |] "" builder);
      builder
    | A.KeyPress(k) ->
    
      let code = keycode_of_keyname k in
      let pressed = L.build_call chk_kp_fn [| L.const_int i32_t code |] "pressed" builder in

      let true_bb = L.append_block context ("true_"^k) f in
      let false_bb = L.append_block context ("false_"^k) f in

      let func = fill_ent_keypress_func e ev m in
      let true_builder = L.builder_at_end context true_bb in
      ignore (L.build_call func [| ep |] "" true_builder);
      ignore (L.build_br false_bb true_builder);

      let pressed = L.build_icmp L.Icmp.Ne pressed (L.const_int i32_t 0) ("pressed_"^k) builder in
      ignore(L.build_cond_br pressed true_bb false_bb builder);
      
      L.builder_at_end context false_bb

    | A.Frame -> 

      let map = add_locals m mem_map e.A.ename v builder in
      stmt builder f map mem_map e.A.ename (A.Block s)

    |_  -> builder
  in 

  let fill_ent_frame_function e m =

    let (map, func) = ent_frame e m in
    let builder = L.builder_at_end context (L.entry_block func) in
    let ent_ptr = L.param func 0 in
    let mem_struct_ptr = L.build_struct_gep ent_ptr 5 ("members_ptr") builder in
    
    let mem_map = build_mem_map e mem_struct_ptr ent_ptr in
    
    let builder = List.fold_left (fun b ev -> build_event e ent_ptr ev map mem_map func b) builder e.A.rules in 

    ignore (L.build_ret_void builder);
    map
  in

  let ent_create e m =
    let name = e.A.ename ^ "_create" in
    let ftype = L.function_type (L.pointer_type ent_t) [| |] in
    let func = L.define_function name ftype the_module in
    (StringMap.add name func m, func)
  in 

  let fill_ent_mem_struct e builder = 

    let mems_t = StringMap.find e.A.ename ent_mem_types in
    let mems_struct_ptr = L.build_malloc mems_t ("ent_mems_t_ptr") builder in
  
    let build_store_mem index mem = 
        let ptr = L.build_struct_gep mems_struct_ptr index ("ptr_" ^ (string_of_int index)) builder in
        ignore (L.build_store (get_init_val (decl_expr mem))  ptr builder);
    in

    (* members list without clr and pos *)
    let members = remove_first e.A.members in let members = remove_first members in
    List.iteri build_store_mem members;

    let mems_struct_ptr = L.build_pointercast mems_struct_ptr (L.pointer_type i8_t) "new" builder in 

    mems_struct_ptr
  in

  let fill_ent_create_function m e =
    let (map, func) = ent_create e m in
    let builder = L.builder_at_end context (L.entry_block func) in
    let ent_ptr = L.build_malloc ent_t ("ent_ptr") builder in

    let name_str_ptr = L.build_global_stringptr e.A.ename (e.A.ename ^ "_name_str_ptr") builder in
    let name_ptr = L.build_struct_gep ent_ptr 0 ("name_ptr") builder in
    ignore (L.build_store name_str_ptr name_ptr builder);

    let ent_size_ptr = L.build_struct_gep ent_ptr 1 ("size_ptr") builder in
    let size_decl_expr = get_decl "size" e.A.members in
    ignore (L.build_store (expr builder map StringMap.empty e.A.ename size_decl_expr) ent_size_ptr builder);

    let ent_pos_ptr = L.build_struct_gep ent_ptr 2 ("pos_ptr") builder in
    let pos_zero = [|L.const_int i32_t 0; L.const_int i32_t 0|] in
    ignore (L.build_store (L.const_named_struct vec_t pos_zero) ent_pos_ptr builder);

    let ent_color_ptr = L.build_struct_gep ent_ptr 3 ("color_ptr") builder in
    let color_decl_expr = get_decl "clr" e.A.members in
    ignore (L.build_store (expr builder map StringMap.empty e.A.ename color_decl_expr) ent_color_ptr builder); 

    let ent_mems_t_ptr = L.build_struct_gep ent_ptr 5 ("members_ptr") builder in
    let mems_struct_ptr = fill_ent_mem_struct e builder in
    ignore (L.build_store mems_struct_ptr ent_mems_t_ptr builder); 

    let ent_frame_fn_ptr = L.build_struct_gep ent_ptr 4 ("frame_fn_ptr") builder in
    let map = fill_ent_frame_function e map in
    let frame_fn = StringMap.find (e.A.ename ^ "_frame") map in
    ignore (L.build_store frame_fn ent_frame_fn_ptr builder);

    ignore (L.build_ret ent_ptr builder); map
  in

  (* GAMEBOARD DECLARATION *)
  
  let gb_init gb m = 
    let name = gb.A.gname ^ "_init" in
    let ftype = L.function_type (L.void_type context) [| L.pointer_type gb_t |] in
    let func = L.define_function name ftype the_module in
    (StringMap.add name func m, func)
  in

  let fill_init_function gb m =
    let (map, func) = (gb_init gb m) in
    let builder = L.builder_at_end context (L.entry_block func) in
    
    let map = add_locals map StringMap.empty "" gb.A.init_mem builder in
    let builder = stmt builder func map StringMap.empty "" (A.Block gb.A.init_body) in
    ignore (L.build_ret_void builder);
    map    
  in

  let gb_create gb m = 
    let name = gb.A.gname ^ "_create" in 
    let ftype = L.function_type (L.pointer_type gb_t) [| |] in 
    let func = L.define_function name ftype the_module in
    (StringMap.add name func m, func)
  in
  
  let fill_gb_create_function gb m = 
    let map = fill_init_function gb m in
    let (map, func) =  (gb_create gb map) in
    let builder = L.builder_at_end context (L.entry_block func) in
    let gb_ptr = L.build_malloc gb_t ("board_ptr") builder in

    let name_str_ptr = L.build_global_stringptr gb.A.gname (gb.A.gname ^ "_name_str_ptr") builder in
    let name_ptr = L.build_struct_gep gb_ptr 0 ("name_ptr") builder in
    ignore (L.build_store name_str_ptr name_ptr builder);

    let gb_size_ptr = L.build_struct_gep gb_ptr 1 ("size_ptr") builder in
    let size_decl_expr = get_decl "size" gb.A.gmembers in
    ignore (L.build_store (expr builder map StringMap.empty "" size_decl_expr) gb_size_ptr builder);

    let gb_color_ptr = L.build_struct_gep gb_ptr 2 ("color_ptr") builder in
    let color_decl_expr = get_decl "clr" gb.A.gmembers in
    ignore (L.build_store (expr builder map StringMap.empty "" color_decl_expr) gb_color_ptr builder);

    let gb_init_fn_ptr = L.build_struct_gep gb_ptr 4 ("init_fn_ptr") builder in
    let init_fn = StringMap.find (gb.A.gname ^ "_init") map in
    ignore (L.build_store init_fn gb_init_fn_ptr builder);

    ignore (L.build_call register_gb_func [| gb_ptr |] "" builder);

    ignore (L.build_ret gb_ptr builder);
    map
  in

  (** make struct name_mems_t structs for each entity and put in a map *)
  let e_mem_types = List.fold_left (fun m e -> define_emembers_type e m) StringMap.empty ents in

  (* ADD FUNCTION AND ENTITY DECLARATIONS *)
  let fmap = List.fold_left (fun m f -> fill_func_body f m) global_vars fdecls in
  let fmap = List.fold_left (fun m e -> fill_ent_create_function m e) fmap ents in

  (* CREATE GAMEBOARD *)
  let fmap = fill_gb_create_function gboard fmap in

  (* DEFINE MAIN FUNCTION: calls gb_create, run_loop, return 0 *)
  let main_ftype = L.function_type i32_t [||] in 
  let main_function = L.define_function "main" main_ftype the_module in
  let main_builder = L.builder_at_end context (L.entry_block main_function) in
  ignore (L.build_call (StringMap.find (gboard.A.gname ^ "_create") fmap) [||] "" main_builder);
  ignore (L.build_call run_loop_func [| |] "" main_builder);
  ignore (L.build_ret (L.const_int i32_t 0) main_builder);

  the_module  

