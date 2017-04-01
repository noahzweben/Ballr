
module L = Llvm
module A = Ast

module StringMap = Map.Make(String)

let translate (_, _, _, gboard) =
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

  let get_decl name decls =
    match List.filter (fun (A.VarInit (t, s, e)) -> s = name) decls with
      | A.VarInit (t, s, e) :: tl -> e
      | [] -> A.Noexpr in

  let clr_lit = function
    | A.Clr (A.Literal r, A.Literal g, A.Literal b) -> [|L.const_int i32_t r; L.const_int i32_t g; L.const_int i32_t b|]
    | _ -> [|L.const_int i32_t 0; L.const_int i32_t 0; L.const_int i32_t 0|] in

  let vec_lit = function
    | A.Vec (A.Literal v1, A.Literal v2) -> [|L.const_int i32_t v1; L.const_int i32_t v2|]
    | _ -> [|L.const_int i32_t 0; L.const_int i32_t 0; L.const_int i32_t 0|] in

  let gb_init gb m = 
    let name = gb.A.gname ^ "_init" in
    let ftype = L.function_type (L.void_type context) [| L.pointer_type gb_t |] in
    let func = L.define_function name ftype the_module in
    (StringMap.add name func m, func)
  in

  let fill_init_function gb m =
    
    let (map, func) = (gb_init gb m) in
    let builder = L.builder_at_end context (L.entry_block func) in
    
    let int_format_str = L.build_global_stringptr "%d\n" "fmt" builder in (* format string for printf calls *)

    let add_terminal builder f =
      match L.block_terminator (L.insertion_block builder) with
        Some _ -> ()
      | None -> ignore (f builder) in

      (* BUILD EXPRESSIONS *)
      let rec expr builder = function
        A.Literal i -> L.const_int i32_t i
        | A.BoolLit b -> L.const_int i1_t (if b then 1 else 0)
        | A.Noexpr -> L.const_int i32_t 0

        | A.Call ("print", [e]) | A.Call ("printb", [e]) ->
          L.build_call printf_func 
            [| int_format_str ; (expr builder e) |]
            "printf" builder (* build_call fn args name b creates %name = call %fn(args...) *)

      in

    (* BUILD STATEMENTS *)
    let rec stmt builder = function
          A.Block sl -> List.fold_left stmt builder sl (* sl is a block = list of stmts *)
        | A.Expr e -> ignore (expr builder e); builder
                
        | A.If (predicate, then_stmt, else_stmt) ->
            let bool_val = expr builder predicate in (* evaluate predicate expression *)
            let merge_bb = L.append_block context "merge" func in (* append_block c name f creates new basic block named name at end of function f in context c *)
            let then_bb = L.append_block context "then" func in
            add_terminal 
             (stmt (L.builder_at_end context then_bb) then_stmt) (* builder_at_end bb creates instr builder positioned at end of basic block bb *)
             (L.build_br merge_bb); (* build_br bb b creates a br %bb instr at position specified by b *)

            let else_bb = L.append_block context "else" func in
            add_terminal 
              (stmt (L.builder_at_end context else_bb) else_stmt)
              (L.build_br merge_bb);

            ignore (L.build_cond_br bool_val then_bb else_bb builder); (* build_cond_br cond tbb fbb b creates a br %cond, %tbb, %fbb instr *)
            L.builder_at_end context merge_bb

        | A.While (predicate, body) ->
          let pred_bb = L.append_block context "while" func in
          ignore (L.build_br pred_bb builder);

          let body_bb = L.append_block context "while_body" func in
          add_terminal (stmt (L.builder_at_end context body_bb) body)
            (L.build_br pred_bb);

          let pred_builder = L.builder_at_end context pred_bb in
          let bool_val = expr pred_builder predicate in

          let merge_bb = L.append_block context "merge" func in
          ignore (L.build_cond_br bool_val body_bb merge_bb pred_builder);
          L.builder_at_end context merge_bb
      in

    let builder = stmt builder (A.Block gb.A.init) in
    ignore (L.build_ret_void builder);
    map    
  in

  let gb_create gb m = 
    let name = gb.A.gname ^ "_create" in 
    let ftype = L.function_type (L.pointer_type gb_t) [| |] in 
    let func = L.define_function name ftype the_module in
    (StringMap.add name func m, func)
  in
  
  let fill_create_function gb m = 
    let map = fill_init_function gb m in
    let (map, func) =  (gb_create gb map) in
    let builder = L.builder_at_end context (L.entry_block func) in
    let gb_ptr = L.build_malloc gb_t ("board_ptr") builder in

    let name_str_ptr = L.build_global_stringptr gb.A.gname (gb.A.gname ^ "_name_str_ptr") builder in
    let name_ptr = L.build_struct_gep gb_ptr 0 ("name_ptr") builder in
    ignore (L.build_store name_str_ptr name_ptr builder);

    let gb_size_ptr = L.build_struct_gep gb_ptr 1 ("size_ptr") builder in
    let size_decl_expr = get_decl "size" gb.A.members in
    ignore (L.build_store (L.const_named_struct vec_t (vec_lit size_decl_expr)) gb_size_ptr builder);

    let gb_color_ptr = L.build_struct_gep gb_ptr 2 ("color_ptr") builder in
    let color_decl_expr = get_decl "clr" gb.A.members in
    ignore (L.build_store (L.const_named_struct clr_t (clr_lit color_decl_expr)) gb_color_ptr builder);

    let gb_init_fn_ptr = L.build_struct_gep gb_ptr 4 ("init_fn_ptr") builder in
    let init_fn = StringMap.find (gb.A.gname ^ "_init") map in
    ignore (L.build_store init_fn gb_init_fn_ptr builder);

    ignore (L.build_call register_gb_func [| gb_ptr |] "" builder);

    ignore (L.build_ret gb_ptr builder);
    map
  in

  let fmap = fill_create_function gboard StringMap.empty in
  
  let main_ftype = L.function_type i32_t [||] in 
  let main_function = L.define_function "main" main_ftype the_module in
  let main_builder = L.builder_at_end context (L.entry_block main_function) in
  ignore (L.build_call (StringMap.find (gboard.A.gname ^ "_create") fmap) [||] "" main_builder);
  ignore (L.build_call run_loop_func [| |] "" main_builder);
  ignore (L.build_ret (L.const_int i32_t 0) main_builder);

  the_module  
  
