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
  let isNumType t = if (t = Int || t = Float) then true else false in 

  (* extract variable name from varinit *)
  let varDeclName = function VarInit(_, n, _) -> n in

  (*** CHECK VAR DECLS & BUILD GLOBALS MAP ***)

  (* only allow constants or negative unop for global declarations *)
  let rec globalExpr = function
      Literal _ -> Int
      | FLiteral _ -> Float
      | BoolLit _ -> Bool
      | Unop(op, e) as ex -> let t = globalExpr e in
      (match op with
        Neg when t = Int -> Int
      | Neg when t = Float -> Float
      | _ -> raise (Failure ("Illegal global declaration: " ^ string_of_expr ex))
      )

      | Clr(r,g,b)  -> let t1 = globalExpr r and t2 = globalExpr g and t3 = globalExpr b in
        if (isNumType(t1) && isNumType(t2) && isNumType(t3)) then Color
        else raise (Failure ("Expected numeric input for type color"))

      | Vec(x,y)  -> let t1 = globalExpr x and t2 = globalExpr y in
        if (isNumType(t1) && isNumType(t2)) then Vector
        else raise (Failure ("Expected numeric input for type vector"))

      | _ -> raise (Failure ("Illegal global declaration"))
  in

  let checkGlobalVarInit m = function
    VarInit(t,n,e) -> let e_typ = globalExpr e in
      if t != e_typ 
        then raise (Failure ("Inconsistent types in global declaration " ^ n ^ " " ^ string_of_expr e))
      else () 
  in

  (* build map of global names & types *)
  let globals =   
    let global_var m (VarInit(t, n, e)) = StringMap.add n t m 
    in List.fold_left global_var StringMap.empty vardecls
  in 

  let globals =
    StringMap.add "clickpos" Vector globals
  in

  (* check assignment types *)
  List.iter (checkGlobalVarInit globals) vardecls; 

  (* check for duplicates *)
  reportDuplicate (fun n -> "Duplicate global variable " ^ n)
      (List.map varDeclName vardecls); 

  (*** DONE CHECKING VARDECLS ***)

  let builtInDecls =  StringMap.add "print" (*** ADD BUILT IN FUNCTIONS ***)
     { typ = Int; fname = "print"; formals = [(Int, "x")];
       locals = []; body = [] } 
       (StringMap.singleton "add"
     { typ = Int; fname = "add"; formals = [(Bool, "e") ; (Vector, "pos")]; (* NEED AN ENTITY TYPE ? *)
       locals = []; body = [] }) 
  in
  
  let builtInDecls = StringMap.add "remove"  { typ = Int; fname = "remove"; formals = []; (* NEED AN ENTITY TYPE ? *)
       locals = []; body = [] } builtInDecls
   in

  let builtInDecls = StringMap.add "restart"  { typ = Int; fname = "remove"; formals = []; (* NEED AN ENTITY TYPE ? *)
       locals = []; body = [] } builtInDecls
   in

  (* map of all callable functions, don't allow duplicates *)
  let functionDecls = List.fold_left 
    (fun m fd ->     

      try
        StringMap.find fd.fname m; raise (Failure ("Duplicate function " ^ fd.fname));
      with
        Not_found -> StringMap.add fd.fname fd m
    )
    builtInDecls funcdecls
  in

  (* find a function given its name *)
  let functionDecl s = try StringMap.find s functionDecls
       with Not_found -> raise (Failure ("Unrecognized function " ^ s))
  in

  (* return the type of an ID (check given symbols map and globals) *)
  let type_of_identifier m s =
      try StringMap.find s m
      with Not_found ->
        try StringMap.find s globals
        with Not_found -> raise (Failure ("Undeclared identifier " ^ s))
    in

(* builds a map of each entity and its corresponding available members *)

(* build a map given a list of members *)
let memTypes memz = 
  let map = List.fold_left (fun m (VarInit(t, n, e)) -> StringMap.add n t m) StringMap.empty memz in
  StringMap.add "pos" Vector map
in 

let allEntMembers =   
    let entMems m ent = StringMap.add ent.ename (memTypes ent.members) m in 
    List.fold_left entMems StringMap.empty entdecls 
in

  (* check expressions *)
  let rec expr m ent = function
		Literal _ -> Int
	  | FLiteral _ -> Float
    | BoolLit _ -> Bool
    | Id s -> type_of_identifier m s
    | Noexpr -> Bool (* THIS *)

    | Binop(e1, op, e2) as e -> let t1 = expr m ent e1 and t2 = expr m ent e2 in
		(match op with
      Add | Mod | Sub | Mult | Div when t1 = Int && t2 = Int -> Int
		 |  Add | Sub | Mult | Div when t1 = Int && t2 = Float -> Float
		 |  Add | Sub | Mult | Div when t1 = Float && t2 = Int -> Float
   	 |  Add | Sub | Mult | Div when t1 = Float && t2 = Float -> Float
		 | Equal | Neq when t1 = t2 -> Bool
	   | Less | Leq | Greater | Geq when t1 = Int && t2 = Int -> Bool
	   | Less | Leq | Greater | Geq when t1 = Float && t2 = Float -> Bool
     | Less | Leq | Greater | Geq when t1 = Float && t2 = Int -> Bool
     | Less | Leq | Greater | Geq when t1 = Int && t2 = Float -> Bool

		 | And | Or when t1 = Bool && t2 = Bool -> Bool
     | _ -> raise (Failure ("illegal binary operator " ^
        string_of_typ t1 ^ " " ^ string_of_op op ^ " " ^
        string_of_typ t2 ^ " in " ^ string_of_expr e))
    )

    | Unop(op, e) as ex -> let t = expr m ent e in
	  (match op with
	 	Neg when t = Int -> Int
	  | Neg when t = Float -> Float
		| Not when t = Bool -> Bool
      | _ -> raise (Failure ("illegal unary operator " ^ string_of_uop op ^
	  		string_of_typ t ^ " in " ^ string_of_expr ex))
    )

    | Clr(r,g,b)  -> let t1 = expr m ent r and t2 = expr m ent g and t3 = expr m ent b in
      if (isNumType(t1) && isNumType(t2) && isNumType(t3)) then Color
      else raise (Failure ("expected numeric input for type color"))

    | Vec(x,y)  -> let t1 = expr m ent x and t2 = expr m ent y in
      if (isNumType(t1) && isNumType(t2)) then Vector
      else raise (Failure ("expected numeric input for type vector"))

    | Call(fname, actuals) as call -> let fd = functionDecl fname in     
       if List.length actuals != List.length fd.formals then
         raise (Failure ("Expecting " ^ string_of_int
           (List.length fd.formals) ^ " arguments in " ^ string_of_expr call))
       else
        if (fname="add") then ( 
          let entName = string_of_expr (List.hd actuals) in 
          if not (StringMap.mem entName allEntMembers) then 
            raise (Failure(entName ^ " is not a defined entity"))
            else Int 
        )
        else
         let checkSameT t1 t2 = if t1 != t2 then raise (Failure ("Incorrect actual argument type in " ^ string_of_expr call)) in 
          List.iter2 (fun (ft,_) e -> let et = expr m ent e in checkSameT ft et ) fd.formals actuals;
         fd.typ
    | ArrayAccess(e1, e2) -> let e_type = expr m ent e1 and e_num = expr m ent e2 in 
      if (e_type != Color && e_type != Vector) 
        then raise (Failure ("Can only access Color and Vector types, not " ^ string_of_typ e_type))
      else 
        if (e_num != Int) then raise (Failure ("Expecting Integer for access index, got " ^ string_of_typ e_num))
        else Int

    | Assign (e1,e2) as ex-> let t1 = expr m ent e1 and t2 = expr m ent e2 in
      if t1 == t2 then t1 else raise (Failure ("illegal assignment " ^ string_of_typ t1 ^
             " = " ^ string_of_typ t2 ^ " in " ^ 
             string_of_expr ex))

    | Access(name,prop) -> 
      if name = "self"
        then
          let availProps = StringMap.find ent allEntMembers in
          type_of_identifier availProps prop;
      else
          if (StringMap.mem name m) then raise (Failure ("Cannot access " ^ name))
          else raise (Failure ("Undeclared identifier " ^ name))
   in

  (* check if types in a varinit statement match *)
  let checkVarInit m ent  = function
    VarInit(t,n,e) -> let e_typ = expr m ent e in
      if t != e_typ 
      then raise (Failure ("expected type " ^ string_of_typ t ^ ", not " ^ string_of_expr e ^ " of type " ^ string_of_typ e_typ))
       else ()
  in

  (* check if given expression is of type boolean *)
  let checkBoolExpr e m ent  = if expr m ent  e != Bool
       then raise (Failure ("expected Boolean expression in " ^ string_of_expr e))
       else () 
  in

  (* check statements *)
  let rec stmt m ent = function
    Block sl -> let rec checkBlock = function
         [Return _ as s] -> stmt m ent s
       | Return _ :: _ -> raise (Failure "nothing may follow a return")
       | Block sl :: ss -> checkBlock (sl @ ss)
       | s :: ss -> stmt m ent s ; checkBlock ss
       | [] -> ()
      in checkBlock sl
    | Expr e -> ignore (expr m ent e)
    | If(p, b1, b2) -> checkBoolExpr p m ent ; stmt m ent  b1; stmt m ent  b2
    | While(p, s) -> checkBoolExpr p m ent ; stmt m ent  s
    | Return e -> () 

  in

  (* add variable to a map *)
  let var m (VarInit(t, n, e)) = StringMap.add n t m in

  (*** CHECK FUNC DECLS ***)

  let checkReturnStmt func m =  function
    Return e -> let t = (expr m "" e) in if t = func.typ then () else
     raise (Failure ("Return gives " ^ string_of_typ t ^ " expected " ^
                     string_of_typ func.typ ^ " in " ^ string_of_expr e))  
    | _ -> raise (Failure ("Function must end with return statement"))
  in

  let checkFunc func =

    (* check for duplicate formals *)
    reportDuplicate (fun n -> "Duplicate formal " ^ n ^ " in " ^ func.fname)
      (List.map snd func.formals);

    (* check for duplicate locals *)
    reportDuplicate (fun n -> "Duplicate local " ^ n ^ " in " ^ func.fname)
      (List.map varDeclName func.locals);

    (* build map of in-scope variables *)
    let formal_var m (t, n) = StringMap.add n t m in 
    let symbols = List.fold_left var StringMap.empty func.locals in 
    let symbols = List.fold_left formal_var symbols func.formals in

    (* check function locals *)
    List.iter (checkVarInit symbols "" ) func.locals;

    (* check function statements *)
    stmt symbols "" (Block func.body);

    (* make sure the last statement is a return and that it is the correct type *)
    let rev_statements = List.rev func.body in
    let getReturnStmt = function x::_ -> x | _ -> raise (Failure "Empty function") in
    let return_stmt = getReturnStmt rev_statements in
    checkReturnStmt func symbols return_stmt;
  
  in

  List.iter checkFunc funcdecls;

  (* check if a given member type exists *)
  let checkMemExists s t m = 
    try 
      let myT = StringMap.find s m 
      in
      if myT != t then raise (Failure ("Inconsistent types"))
     with Not_found -> raise (Failure ("You haven't defined " ^ s))
  in
  
  (* check the statements within events *)
  let checkOccurence = function 
    KeyPress (code) -> if (not (code = "key_UP" || code = "key_DOWN" || code = "key_LEFT" || code = "key_RIGHT" || code = "key_W" || code = "key_A" || code = "key_S" || code = "key_D" || code = "key_SPACE")) then raise (Failure (code ^ " is an undefined keypress type"))
  | Collision (slf, othr) -> 
      if (slf = "self" ) then () else raise (Failure ("must define collisions against self, not " ^ slf));
      if not (StringMap.mem othr allEntMembers) then 
            raise (Failure(othr ^ " is not a defined entity"));
  | Frame -> ()
  | Click -> ()
  | _ -> raise (Failure ("Not a valid entity event"))

  in

  let checkEvent ent = function 
    Event (occurence, _, bhvr) ->
       checkOccurence occurence;
       stmt StringMap.empty ent (Block bhvr)
  in

  (*** CHECK ENT DECLS ***)
  let getEntName e = e.ename in
   reportDuplicate (fun n -> "Duplicate entity " ^ n)
      (List.map getEntName entdecls);  

  (* check for required members, check member types, check event statements *)
  let checkEntDecl e = 
    let myMems = memTypes e.members in
      checkMemExists "clr" Color myMems;
      checkMemExists "size" Vector myMems;

    (* check for duplicate members *)
    reportDuplicate (fun n -> "Duplicate member " ^ n ^ " in " ^ e.ename)
      (List.map varDeclName e.members);

    (* build a symbols map - variables within scope *)
    let symbols =  List.fold_left var StringMap.empty e.members in 

    (* run checks *)
    List.iter (checkVarInit symbols e.ename) e.members;
  	List.iter (checkEvent e.ename) e.rules ;
  in
  List.iter checkEntDecl entdecls;

  (*** CHECK GAMEBOARD DECL ***)

  let checkGbDecl gb = 

    (* check required members clr and size *)
    let myMems = memTypes gb.gmembers in 
      checkMemExists "clr" Color myMems;
      checkMemExists "size" Vector myMems;

    (* check for duplicate members *)
    reportDuplicate (fun n -> "Duplicate member " ^ n ^ " in " ^ gb.gname)
      (List.map varDeclName gb.gmembers);

    (* build a symbols map - variables within scope *)
    let symbols =  List.fold_left var StringMap.empty gb.gmembers in

    (* check members *)
    List.iter (checkVarInit symbols "" ) gb.gmembers;

    (* check for duplicate init members *)
    reportDuplicate (fun n -> "Duplicate init function member " ^ n ^ " in " ^ gb.gname)
      (List.map varDeclName gb.init_mem);

    (* check init members and add to symbols list *)
    let symbols =  List.fold_left var symbols gb.init_mem in
    List.iter (checkVarInit symbols "") gb.init_mem;

    (* check init body *)
    stmt symbols "" (Block gb.init_body);
  in 
  checkGbDecl gboard;
