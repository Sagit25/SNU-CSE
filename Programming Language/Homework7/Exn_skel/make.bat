ocamlc -c xexp.mli
ocamlc -c xexp.ml
ocamlyacc parser.mly
ocamllex lexer.mll
ocamlc -c parser.mli
ocamlc -c parser.ml
ocamlc -c lexer.ml
ocamlc -c cps.mli
ocamlc -c cps.ml
ocamlc -c main.ml
ocamlc -o run.exe xexp.cmo parser.cmo lexer.cmo cps.cmo main.cmo
