
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
(*   	and L.pointer_type = L.pointer_type context *)
(*     and ut_hash_handle_t = L.struct_type context [|L.pointer_type ut_hash_table_t; L.pointer_type i8_t; L.pointer_type i8_t; L.pointer_type ut_hash_handle_t; L.pointer_type ut_hash_handle; L.pointer_type i8_t; i32_t; i32_t|]
    and ut_hash_table_t = L.struct_type context [|L.pointer_type ut_hash_bucket_t; i32_t; i32_t; i32_t; L.pointer_type ut_hash_handle_t; i64_t; i32_t; i32_t; i32_t; i32_t; i32_t|]
    and ut_hash_bucket_t = L.struct_type context [|L.pointer_type ut_hash_handle; i32_t; i32_t|] *)
    let clr_t = L.struct_type context [|i32_t; i32_t; i32_t|] in
    let vec_t = L.struct_type context [|i32_t; i32_t|] in
(*	  and size_t = L.struct_type context [|i32_t; i32_t|]
	  and pos_t = L.struct_type context [|i32_t; i32_t|]
	  and ent_t = L.struct_type context [|  L.pointer_type i8_t; size_t; pos_t; clr_t; L.function_type L.void_type [| L.pointer_type ent_t |]; L.pointer_type ent_t; ut_hash_handle_t |] *)
	  let gb_t = L.struct_type context [| (L.pointer_type (L.i8_type context)) |] (*; size_t; clr_t; L.pointer_type ent_t; L.function_type L.void_type [| L.pointer_type gb_t |]; ut_hash_handle_t;|]*) in

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
  let run_loop_t_func = L.declare_function "run_loop" run_loop_t the_module in

  let register_gb_t = L.function_type (L.void_type context) [| (L.pointer_type gb_t) |] in
  let register_gb_t_func = L.declare_function "register_gb" register_gb_t the_module in
  
  let gb_create gb = 
    let name = gb.A.gname ^ "_create" in 
    let ftype = L.function_type (L.pointer_type gb_t) [| |] in 
    L.define_function name ftype the_module in

  let fill_create_function gb t = 
    let builder = L.builder_at_end context (L.entry_block (gb_create gb)) in
    L.build_alloca t "tmp" builder ; 
    ignore(L.build_ret (L.const_null gb_t) builder); builder in

  fill_create_function gboard i32_t ;
  
  the_module  
  
