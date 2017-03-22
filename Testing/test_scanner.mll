{}

rule token = parse
	[' ' '\t' '\r' '\n'] { token lexbuf} (* Whitespace *)
 	| "/*"     { comment lexbuf} 
 	| '{'	{ print_string "LBRACE "}			
	| '}'	{ print_string "RBRACE "}
	| '['	{ print_string "LSQUARE "}					
	| ']'	{ print_string "RSQUARE "}
	| ','	{ print_string "COMMA "}
	| '('	{ print_string "LPAREN "}			
	| ')'	{ print_string "RPAREN "}
	| ';'	{ print_string "SEMI "}
	| '+'	{ print_string "PLUS "}				
	| '-'	{ print_string "MINUS "}			
	| '*'	{ print_string "TIMES "}
	| '/'	{ print_string "DIVIDE "}				
	| '%'	{ print_string "MOD "}
	| '=' 	{ print_string "ASSIGN "}
	| '>'	{ print_string "GT "}					
	| '<'	{ print_string "LT "}
	| "=="	{ print_string "ISEQ "}				
	| "!="	{ print_string "NEQ "}					
	| "<="	{ print_string "LEQ "}
	| ">="	{ print_string "GEQ "}
	| "&&"	{ print_string "AND "}			
	| "||"	{ print_string "OR "}
	| "!"	{ print_string "NOT "}
	| "."	{ print_string "PERIOD "}
	| "true" { print_string "TRUE "}
	| "false" { print_string "FALSE "}
	| "if"   { print_string "IF "}
	| "else" { print_string "ELSE "}
	| "while" { print_string "WHILE "}
	| "int"   { print_string "INT "}
	| "bool"  { print_string "BOOL "}
	| "float" { print_string "FLOAT "}
	| "color"  { print_string "COLOR "}
	| "vec"		{ print_string "VECTOR "}
	| "gameboard" { print_string "GBOARD "}
 	| "entity"	  { print_string "ENT "}
 	| "rules" { print_string "RULES "}
 	| "func"  { print_string "FUNC "}
 	| "return" { print_string "RETURN "}
 	| "init"	{ print_string "INIT "}
 	| "clr"		{ print_string "CLR "}
 	| "size" 	{ print_string "SIZE "}
 	| "mov" 	{ print_string "MOV "}
 	| "->"    { print_string "DO "}
 	| "><"    { print_string "COLLIDE "}
 	| "func"  { print_string "FUNC "}
 	| ['0'-'9']*'.'['0'-'9']+ | ['0'-'9']+'.'['0'-'9']* as lxm { print_string "FLOAT_LITERAL "}
	| ['0'-'9']+ as lxm { print_string "INT_LITERAL "}
	| ['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_']* as lxm { print_string "ID "}
	| eof 	{ print_endline "EOF"; exit 0}
	| _ as char {raise (Failure("illegal character " ^ Char.escaped char))}


and comment = parse
  "*/" { token lexbuf }
| _    { comment lexbuf}



{
    let lexbuf = Lexing.from_channel stdin in
    let rec loop =  function
        | x     ->  loop (token lexbuf)
    in
    loop (token lexbuf) 


}