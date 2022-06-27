# 7 "lexer.mll"
 
 open Parser
 exception Lex_err of string
 let debug_tag = false
 let verbose s =  if debug_tag then (print_string s; print_newline())
 let comment_depth = ref 0
 let keyword_tbl = Hashtbl.create 31
 let _ = List.iter (fun (keyword, tok) -> Hashtbl.add keyword_tbl keyword tok)
                   [("ifp", IF);
                    ("then",THEN);
                    ("else",ELSE);
                    ("fn", FN);
                    ("rec" , REC);
                  ]
 let s2int = function "" -> raise (Lex_err("illegal number token"))
           | s -> if ('~' = String.get s 0) then
                   - (int_of_string(String.sub s 1 ((String.length s)-1)))
                   else int_of_string s

# 22 "lexer.ml"
let __ocaml_lex_tables = {
  Lexing.lex_base = 
   "\000\000\241\255\242\255\243\255\245\255\247\255\000\000\000\000\
    \250\255\084\000\159\000\169\000\002\000\007\000\249\255\248\255\
    \018\000\250\255\004\000\252\255\253\255\006\000\017\000\255\255\
    \254\255\251\255";
  Lexing.lex_backtrk = 
   "\255\255\255\255\255\255\255\255\255\255\255\255\014\000\011\000\
    \255\255\004\000\003\000\009\000\000\000\000\000\255\255\255\255\
    \255\255\255\255\005\000\255\255\255\255\005\000\005\000\255\255\
    \255\255\255\255";
  Lexing.lex_default = 
   "\001\000\000\000\000\000\000\000\000\000\000\000\255\255\255\255\
    \000\000\255\255\255\255\255\255\255\255\255\255\000\000\000\000\
    \017\000\000\000\255\255\000\000\000\000\255\255\255\255\000\000\
    \000\000\000\000";
  Lexing.lex_trans = 
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\012\000\012\000\012\000\012\000\013\000\025\000\012\000\
    \012\000\012\000\000\000\000\000\012\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\019\000\000\000\000\000\018\000\
    \012\000\000\000\012\000\000\000\000\000\000\000\000\000\012\000\
    \007\000\003\000\014\000\005\000\002\000\011\000\004\000\024\000\
    \010\000\010\000\010\000\010\000\010\000\010\000\010\000\010\000\
    \010\000\010\000\022\000\023\000\021\000\006\000\015\000\000\000\
    \000\000\009\000\009\000\009\000\009\000\009\000\009\000\009\000\
    \009\000\009\000\009\000\009\000\009\000\009\000\009\000\009\000\
    \009\000\009\000\009\000\009\000\009\000\009\000\009\000\009\000\
    \009\000\009\000\009\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\009\000\009\000\009\000\009\000\009\000\009\000\009\000\
    \009\000\009\000\009\000\009\000\009\000\009\000\009\000\009\000\
    \009\000\009\000\009\000\009\000\009\000\009\000\009\000\009\000\
    \009\000\009\000\009\000\009\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\009\000\009\000\009\000\009\000\
    \009\000\009\000\009\000\009\000\009\000\009\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\009\000\009\000\009\000\
    \009\000\009\000\009\000\009\000\009\000\009\000\009\000\009\000\
    \009\000\009\000\009\000\009\000\009\000\009\000\009\000\009\000\
    \009\000\009\000\009\000\009\000\009\000\009\000\009\000\000\000\
    \000\000\000\000\000\000\009\000\000\000\009\000\009\000\009\000\
    \009\000\009\000\009\000\009\000\009\000\009\000\009\000\009\000\
    \009\000\009\000\009\000\009\000\009\000\009\000\009\000\009\000\
    \009\000\009\000\009\000\009\000\009\000\009\000\009\000\010\000\
    \010\000\010\000\010\000\010\000\010\000\010\000\010\000\010\000\
    \010\000\010\000\010\000\010\000\010\000\010\000\010\000\010\000\
    \010\000\010\000\010\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \008\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\020\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000";
  Lexing.lex_check = 
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\000\000\000\000\012\000\012\000\000\000\018\000\012\000\
    \013\000\013\000\255\255\255\255\013\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\016\000\255\255\255\255\016\000\
    \000\000\255\255\012\000\255\255\255\255\255\255\255\255\013\000\
    \000\000\000\000\007\000\000\000\000\000\000\000\000\000\021\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\016\000\022\000\016\000\000\000\006\000\255\255\
    \255\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\255\255\255\255\255\255\255\255\255\255\
    \255\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\009\000\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\009\000\009\000\009\000\009\000\
    \009\000\009\000\009\000\009\000\009\000\009\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\009\000\009\000\009\000\
    \009\000\009\000\009\000\009\000\009\000\009\000\009\000\009\000\
    \009\000\009\000\009\000\009\000\009\000\009\000\009\000\009\000\
    \009\000\009\000\009\000\009\000\009\000\009\000\009\000\255\255\
    \255\255\255\255\255\255\009\000\255\255\009\000\009\000\009\000\
    \009\000\009\000\009\000\009\000\009\000\009\000\009\000\009\000\
    \009\000\009\000\009\000\009\000\009\000\009\000\009\000\009\000\
    \009\000\009\000\009\000\009\000\009\000\009\000\009\000\010\000\
    \010\000\010\000\010\000\010\000\010\000\010\000\010\000\010\000\
    \010\000\011\000\011\000\011\000\011\000\011\000\011\000\011\000\
    \011\000\011\000\011\000\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\016\000\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255";
  Lexing.lex_base_code = 
   "";
  Lexing.lex_backtrk_code = 
   "";
  Lexing.lex_default_code = 
   "";
  Lexing.lex_trans_code = 
   "";
  Lexing.lex_check_code = 
   "";
  Lexing.lex_code = 
   "";
}

