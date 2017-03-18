type op = Add | Sub | Mult | Div | Equal | Neq | Less | Leq | Greater | Geq | And | Or | Mod | Coll
type uop = Neg | Not
type typ = Int | Float | Bool | Color | Vector
type bind = typ * string


type expr = Literal of int
		| Literal of float
		| BoolLit of bool
		| Clr of int * int * int
		| Vec of int * int 
		| Id of string
		| Binop of expr * op * expr
		| Assign of string * expr
		| Access of string * string (* p.name *)
		| Unop of uop * expr
		| Call of string * expr list
		| Noexpr

type stmt = Block of stmt list
		| If of expr * stmt * stmt
		| While of expr * stmt
		| Expr of expr
		| Return of expr


type event = Event of expr * stmt

type func_decl = {
	typ : typ;
	fname : string;
	formals : bind list;
	locals : bind list;
	body : stmt list;
}

type var_decl = bind * expr

(* should the RHS be Color/Clr/?... *)
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