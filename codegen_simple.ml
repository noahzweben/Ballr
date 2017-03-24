
module L = Llvm
module A = Ast

module StringMap = Map.Make(String)

let translate (_, _, _, gboard, _) =
	let context = L.global_context () in
  	let the_module = L.create_module context "Ballr" in
    let i64_t  = L.i64_type  context in
  	let i32_t  = L.i32_type  context in
  	let i8_t   = L.i8_type   context in 
  	let i1_t   = L.i1_type   context in
  	let flt_t = L.float_type context in
(*     let ut_hash_handle_t = L.struct_type context [|L.pointer_type ut_hash_table_t; L.pointer_type i8_t; L.pointer_type i8_t; L.pointer_type ut_hash_handle_t; L.pointer_type ut_hash_handle; L.pointer_type i8_t; i32_t; i32_t|] in 
    let ut_hash_table_t = L.struct_type context [|L.pointer_type ut_hash_bucket_t; i32_t; i32_t; i32_t; L.pointer_type ut_hash_handle_t; i64_t; i32_t; i32_t; i32_t; i32_t; i32_t|] in
    let ut_hash_bucket_t = L.struct_type context [|L.pointer_type ut_hash_handle; i32_t; i32_t|] in *)
    let clr_t = L.named_struct_type context "blr_color_t" in
      L.struct_set_body clr_t [|i32_t; i32_t; i32_t|] false;
    let vec_t = L.named_struct_type context "blr_size_t" in
      L.struct_set_body vec_t [|i32_t; i32_t|] false;
(*	  and size_t = L.struct_type context [|i32_t; i32_t|]
	  and pos_t = L.struct_type context [|i32_t; i32_t|]
	  and ent_t = L.struct_type context [|  L.pointer_type i8_t; size_t; pos_t; clr_t; L.function_type L.void_type [| L.pointer_type ent_t |]; L.pointer_type ent_t; ut_hash_handle_t |] *)
	  let gb_t = L.named_struct_type context "blr_gameboard_t" in
      L.struct_set_body gb_t [| (L.pointer_type (L.i8_type context))  ; vec_t; clr_t; (* L.pointer_type ent_t; L.function_type L.void_type [| L.pointer_type gb_t |];  ut_hash_handle_t; *)|] false;
  let ltype_of_typ = function
      A.Int -> i32_t
    | A.Bool -> i1_t
    | A.Float -> flt_t
(*     | A.Size -> size_t
    | A.Pos -> pos_t *)
    | A.Color -> clr_t  
    | A.Vector -> vec_t
  in

  let run_loop_t = L.function_type i32_t [| |] in
  let run_loop_func = L.declare_function "run_loop" run_loop_t the_module in

  let register_gb_t = L.function_type (L.void_type context) [| (L.pointer_type gb_t) |] in
  let register_gb_func = L.declare_function "register_gb" register_gb_t the_module in
  
  let gb_create gb m = 
    let name = gb.A.gname ^ "_create" in 
    let ftype = L.function_type (L.pointer_type gb_t) [| |] in 
    let func = L.define_function name ftype the_module in
    (StringMap.add name func m, func)
  in

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

  let fill_create_function gb m = 
    let (map, func) =  (gb_create gb m) in
    let builder = L.builder_at_end context (L.entry_block func) in
    let gb_ptr = L.build_malloc gb_t ("board_ptr") builder in

    let name_str_ptr = L.build_global_stringptr gb.A.gname (gb.A.gname ^ "_name_str_ptr") builder in
    let name_ptr = L.build_struct_gep gb_ptr 0 ("name_ptr") builder in
    L.build_store name_str_ptr name_ptr builder;

    let gb_size_ptr = L.build_struct_gep gb_ptr 1 ("size_ptr") builder in
    let size_decl_expr = get_decl "size" gb.A.members in
    L.build_store (L.const_struct context (vec_lit size_decl_expr)) gb_size_ptr builder;

    let gb_color_ptr = L.build_struct_gep gb_ptr 2 ("color_ptr") builder in
    let color_decl_expr = get_decl "clr" gb.A.members in
    L.build_store (L.const_struct context (clr_lit color_decl_expr)) gb_color_ptr builder;

    L.build_call register_gb_func [| gb_ptr |] "unused" builder;

    L.build_ret gb_ptr builder;
    map
  in

  let fmap = fill_create_function gboard StringMap.empty in
  
  let main_ftype = L.function_type i32_t [||] in 
  let main_function = L.define_function "main" main_ftype the_module in
  let main_builder = L.builder_at_end context (L.entry_block main_function) in
  L.build_call (StringMap.find (gboard.A.gname ^ "_create") fmap) [||] "_unused" main_builder;
 (*  L.build_call (StringMap.find (gboard.A.gname ^ "_create") fmap) [||] "_unused" main_builder; *)
  L.build_call run_loop_func [| |] "__unused" main_builder ;


  the_module  
  
