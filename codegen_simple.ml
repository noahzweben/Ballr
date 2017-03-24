
module L = Llvm
module A = Ast

module StringMap = Map.Make(String)

let translate (_, _, _, gboard, _) =
	let context = L.global_context () in
  	let the_module = L.create_module context "Ballr"
    and i64_t  = L.i64_type  context
  	and i32_t  = L.i32_type  context
  	and i8_t   = L.i8_type   context
  	and i1_t   = L.i1_type   context 
  	and flt_t = L.float_type context
  	and PTR = L.pointer_type
    and ut_hash_handle_t = L.struct_type context [|PTR ut_hash_table_t; PTR i8_t; PTR i8_t; PTR ut_hash_handle_t; PTR ut_hash_handle; PTR i8_t; i32_t; i32_t|]
    and ut_hash_table_t = L.struct_type context [|PTR ut_hash_bucket_t; i32_t; i32_t; i32_t; PTR ut_hash_handle_t; i64_t; i32_t; i32_t; i32_t; i32_t; i32_t|]
    and ut_hash_bucket_t = L.struct_type context [|PTR ut_hash_handle; i32_t; i32_t|]
  	and clr_t = L.struct_type context [|i32_t; i32_t; i32_t|]
	and size_t = L.struct_type context [|i32_t; i32_t|]
	and pos_t = L.struct_type context [|i32_t; i32_t|]
	and ent_t = L.struct_type context [|  PTR i8_t; size_t; pos_t; clr_t; L.function_type L.void_type [| PTR ent_t |]; PTR ent_t; ut_hash_handle_t |]
	and gb_t = L.struct_type [|PTR i8_t; size_t; clr_t; PTR ent_t; L.function_type L.void_type [| PTR gb_t |]; ut_hash_handle_t;|] in



  let ltype_of_typ = function
      A.Int -> i32_t
    | A.Bool -> i1_t
    | A.Float -> flt_t
    | A.Size -> size_t
    | A.Pos -> pos_t
    | A.Color -> clr_t


  let run_loop_t = L.function_type i32_t [||] in
  let run_loop_t_func = L.declare_function "run_loop" run_loop_t the_module in

  let register_gb_t= L.function_type L.void_type [|PTR gb_t |] in
  let register_gb_t_func = L.declare_function "register_gb" register_gb_t the_module in
  
  let gb_decl = 
    let gb_create gb = 
      let name= gb.A.gname in 
      let ftype= L.function_type (PTR gb_t) [||] in 
      L.define_function name ftype the_module 

  
