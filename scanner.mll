{ open Parser }

rule token = parse
	[' ' '\t' '\r' '\n'] { token lexbuf } (* Whitespace *)
 	| "/*"     { comment lexbuf } 
 	| '{'	{ LBRACE }			
	| '}'	{ RBRACE }
	| ','	{ COMMA }
	| '('	{ LPAREN }			
	| ')'	{ RPAREN }
	| ';'	{ SEMI }
	| '+'	{ PLUS }				
	| '-'	{ MINUS }			
	| '*'	{ TIMES }
	| '/'	{ DIVIDE }				
	| '%'	{ MOD }
	| '=' 	{ ASSIGN }
	| '>'	{ GT }					
	| '<'	{ LT }
	| "=="	{ ISEQ }				
	| "!="	{ NEQ }					
	| "<="	{ LEQ }
	| ">="	{ GEQ }
	| "&&"	{ AND }			
	| "||"	{ OR }
	| "!"	{ NOT }
	| "."	{ PERIOD }
	| "true" { TRUE }
	| "false" { FALSE }
	| "if"   { IF }
	| "else" { ELSE }
	| "while" { WHILE }
	| "int"   { INT }
	| "bool"  { BOOL }
	| "float" { FLOAT }
	| "color"  { COLOR }
	| "vec"		{ VECTOR}
	| "gameboard" { GBOARD }
 	| "entity"	  { ENT }
 	| "rules" { RULES }
 	| "func"  { FUNCTION }
 	| "return" { RETURN }
 	| "init"	{ INIT }
 	| "clr"		{ CLR }
 	| "size" 	{ SIZE }
 	| "mov" 	{ MOV }
 	| "->"    { DO }
 	| "><"    { COLLIDE }
 	| ['0'-'9']*'.'['0'-'9']+ | ['0'-'9']+'.'['0'-'9']* as lxm { FLOAT_LITERAL(float_of_string lxm)}
	| ['0'-'9']+ as lxm { INT_LITERAL(int_of_string lxm) }
	| ['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_']* as lxm { ID(lxm) }
	| eof 	{ EOF }
	| _ as char { raise (Failure("illegal character " ^ Char.escaped char)) }


and comment = parse
  "*/" { token lexbuf }
| _    { comment lexbuf }