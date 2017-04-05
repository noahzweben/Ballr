open Ast

module StringMap = Map.Make(String)


let check (vardecls, funcdecls, entdecls, gboard) = 

let rec expr = function
		Literal _ -> Int
	    | FLiteral _ -> Float
      | BoolLit _ -> Bool
      | Id s -> Bool
      | Binop(e1, op, e2) as e -> let t1 = expr e1 and t2 = expr e2 in
		(match op with
			(* do better *)
           Add | Mod | Sub | Mult | Div when t1 = Int && t2 = Int -> Int
		 |  Add | Sub | Mult | Div when t1 = Int && t2 = Float -> Float
		 |  Add | Sub | Mult | Div when t1 = Float && t2 = Int -> Float
   		 |  Add | Sub | Mult | Div when t1 = Float && t2 = Float -> Float
		 | Equal | Neq when t1 = t2 -> Bool
		 (* forces to be same ugh *)
	      | Less | Leq | Greater | Geq when t1 = Int && t2 = Int -> Bool
	      | Less | Leq | Greater | Geq when t1 = Float && t2 = Float -> Bool

		  | And | Or when t1 = Bool && t2 = Bool -> Bool
          | _ -> raise (Failure ("illegal binary operator " ^
              string_of_typ t1 ^ " " ^ string_of_op op ^ " " ^
              string_of_typ t2 ^ " in " ^ string_of_expr e))
        )
      | Unop(op, e) as ex -> let t = expr e in
	    (match op with
	 	   Neg when t = Int -> Int
	 	 | Neg when t = Float -> Float
		 | Not when t = Bool -> Bool
         | _ -> raise (Failure ("illegal unary operator " ^ string_of_uop op ^
	  		   string_of_typ t ^ " in " ^ string_of_expr ex))
        )

      | Noexpr -> Bool
 (*      | Assign(var, e) as ex -> let lt = type_of_identifier var
                                and rt = expr e in
        check_assign lt rt (Failure ("illegal assignment " ^ string_of_typ lt ^
				     " = " ^ string_of_typ rt ^ " in " ^ 
				     string_of_expr ex)) *)
	  (* | Access -> ()
	  | ArrayAccess ->  *)
(*       | Call(fname, actuals) as call -> let fd = function_decl fname in
         if List.length actuals != List.length fd.formals then
           raise (Failure ("expecting " ^ string_of_int
             (List.length fd.formals) ^ " arguments in " ^ string_of_expr call))
         else
           List.iter2 (fun (ft, _) e -> let et = expr e in
              ignore (check_assign ft et
                (Failure ("illegal actual argument found " ^ string_of_typ et ^
                " expected " ^ string_of_typ ft ^ " in " ^ string_of_expr e))))
             fd.formals actuals;
           fd.typ *)
in



let check_bool_expr e = if expr e != Bool
     then raise (Failure ("expected Boolean expression in " ^ string_of_expr e))
     else () 
in


let rec stmt = function
	Block sl -> let rec check_block = function
       [Return _ as s] -> stmt s
     | Return _ :: _ -> raise (Failure "nothing may follow a return")
     | Block sl :: ss -> check_block (sl @ ss)
     | s :: ss -> stmt s ; check_block ss
     | [] -> ()
    in check_block sl
  | Expr e -> ignore (expr e)
(*   | Return e -> let t = expr e in if t = .typ then () else
     raise (Failure ("return gives " ^ string_of_typ t ^ " expected " ^
                     string_of_typ func.typ ^ " in " ^ string_of_expr e)) *)
       
  | If(p, b1, b2) -> check_bool_expr p; stmt b1; stmt b2
  | ForEach(n1, n2, st) -> stmt st
  | While(p, s) -> check_bool_expr p; stmt s

in

let entMemTypes memz= List.fold_left (fun m (VarInit(t, n, e)) -> StringMap.add n t m)
StringMap.empty memz

in 

let checkEntMem s t m = 
      try 
        let myT = StringMap.find s m 
        in
        if myT != t then raise (Failure ("wrong Type"))
     with Not_found -> raise (Failure ("You haven't defined " ^ s))
  in

let checkEvent = function 
  Event (_, _, bhvr) ->
	   stmt (Block bhvr)
   in

let checkEntDecl e = 
  let myMems = entMemTypes e.members in
  checkEntMem "clr" Color myMems;
  checkEntMem "size" Vector myMems;
	List.iter checkEvent e.rules


in
List.iter checkEntDecl entdecls

(*  let type_of_identifier s =
      try StringMap.find s symbols
      with Not_found -> raise (Failure ("undeclared identifier " ^ s))
    in *)

    (* Return the type of an expression or throw an exception *)

 

