type op = Add | Sub | Mult | Div | Equal | Neq | Less | Leq | Greater | Geq | And | Or | Mod | Coll
type uop = Neg | Not
type typ = Int | Float | Bool | Color | Vector

type expr = Literal of int
		| FLiteral of float
		| BoolLit of bool
		| Clr of expr * expr * expr
		| Vec of expr * expr 
		| Id of string
		| Binop of expr * op * expr
		| Assign of expr * expr
		| Access of string * string (* p.name *)
		| ArrayAccess of expr * expr (*p[0]*)
		| Unop of uop * expr
		| Call of string * expr list
		| Noexpr (*do we use this?*)

type stmt = Block of stmt list
		| If of expr * stmt * stmt
		| While of expr * stmt
		| Expr of expr
		| Return of expr

type var_decl = VarInit of typ * string * expr

type event = Event of expr * stmt list

type bind = typ * string

type func_decl = {
	typ : typ;
	fname : string;
	formals : bind list;
	locals : var_decl list;
	body : stmt list;
}


type ent_decl = {
	ename : string;
	members : var_decl list;
}

type game_decl = {
	gname : string;
	members : var_decl list;
	init : stmt list;
}

type rules_decl = {
	events : event list;
}

type program = var_decl list * func_decl list * ent_decl list * game_decl * rules_decl


let string_of_op = function
    Add -> "+"
  | Sub -> "-"
  | Mult -> "*"
  | Div -> "/"
  | Equal -> "=="
  | Neq -> "!="
  | Less -> "<"
  | Leq -> "<="
  | Greater -> ">"
  | Geq -> ">="
  | And -> "&&"
  | Or -> "||"
  | Mod -> "%"
  | Coll -> "><"

let string_of_uop = function
    Neg -> "-"
  | Not -> "!"

let rec string_of_expr = function
    Literal(l) -> string_of_int l
  | FLiteral(f) -> string_of_float f
  | BoolLit(true) -> "true"
  | BoolLit(false) -> "false"
  | Id(s) -> s
  | Binop(e1, o, e2) ->
      string_of_expr e1 ^ " " ^ string_of_op o ^ " " ^ string_of_expr e2
  | Unop(o, e) -> string_of_uop o ^ string_of_expr e
  | Assign(v, e) -> string_of_expr v ^ " = " ^ string_of_expr e
  | Access(v, e) -> v ^ "." ^ e
  | ArrayAccess(e1,e2) -> string_of_expr e1 ^ "[" ^ string_of_expr e2^ "]"
  | Call(f, el) ->
      f ^ "(" ^ String.concat ", " (List.map string_of_expr el) ^ ")"
  | Noexpr -> ""
  | Clr(e1,e2,e3) -> "(" ^ string_of_expr e1 ^ ", " ^ string_of_expr e1 ^ ", " ^ string_of_expr e1 ^ ")"
  | Vec(e1,e2) -> "(" ^ string_of_expr e1 ^ ", " ^ string_of_expr e1 ^ ")"

let rec string_of_stmt = function
    Block(stmts) ->
      "{\n" ^ String.concat "" (List.map string_of_stmt stmts) ^ "}\n"
  | Expr(expr) -> string_of_expr expr ^ ";\n";
  | Return(expr) -> "return " ^ string_of_expr expr ^ ";\n";
  | If(e, s, Block([])) -> "if (" ^ string_of_expr e ^ ")\n" ^ string_of_stmt s
  | If(e, s1, s2) ->  "if (" ^ string_of_expr e ^ ")\n" ^
      string_of_stmt s1 ^ "else\n" ^ string_of_stmt s2
  | While(e, s) -> "while (" ^ string_of_expr e ^ ") " ^ string_of_stmt s

let string_of_typ = function
    Int -> "int"
  | Float -> "float" 
  | Bool -> "bool"
  | Color -> "color"
  | Vector -> "vec"

let string_of_vdecl = function
	VarInit(tt, str, e1) -> string_of_typ tt ^ " " ^ str ^ " = " ^ string_of_expr e1 ^ ";\n"

let string_of_fdecl fdecl =
  string_of_typ fdecl.typ ^ " " ^
  fdecl.fname ^ "(" ^ String.concat ", " (List.map snd fdecl.formals) ^
  ")\n{\n" ^
  String.concat "" (List.map string_of_vdecl fdecl.locals) ^
  String.concat "" (List.map string_of_stmt fdecl.body) ^
  "}\n"

let string_of_entdecl edecl =
	"entity " ^ edecl.ename ^ " " ^
	"{\n" ^
	String.concat "" (List.map string_of_vdecl edecl.members) ^ 
	"}\n"

let string_of_gboard gdecl =
	"gameboard " ^ gdecl.gname ^ " " ^
	"{\n" ^
	String.concat "" (List.map string_of_vdecl gdecl.members) ^
	"init -> " ^ String.concat "" (List.map string_of_stmt gdecl.init) ^
	"}\n"

let string_of_event  = function
	Event(e,a) ->  string_of_expr e ^ " -> " ^
	 String.concat "" (List.map string_of_stmt a) ^ "\n"

let string_of_rules rdecl = 
	String.concat "" (List.map string_of_event rdecl.events)

let string_of_program (vars, funcs, ents, game, rules) =
  String.concat "" (List.map string_of_vdecl vars) ^ "\n" ^
  String.concat "\n" (List.map string_of_fdecl funcs) ^
  String.concat "" (List.map string_of_entdecl ents) ^
  string_of_gboard game ^ string_of_rules rules ^ "\n"
