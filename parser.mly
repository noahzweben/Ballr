%{ open Ast %}

%token LBRACE RBRACE COMMA LPAREN RPAREN PLUS MINUS TIMES DIVIDE MOD
%token ASSIGN GT LT ISEQ NEQ LEQ GEQ AND OR NOT PERIOD TRUE FALSE IF ELSE 
%token WHILE INT BOOL FLOAT COLOR VECTOR GBOARD ENT RULES FUNCTION RETURN 
%token DO COLLIDE EOF SEMI CLR MOV SIZE INIT FUNC

%token <float> FLOAT_LITERAL
%token <int> INT_LITERAL
%token <string> ID

%nonassoc NOELSE
%nonassoc ELSE
%right ASSIGN
%left OR
%left AND
%left ISEQ NEQ 
%left LT GT LEQ GEQ
%left COLLIDE
%left PLUS MINUS
%left TIMES DIVIDE MOD
%right NOT NEG
%left ACCESS

%start program
%type < Ast.expr> program

%%
/* QUESTIONS: time? vec/clr assignment? */

program:	
		var_decl_list func_decl_list ent_decl_list gboard rules EOF         
        { ($1, $2, $3, $4, $5) }

prim_type:
        INT 		{ Int }
        | FLOAT 	{ Float }
        | BOOL 		{ Bool }
        | COLOR		{ Color}
        | VECTOR 	{ Vector }

/*arg: prim_type ID 	{  } UNSURE IF NECESSARY */

var_decl_list: 	/* nothing */               	{ [] }
        		| var_decl_list var_decl 		{ $2 :: $1 }

var_decl: prim_type ID ASSIGN expr SEMI 		{ VarInit($1, $2, $4) }

func_decl_list:
        /* nothing */                       	{ [] }
        | func_decl_list func_decl 				{ $2 :: $1 }

func_decl:
        FUNC prim_type ID LPAREN formal_list_opt RPAREN LBRACE var_decl_list stmt_list RBRACE
        { {    
                typ = $2;
				fname = $3;
				formals = $5;
				locals = List.rev $8;
				body = List.rev $9;  
        } }

formal_list_opt:
        /* nothing */                           { [] }
        | formal_list                           { List.rev $1 }

formal_list:
        prim_type ID                            { [($1, $2)] }
        | formal_list COMMA prim_type ID        { ($3, $4) :: $1 }


ent_decl_list: 
		/* nothing */               			{ [] }
        | ent_decl_list ent_decl 				{ $2 :: $1 }

ent_decl: 
		ENT ID LBRACE property_list RBRACE   	
		{ { 	
			ename = $2;
			members = List.rev $4;
		} }

property_list:
	    /* nothing */                       	{ [] }
        | property_list property 				{ $2 :: $1 }	

property:
		var_decl 								{ $1 }
		| CLR ASSIGN expr SEMI 					{ VarInit(Color, "clr", $3) } /*****************/
		| SIZE ASSIGN expr SEMI					{ VarInit(Vector, "size", $3) } /*****************/
		| MOV ASSIGN expr SEMI 					{ VarInit(Vector, "mov", $3) } /*****************/

gboard:
		GBOARD ID LBRACE property_list INIT DO LBRACE stmt_list RBRACE RBRACE 	
		{{
			gname = $2;
			members = List.rev $4;
			init = List.rev $8;
		}}

rules:
	 	RULES LBRACE event_list RBRACE
	 	{{ 
	 		events = List.rev $3 
	 	}}

event_list: 
	    /* nothing */                       	{ [] }
        | event_list event						{ $2 :: $1 }	

event: 
		expr DO LBRACE stmt_list RBRACE 		{ Event($1, List.rev $4) }

stmt_list: 
	    /* nothing */                       	{ [] }
        | stmt_list stmt						{ $2 :: $1 }			

stmt:
	expr SEMI 									{ Expr $1 }
	| RETURN expr SEMI 							{ Return $2 }
	| LBRACE stmt_list RBRACE 					{ Block(List.rev $2) }
	| IF LPAREN expr RPAREN stmt  %prec NOELSE 	{ If($3, $5, Block([])) }
	| IF LPAREN expr RPAREN stmt ELSE stmt 		{ If($3, $5, $7) }
	| WHILE LPAREN expr RPAREN stmt 			{ While($3, $5)}

expr: 
	INT_LITERAL 					{ Literal($1) }
	| FLOAT_LITERAL 				{ FLiteral($1) }
	| TRUE							{ BoolLit(true) }
	| FALSE							{ BoolLit(false) }
	| member 						{ $1 } /* Need to fix this somehow*/
	| expr PLUS expr                { Binop($1, Add, $3) }
    | expr MINUS expr               { Binop($1, Sub, $3) }
    | expr TIMES expr 				{ Binop($1, Mult, $3) }
    | expr DIVIDE expr 				{ Binop($1, Div, $3) }
    | expr ISEQ expr 					{ Binop($1, Equal, $3) }
    | expr NEQ expr 				{ Binop($1, Neq, $3) }
    | expr LT expr  				{ Binop($1, Less, $3) }
    | expr LEQ expr  				{ Binop($1, Leq, $3) }
    | expr GT expr 					{ Binop($1, Greater, $3) }
    | expr GEQ expr 				{ Binop($1, Geq, $3) }
    | expr AND expr 				{ Binop($1, And, $3) }
    | expr OR expr 					{ Binop($1, Or, $3) }
    | expr MOD expr 				{ Binop($1, Mod, $3) }
    | expr COLLIDE expr 			{ Binop($1, Coll, $3) }
    | NOT expr  					{ Unop(Not, $2) }
    | MINUS expr %prec NEG 			{ Unop(Neg, $2) }
    | LPAREN expr RPAREN 			{ $2 }
    | ID LPAREN actuals_opt RPAREN 	{ Call($1, $3) }
    | member ASSIGN expr 			{ Assign($1, $3)}
    | LPAREN expr COMMA expr RPAREN 			{ Vec($2, $4) }
    | LPAREN expr COMMA expr COMMA expr RPAREN  { Clr($2, $4, $6) }

member:
	ID  				{ Id($1) } /*check with Julie */
	| ID PERIOD member  { Access($1, $3) }

actuals_opt:
	/* nothing */ {[]}
	| actuals_list { List.rev $1}

actuals_list:
	expr 	{[$1]}
	| actuals_list COMMA expr { $3 :: $1 }

