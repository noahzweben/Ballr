
type action = Ast 

let _ =
  let action = if Array.length Sys.argv > 1 then
    List.assoc Sys.argv.(1) [ ("-a", Ast);]
  else Ast in
  let lexbuf = Lexing.from_channel stdin in
  let ast = Parser.program Scanner.token lexbuf in
  match action with
    Ast -> print_string (Ast.string_of_program ast)
  