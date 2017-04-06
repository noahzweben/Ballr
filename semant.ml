open Ast

module StringMap = Map.Make(String)

let check (vardecls, funcdecls, entdecls, gboard) = 

  (* check for duplicates within a list *)
  let reportDuplicate exceptf list =
    let rec helper = function
  n1 :: n2 :: _ when n1 = n2 -> raise (Failure (exceptf n1))
      | _ :: t -> helper t
      | [] -> ()
    in helper (List.sort compare list)
  in

  (* check if given type is an int or float *)
  let isNumType t = if (t = Int || t = Float) then true else false

  in 

  let builtInDecls =  StringMap.add "print" (*** ADD BUILT IN FUNCTIONS ***)
     { typ = Int; fname = "print"; formals = [(Int, "x")];
       locals = []; body = [] } 
       (StringMap.singleton "add"
     { typ = Int; fname = "add"; formals = [(Bool, "e") ; (Vector, "pos")]; (* NEED AN ENTITY TYPE*)
       locals = []; body = [] }) 
   in
     
  let functionDecls = List.fold_left (fun m fd -> StringMap.add fd.fname fd m)
                         builtInDecls funcdecls
  in

  let functionDecl s = try StringMap.find s functionDecls
       with Not_found -> raise (Failure ("unrecognized function " ^ s))
  in

  (* check expressions *)
  let rec expr = function
		Literal _ -> Int
	  | FLiteral _ -> Float
    | BoolLit _ -> Bool
    | Id s -> Bool (* THIS *)
    | Noexpr -> Bool (* THIS *)

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

    | Clr(r,g,b)  -> let t1 = expr r and t2 = expr g and t3 = expr b in
      if (isNumType(t1) && isNumType(t2) && isNumType(t3)) then Color
      else raise (Failure ("expected numeric input for type color"))
    | Vec(x,y)  -> let t1 = expr x and t2 = expr y in
      if (isNumType(t1) && isNumType(t2)) then Vector
      else raise (Failure ("expected numeric input for type vector"))


    | Call(fname, actuals) as call -> let fd = functionDecl fname in
       if List.length actuals != List.length fd.formals then
         raise (Failure ("expecting " ^ string_of_int
           (List.length fd.formals) ^ " arguments in " ^ string_of_expr call))
       else
(*          List.iter2 (fun (ft, _) e -> let et = expr e in
            ignore (check_assign ft et
              (Failure ("illegal actual argument found " ^ string_of_typ et ^
              " expected " ^ string_of_typ ft ^ " in " ^ string_of_expr e))))
           fd.formals actuals; *)
         fd.typ

    (* ADD THESE:
     | Access -> ()
     | ArrayAccess ->  *)
in

(* check if types in a varinit statement match *)
let checkVarInit = function
  VarInit(t,n,e) -> let e_typ = expr e in
    if t != e_typ 
    then raise (Failure ("expected type " ^ string_of_typ t ^ ", not " ^ string_of_expr e ^ " of type " ^ string_of_typ e_typ))
     else () 

in

(* check if given expression is of type boolean *)
let checkBoolExpr e = if expr e != Bool
     then raise (Failure ("expected Boolean expression in " ^ string_of_expr e))
     else () 
in

let varDeclName = function VarInit(_, n, _) -> n 

in

(* check statements *)
let rec stmt = function
  Block sl -> let rec checkBlock = function
       [Return _ as s] -> stmt s
     | Return _ :: _ -> raise (Failure "nothing may follow a return")
     | Block sl :: ss -> checkBlock (sl @ ss)
     | s :: ss -> stmt s ; checkBlock ss
     | [] -> ()
    in checkBlock sl
  | Expr e -> ignore (expr e)
(*   | Return e -> let t = expr e in if t = func.typ then () else
     raise (Failure ("return gives " ^ string_of_typ t ^ " expected " ^
                     string_of_typ func.typ ^ " in " ^ string_of_expr e))  *)
       
  | If(p, b1, b2) -> checkBoolExpr p; stmt b1; stmt b2
  | ForEach(n1, n2, st) -> stmt st
  | While(p, s) -> checkBoolExpr p; stmt s

in

(*** CHECK FUNC DECLS ***)

  (**)
  let checkFunc func =

    (* check for duplicate formals *)
    reportDuplicate (fun n -> "duplicate formal " ^ n ^ " in " ^ func.fname)
      (List.map snd func.formals);

    (* check for duplicate locals *)
    reportDuplicate (fun n -> "duplicate local " ^ n ^ " in " ^ func.fname)
      (List.map varDeclName func.locals);

    (* check function statements *)
    stmt (Block func.body)
    
    (* DO WE NEED TO CHECK FOR A RETURN STATEMENT OR DO WE FORCE THIS IN CODEGEN? *)
    (* DO WE NEED TO CHECK FOR DUPLICATE FUNCTION NAMES? OVERLOADING? *)

in



(*** CHECK VAR DECLS ***)

(* check assignment types *)
List.iter checkVarInit vardecls; 

(* check for duplicates *)
reportDuplicate (fun n -> "duplicate global variable " ^ n)
    (List.map varDeclName vardecls); 

(*** CHECK ENT DECLS ***)

(* build a map given a list of members *)
let entMemTypes memz = List.fold_left (fun m (VarInit(t, n, e)) -> StringMap.add n t m)
  StringMap.empty memz

in 

(* check if a given member type exists *)
let checkMemExists s t m = 
      try 
        let myT = StringMap.find s m 
        in
        if myT != t then raise (Failure ("wrong type"))
     with Not_found -> raise (Failure ("You haven't defined " ^ s))
  in

(* check the statements within events *)
let checkEvent = function 
  Event (_, _, bhvr) ->
	   stmt (Block bhvr)
   in

(* check for required members, check member types, check event statements *)
let checkEntDecl e = 
  let myMems = entMemTypes e.members in
  checkMemExists "clr" Color myMems;
  checkMemExists "size" Vector myMems;
  List.iter checkVarInit e.members;
	List.iter checkEvent e.rules

in

List.iter checkEntDecl entdecls