let rec start lexbuf =
    __ocaml_lex_start_rec lexbuf 0
and __ocaml_lex_start_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 32 "lexer.mll"
            ( start lexbuf )
# 170 "lexer.ml"

  | 1 ->
# 33 "lexer.mll"
                 ( start lexbuf)
# 175 "lexer.ml"

  | 2 ->
# 34 "lexer.mll"
                 ( start lexbuf)
# 180 "lexer.ml"

  | 3 ->
# 35 "lexer.mll"
             ( NUM (s2int(Lexing.lexeme lexbuf)) )
# 185 "lexer.ml"

  | 4 ->
# 36 "lexer.mll"
         ( let id = Lexing.lexeme lexbuf
           in try Hashtbl.find keyword_tbl id
              with _ -> ID id
         )
# 193 "lexer.ml"

  | 5 ->
# 40 "lexer.mll"
          ( verbose "eof"; EOF)
# 198 "lexer.ml"

  | 6 ->
# 41 "lexer.mll"
           ( comment_depth :=1;
             comment lexbuf;
             start lexbuf )
# 205 "lexer.ml"

  | 7 ->
# 44 "lexer.mll"
           ( verbose "=>"; RARROW)
# 210 "lexer.ml"

  | 8 ->
# 45 "lexer.mll"
          (verbose "+"; PLUS)
# 215 "lexer.ml"

  | 9 ->
# 46 "lexer.mll"
          (verbose "-"; MINUS)
# 220 "lexer.ml"

  | 10 ->
# 47 "lexer.mll"
          (verbose "."; DOT)
# 225 "lexer.ml"

  | 11 ->
# 48 "lexer.mll"
          ( verbose "("; LP)
# 230 "lexer.ml"

  | 12 ->
# 49 "lexer.mll"
          ( verbose ")"; RP)
# 235 "lexer.ml"

  | 13 ->
# 50 "lexer.mll"
          (verbose ","; COMMA)
# 240 "lexer.ml"

  | 14 ->
# 51 "lexer.mll"
        (raise (Lex_err("illical token "^(Lexing.lexeme lexbuf))))
# 245 "lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf; 
      __ocaml_lex_start_rec lexbuf __ocaml_lex_state

and comment lexbuf =
    __ocaml_lex_comment_rec lexbuf 16
and __ocaml_lex_comment_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 54 "lexer.mll"
          (comment_depth := !comment_depth+1; comment lexbuf)
# 257 "lexer.ml"

  | 1 ->
# 55 "lexer.mll"
          (comment_depth := !comment_depth-1;
           if !comment_depth > 0 then comment lexbuf )
# 263 "lexer.ml"

  | 2 ->
# 57 "lexer.mll"
         (raise (Lex_err("Eof within comment")))
# 268 "lexer.ml"

  | 3 ->
# 58 "lexer.mll"
          ( comment lexbuf)
# 273 "lexer.ml"

  | 4 ->
# 59 "lexer.mll"
            ( comment lexbuf)
# 278 "lexer.ml"

  | 5 ->
# 60 "lexer.mll"
         (comment lexbuf)
# 283 "lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf; 
      __ocaml_lex_comment_rec lexbuf __ocaml_lex_state

;;

