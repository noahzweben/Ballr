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
    L.struct_set_body ent_t [|  L.pointer_type i8_t; vec_t; vec_t; clr_t; L.pointer_type (L.function_type (L.void_type context) [| L.pointer_type ent_t |]); L.pointer_type ent_t; ut_hash_handle_t |] false;
  let gb_t = L.named_struct_type context "blr_gameboard_t" in
    L.struct_set_body gb_t [| L.pointer_type i8_t; vec_t; clr_t; L.pointer_type ent_t; L.pointer_type (L.function_type (L.void_type context) [| L.pointer_type gb_t |]);  ut_hash_handle_t |] false;

  let ltype_of_typ = function
      A.Int -> i32_t
    | A.Bool -> i1_t
    | A.Float -> flt_t
    | A.Color -> clr_t  
    | A.Vector -> vec_t
  in

  let printf_t = L.var_arg_function_type i32_t [| L.pointer_type i8_t |] in 
  let printf_func = L.declare_function "printf" printf_t the_module in

  let run_loop_t = L.function_type i32_t [| |] in
  let run_loop_func = L.declare_function "run_loop" run_loop_t the_module in

  let register_gb_t = L.function_type (L.void_type context) [| (L.pointer_type gb_t) |] in
  let register_gb_func = L.declare_function "register_gb" register_gb_t the_module in

  let add_fn_t = L.function_type (L.void_type context) [| (L.pointer_type ent_t) |] in
  let add_fn = L.declare_function "ent_add" add_fn_t the_module in

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

  (* BUILD EXPRESSIONS *)
  let rec expr builder m = function
      A.Literal i -> L.const_int i32_t i
    | A.FLiteral f -> L.const_float flt_t f
    | A.BoolLit b -> L.const_int i1_t (if b then 1 else 0)
    | A.Noexpr  -> L.const_int i32_t 0
    | A.Id s    -> L.build_load (StringMap.find s m) s builder 

    | A.Call ("print", [e]) | A.Call ("printb", [e]) ->
      L.build_call printf_func 
        [| int_format_str builder ; (expr builder m e) |]
        "printf" builder (* build_call fn args name b creates %name = call %fn(args...) *)

    | A.Call ("add", [e1; e2]) ->
      let e2' = expr builder m e2 in
      (match e1 with
        A.Id (name) ->
          let creat_fn = StringMap.find (name ^ "_create") m in
          let ent_ptr = L.build_call creat_fn [| |] name builder in
          let pos_ptr = L.build_struct_gep ent_ptr 2 "pos" builder in
          ignore (L.build_store e2' pos_ptr builder);
          ignore (L.build_call add_fn [| ent_ptr |] "" builder);
          L.const_int i32_t 0
        | _ -> raise (Blr_err "expected identifier"))

      (***** ADD OTHER BUILT IN FUNCTIONS *)

    | A.Call (name, args) ->
      let func = StringMap.find name m in
      let arg_arr = Array.of_list (List.map (expr builder m) args) in
      L.build_call func arg_arr name builder

    | A.Binop (e1, op, e2) ->
      let e1' = expr builder m e1
      and e2' = expr builder m e2 in
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
      let e' = expr builder m e in
      (match op with
          A.Neg     -> L.build_neg
        | A.Not     -> L.build_not) e' "tmp" builder

    | A.Clr (e1, e2, e3) as clr -> 
      (match (clr_lit clr) with
        Some(vals) -> L.const_named_struct clr_t vals
        | None ->
	  let e1' = expr builder m e1
	  and e2' = expr builder m e2
          and e3' = expr builder m e3 in
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
          let e1' = expr builder m e1
          and e2' = expr builder m e2 in
          let vec_ptr = L.build_alloca vec_t "tmp" builder in
          let x_ptr = L.build_struct_gep vec_ptr 0 "x" builder in
          ignore (L.build_store e1' x_ptr builder);
          let y_ptr = L.build_struct_gep vec_ptr 1 "y" builder in
          ignore (L.build_store e2' y_ptr builder);
          L.build_load vec_ptr "v" builder)

    (***** ACCESS *)
    (***** ARRAY ACCESS *)
    (***** ASSIGN *)
  in

   let int_of_bool b = if b then 1 else 0
  in 
    let bool_of_int b = b != 0 
  in

  (* BUILD STATEMENTS *)
  let rec stmt builder func m = function
      A.Block sl -> List.fold_left (fun b s -> stmt b func m s) builder sl (* sl is a block = list of stmts *)
    | A.Expr e -> ignore (expr builder m e); builder
    | A.Return e -> L.build_ret (expr builder m e) builder; builder
                
    | A.If (predicate, then_stmt, else_stmt) ->
      let bool_val = expr builder m predicate in (* evaluate predicate expression *)
      let merge_bb = L.append_block context "merge" func in (* append_block c name f creates new basic block named name at end of function f in context c *)
      let then_bb = L.append_block context "then" func in
      add_terminal 
        (stmt (L.builder_at_end context then_bb) func m then_stmt) (* builder_at_end bb creates instr builder positioned at end of basic block bb *)
        (L.build_br merge_bb); (* build_br bb b creates a br %bb instr at position specified by b *)

      let else_bb = L.append_block context "else" func in
      add_terminal 
        (stmt (L.builder_at_end context else_bb) func m else_stmt)
        (L.build_br merge_bb);

      ignore (L.build_cond_br bool_val then_bb else_bb builder); (* build_cond_br cond tbb fbb b creates a br %cond, %tbb, %fbb instr *)
      L.builder_at_end context merge_bb

    | A.While (predicate, body) ->
      let pred_bb = L.append_block context "while" func in
      ignore (L.build_br pred_bb builder);

      let body_bb = L.append_block context "while_body" func in
      add_terminal (stmt (L.builder_at_end context body_bb) func m body)
          (L.build_br pred_bb);

      let pred_builder = L.builder_at_end context pred_bb in
      let bool_val = expr pred_builder m predicate in

      let merge_bb = L.append_block context "merge" func in
      ignore (L.build_cond_br bool_val body_bb merge_bb pred_builder);
        L.builder_at_end context merge_bb
    
    (***** FOREACH *)
    
  in

  let add_locals m decls builder = 
    let add_local m (A.VarInit(t, n, e)) =
      let e' = expr builder m e in
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
          A.Neg     -> match e with 
                          A.Literal i -> L.const_neg e'
                        | A.FLiteral f -> L.const_fneg e'
                        | _ -> L.const_int i32_t 0  
        | _ -> L.const_int i32_t 0 
      )
  in

  (* GLOBAL VAR DECLARATIONS *)

  let global_vars = 
    let global_var m (A.VarInit(t, n, e)) = 
(*       let init = eval_expr m e in
      let initval = (fst init) in *)
      let initval = get_init_val e in 
      StringMap.add n ((L.define_global n initval the_module), initval) m in 
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
    let map = add_locals map f.A.locals builder in
    let builder = stmt builder func map (A.Block f.A.body) in
    map
  in
 
  (* ENTITY DECLARATIONS *)

  let ent_frame e m =
    let name = e.A.ename ^ "_frame" in
    let ftype = L.function_type (L.void_type context) [| L.pointer_type ent_t |] in
    let func = L.define_function name ftype the_module in
    (StringMap.add name func m, func)
  in

  let fill_ent_frame_function e m =
    let (map, func) = ent_frame e m in
    let builder = L.builder_at_end context (L.entry_block func) in
    ignore (L.build_ret_void builder);
    map
  in

  let ent_create e m =
    let name = e.A.ename ^ "_create" in
    let ftype = L.function_type (L.pointer_type ent_t) [| |] in
    let func = L.define_function name ftype the_module in
    (StringMap.add name func m, func)
  in

  let fill_ent_create_function e m =
    let (map, func) = ent_create e m in
    let builder = L.builder_at_end context (L.entry_block func) in
    let ent_ptr = L.build_malloc ent_t ("ent_ptr") builder in

    let name_str_ptr = L.build_global_stringptr e.A.ename (e.A.ename ^ "_name_str_ptr") builder in
    let name_ptr = L.build_struct_gep ent_ptr 0 ("name_ptr") builder in
    ignore (L.build_store name_str_ptr name_ptr builder);

    let ent_size_ptr = L.build_struct_gep ent_ptr 1 ("size_ptr") builder in
    let size_decl_expr = get_decl "size" e.A.members in
    ignore (L.build_store (expr builder map size_decl_expr) ent_size_ptr builder);

    let ent_pos_ptr = L.build_struct_gep ent_ptr 2 ("pos_ptr") builder in
    let pos_zero = [|L.const_int i32_t 0; L.const_int i32_t 0|] in
    ignore (L.build_store (L.const_named_struct vec_t pos_zero) ent_pos_ptr builder);

    let ent_color_ptr = L.build_struct_gep ent_ptr 3 ("color_ptr") builder in
    let color_decl_expr = get_decl "clr" e.A.members in
    ignore (L.build_store (expr builder map color_decl_expr) ent_color_ptr builder); 

    let ent_frame_fn_ptr = L.build_struct_gep ent_ptr 4 ("frame_fn_ptr") builder in
    let map = fill_ent_frame_function e map in
    let frame_fn = StringMap.find (e.A.ename ^ "_frame") map in
    ignore (L.build_store frame_fn ent_frame_fn_ptr builder);

    ignore (L.build_ret ent_ptr builder);
    map
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
    
    let map = add_locals map gb.A.init_mem builder in
    let builder = stmt builder func map (A.Block gb.A.init_body) in
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
    ignore (L.build_store (expr builder map size_decl_expr) gb_size_ptr builder);

    let gb_color_ptr = L.build_struct_gep gb_ptr 2 ("color_ptr") builder in
    let color_decl_expr = get_decl "clr" gb.A.gmembers in
    ignore (L.build_store (expr builder map color_decl_expr) gb_color_ptr builder);

    let gb_init_fn_ptr = L.build_struct_gep gb_ptr 4 ("init_fn_ptr") builder in
    let init_fn = StringMap.find (gb.A.gname ^ "_init") map in
    ignore (L.build_store init_fn gb_init_fn_ptr builder);

    ignore (L.build_call register_gb_func [| gb_ptr |] "" builder);

    ignore (L.build_ret gb_ptr builder);
    map
  in

  (* ADD FUNCTION AND ENTITY DECLARATIONS TO MAP *)
  let fmap = List.fold_left (fun m f -> fill_func_body f m) StringMap.empty fdecls in
  let fmap = List.fold_left (fun m e -> fill_ent_create_function e m) fmap ents in
  let fmap = fill_gb_create_function gboard fmap in

  (* DEFINE MAIN FUNCTION: calls gb_create, run_loop, return 0 *)
  let main_ftype = L.function_type i32_t [||] in 
  let main_function = L.define_function "main" main_ftype the_module in
  let main_builder = L.builder_at_end context (L.entry_block main_function) in
  ignore (L.build_call (StringMap.find (gboard.A.gname ^ "_create") fmap) [||] "" main_builder);
  ignore (L.build_call run_loop_func [| |] "" main_builder);
  ignore (L.build_ret (L.const_int i32_t 0) main_builder);

  the_module  
  



(* IN CASE WE NEED EXPRESSIONS FOR GLOBALS BUT PROB TRASH *)
  (*    let rec eval_expr m = function (* used for global var init values *)
      A.Literal i -> (L.const_int i32_t i, i)
      (* FLOATS ??  separate eval function ? better way to do this? *)
(*     | A.FLiteral f -> (L.const_float flt_t f *)
    | A.BoolLit b -> let res = (int_of_bool b) in (L.const_int i1_t res, res)
    | A.Noexpr    -> (L.const_int i32_t 0, 0)
    | A.Id s      -> snd (StringMap.find s m) 
    | A.Binop (e1, op, e2) ->
      let e1' = eval_expr m e1
      and e2' = eval_expr m e2 in
      ( match op with
        A.Add     -> let res = (snd e1' + snd e2') in (L.const_int i32_t res, res)
      | A.Sub     -> let res = (snd e1' - snd e2') in (L.const_int i32_t res, res)
      | A.Mult    -> let res = (snd e1' * snd e2') in (L.const_int i32_t res, res)
      | A.Div     -> let res = (snd e1' / snd e2') in (L.const_int i32_t res, res)
      | A.Mod     -> let res = (snd e1' mod snd e2') in (L.const_int i32_t res, res)
      | A.And     -> let res = int_of_bool (bool_of_int (snd e1') && bool_of_int (snd e2')) in (L.const_int i1_t res, res)
      | A.Or      -> let res = int_of_bool (bool_of_int (snd e1') || bool_of_int (snd e2')) in (L.const_int i1_t res, res)
      | A.Equal   -> let res = (int_of_bool (snd e1' = snd e2')) in (L.const_int i1_t res, res)
      | A.Neq     -> let res = (int_of_bool (snd e1' != snd e2')) in (L.const_int i1_t res, res)
      | A.Less    -> let res = (int_of_bool (snd e1' < snd e2')) in (L.const_int i1_t res, res)
      | A.Leq     -> let res = (int_of_bool (snd e1' <= snd e2')) in (L.const_int i1_t res, res)
      | A.Greater -> let res = (int_of_bool (snd e1' > snd e2')) in (L.const_int i1_t res, res)
      | A.Geq     -> let res = (int_of_bool (snd e1' >= snd e2')) in (L.const_int i1_t res, res) 
      ) 
    
    | A.Unop(op, e) ->
      let e' = eval_expr m e in
      ( match op with
          A.Neg     -> let res = -(snd e') in (L.const_int i32_t res, res)
        | A.Not     -> let res = if (bool_of_int (snd e')) then 0 else 1 in (L.const_int i1_t res, res)
      )
   in  *)
