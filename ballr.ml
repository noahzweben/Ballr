open Printf

type action = Ast | LLVM_IR | Compile

let _ =
  let action = 
  if Array.length Sys.argv > 1 then 
    List.assoc Sys.argv.(1) [ ("-a", Ast);	(* Print the AST only *)
			                        ("-l", LLVM_IR);  (* Generate LLVM, don't check *)
			                        ("-c", Compile) ] (* Generate, check LLVM IR *)
  else 
    Compile
  in
  let (ic, oc, exec_name) = 
  if Array.length Sys.argv > 2 then 
    let in_f = Sys.argv.(2) in
    let i = (try String.rindex in_f '.' with Not_found -> String.length in_f) in
    let exec_name = String.sub in_f 0 i in
    let out_f = exec_name ^ ".ll" in
    (open_in in_f, open_out out_f, exec_name)
  else 
    (stdin, stdout, "")
  in
  let lexbuf = Lexing.from_channel ic in
  let ast = Parser.program Scanner.token lexbuf in
  Semant.check ast;
    match action with
    Ast -> print_string (Ast.string_of_program ast)
  | LLVM_IR -> print_string (Llvm.string_of_llmodule (Codegen.translate ast))
  | Compile -> let m = Codegen.translate ast in
    Llvm_analysis.assert_valid_module m;
    fprintf oc "%s\n" (Llvm.string_of_llmodule m);
    close_out oc;
    if exec_name != "" then
      let cmd = "clang -c " ^ exec_name ^ ".ll && clang -g " ^ exec_name ^ ".o -o " ^ exec_name ^ " -L/usr/local/lib -Wl,-rpath,/usr/local/lib -Wl,--enable-new-dtags -lSDL2 -lblr_rt" in
      print_string (cmd ^ "\n");
      ignore (Sys.command cmd)
    else ()

