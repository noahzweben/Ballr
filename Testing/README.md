generate a list of tokens using:

./maketokens < helloworld.blr

then plug that list of tokens into

 menhir --interpret --interpret-show-cst parser.mly


and check AST / accept vs reject etc


If you change test_scanner.mll run
ocamllex test_scanner.mll
ocamlc -o maketokens test_scanner.ml