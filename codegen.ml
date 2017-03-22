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



  (* Declare printf(), which the print built-in function will call *)
  let gb_init_t = L.var_arg_function_type L.void_type [| PTR gb_t; PTR i8_t; vec_t; clr_t|] in
  let gb_init_func = L.declare_function "gb_init" L.void_type the_module in

  (* Declare the built-in printbig() function *)
  let run_loop_t = L.function_type i32_t [| i32_t |] in
  let run_loop_t_func = L.declare_function "printbig" printbig_t the_module in


