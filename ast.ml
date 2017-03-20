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

type func_decl = {
	typ : typ;
	fname : string;
	formals : typ * string list;
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
