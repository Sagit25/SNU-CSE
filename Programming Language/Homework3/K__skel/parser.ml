type token =
  | UNIT
  | NUM of (int)
  | TRUE
  | FALSE
  | ID of (string)
  | PLUS
  | MINUS
  | STAR
  | SLASH
  | EQUAL
  | LB
  | RB
  | LBLOCK
  | RBLOCK
  | NOT
  | COLONEQ
  | SEMICOLON
  | COMMA
  | PERIOD
  | IF
  | THEN
  | ELSE
  | END
  | WHILE
  | DO
  | LET
  | IN
  | READ
  | WRITE
  | PROC
  | LP
  | RP
  | LC
  | RC
  | EOF

open Parsing;;
let _ = parse_error;;
# 8 "parser.mly"
       
type declLet = string * K.K.exp

exception EmptyBinding
exception ParsingError
let rec desugarLet: declLet * K.K.exp -> K.K.exp  =
  fun (l, e) -> 
  	match l with
		(x, e') -> K.K.LETV(x,e',e)
let rec desugarVars: declLet list -> (K.K.id * K.K.exp) list =
  fun l ->
  	match l with
	  [] -> []
   | a::r -> 
     (match a with
        (x, e') -> (x,e')::(desugarVars r)
     )

# 60 "parser.ml"
let yytransl_const = [|
  257 (* UNIT *);
  259 (* TRUE *);
  260 (* FALSE *);
  262 (* PLUS *);
  263 (* MINUS *);
  264 (* STAR *);
  265 (* SLASH *);
  266 (* EQUAL *);
  267 (* LB *);
  268 (* RB *);
  269 (* LBLOCK *);
  270 (* RBLOCK *);
  271 (* NOT *);
  272 (* COLONEQ *);
  273 (* SEMICOLON *);
  274 (* COMMA *);
  275 (* PERIOD *);
  276 (* IF *);
  277 (* THEN *);
  278 (* ELSE *);
  279 (* END *);
  280 (* WHILE *);
  281 (* DO *);
  282 (* LET *);
  283 (* IN *);
  284 (* READ *);
  285 (* WRITE *);
  286 (* PROC *);
  287 (* LP *);
  288 (* RP *);
  289 (* LC *);
  290 (* RC *);
    0 (* EOF *);
    0|]

let yytransl_block = [|
  258 (* NUM *);
  261 (* ID *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
\002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
\002\000\002\000\002\000\002\000\002\000\002\000\002\000\004\000\
\003\000\005\000\005\000\000\000"

let yylen = "\002\000\
\002\000\003\000\001\000\002\000\001\000\001\000\001\000\002\000\
\001\000\003\000\003\000\003\000\003\000\003\000\003\000\002\000\
\003\000\003\000\006\000\004\000\004\000\002\000\002\000\003\000\
\001\000\001\000\003\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\003\000\005\000\006\000\007\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\028\000\
\000\000\000\000\004\000\016\000\000\000\000\000\000\000\000\000\
\025\000\022\000\000\000\008\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\001\000\000\000\000\000\000\000\
\000\000\000\000\002\000\000\000\000\000\012\000\013\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000"

let yydgoto = "\002\000\
\016\000\017\000\024\000\025\000\000\000"

let yysindex = "\255\255\
\001\255\000\000\000\000\000\000\000\000\000\000\247\254\007\255\
\001\255\001\255\001\255\012\255\015\255\001\255\051\255\000\000\
\122\000\001\255\000\000\000\000\134\255\094\255\010\255\252\254\
\000\000\000\000\162\255\000\000\082\255\001\255\001\255\001\255\
\001\255\001\255\001\255\001\255\000\000\162\255\001\255\001\255\
\001\255\001\255\000\000\003\255\003\255\000\000\000\000\041\255\
\041\255\162\255\117\255\162\255\150\255\150\255\001\255\162\255"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\001\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\024\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\060\000\000\000\000\000\
\000\000\000\000\000\000\010\000\033\000\000\000\000\000\042\000\
\051\000\069\000\000\000\078\000\004\255\095\000\000\000\087\000"

let yygindex = "\000\000\
\000\000\004\000\000\000\000\000\000\000"

let yytablesize = 395
let yytable = "\001\000\
\009\000\003\000\004\000\005\000\006\000\007\000\018\000\008\000\
\019\000\010\000\032\000\033\000\020\000\021\000\022\000\009\000\
\023\000\027\000\029\000\026\000\010\000\038\000\042\000\023\000\
\011\000\041\000\012\000\000\000\013\000\014\000\024\000\015\000\
\011\000\044\000\045\000\046\000\047\000\048\000\049\000\050\000\
\000\000\014\000\051\000\052\000\053\000\054\000\030\000\031\000\
\032\000\033\000\015\000\003\000\004\000\005\000\006\000\007\000\
\000\000\008\000\056\000\017\000\000\000\000\000\000\000\000\000\
\000\000\009\000\000\000\000\000\018\000\000\000\010\000\000\000\
\000\000\000\000\011\000\000\000\012\000\020\000\013\000\014\000\
\000\000\015\000\028\000\000\000\000\000\000\000\019\000\030\000\
\031\000\032\000\033\000\034\000\035\000\000\000\021\000\000\000\
\000\000\000\000\036\000\030\000\031\000\032\000\033\000\034\000\
\035\000\000\000\000\000\000\000\000\000\000\000\036\000\000\000\
\000\000\043\000\000\000\000\000\000\000\000\000\040\000\000\000\
\000\000\037\000\030\000\031\000\032\000\033\000\034\000\035\000\
\000\000\000\000\000\000\000\000\000\000\036\000\000\000\000\000\
\000\000\000\000\055\000\030\000\031\000\032\000\033\000\034\000\
\035\000\000\000\000\000\000\000\000\000\000\000\036\000\000\000\
\000\000\000\000\039\000\030\000\031\000\032\000\033\000\034\000\
\035\000\000\000\000\000\000\000\000\000\000\000\036\000\030\000\
\031\000\032\000\033\000\034\000\035\000\000\000\000\000\000\000\
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
\000\000\000\000\000\000\000\000\000\000\000\000\009\000\009\000\
\009\000\009\000\009\000\009\000\000\000\000\000\000\000\010\000\
\010\000\009\000\000\000\010\000\010\000\009\000\009\000\000\000\
\000\000\009\000\010\000\009\000\000\000\000\000\010\000\010\000\
\009\000\000\000\010\000\000\000\010\000\000\000\011\000\011\000\
\023\000\010\000\011\000\011\000\023\000\023\000\000\000\000\000\
\023\000\011\000\023\000\014\000\014\000\011\000\011\000\023\000\
\000\000\011\000\014\000\011\000\015\000\015\000\014\000\014\000\
\011\000\000\000\014\000\015\000\014\000\000\000\000\000\015\000\
\015\000\014\000\000\000\015\000\017\000\015\000\000\000\000\000\
\017\000\017\000\015\000\000\000\017\000\018\000\017\000\000\000\
\000\000\018\000\018\000\017\000\000\000\018\000\020\000\018\000\
\000\000\000\000\020\000\020\000\018\000\000\000\020\000\019\000\
\020\000\000\000\000\000\019\000\019\000\020\000\000\000\019\000\
\000\000\019\000\000\000\021\000\021\000\000\000\019\000\021\000\
\000\000\021\000\000\000\000\000\000\000\000\000\021\000\030\000\
\031\000\032\000\033\000\034\000\035\000\000\000\000\000\000\000\
\000\000\000\000\036\000"

let yycheck = "\001\000\
\000\000\001\001\002\001\003\001\004\001\005\001\016\001\007\001\
\002\001\000\000\008\001\009\001\009\000\010\000\011\000\015\001\
\005\001\014\000\015\000\005\001\020\001\018\000\027\001\000\000\
\024\001\016\001\026\001\255\255\028\001\029\001\027\001\031\001\
\000\000\030\000\031\000\032\000\033\000\034\000\035\000\036\000\
\255\255\000\000\039\000\040\000\041\000\042\000\006\001\007\001\
\008\001\009\001\000\000\001\001\002\001\003\001\004\001\005\001\
\255\255\007\001\055\000\000\000\255\255\255\255\255\255\255\255\
\255\255\015\001\255\255\255\255\000\000\255\255\020\001\255\255\
\255\255\255\255\024\001\255\255\026\001\000\000\028\001\029\001\
\255\255\031\001\032\001\255\255\255\255\255\255\000\000\006\001\
\007\001\008\001\009\001\010\001\011\001\255\255\000\000\255\255\
\255\255\255\255\017\001\006\001\007\001\008\001\009\001\010\001\
\011\001\255\255\255\255\255\255\255\255\255\255\017\001\255\255\
\255\255\032\001\255\255\255\255\255\255\255\255\025\001\255\255\
\255\255\000\000\006\001\007\001\008\001\009\001\010\001\011\001\
\255\255\255\255\255\255\255\255\255\255\017\001\255\255\255\255\
\255\255\255\255\022\001\006\001\007\001\008\001\009\001\010\001\
\011\001\255\255\255\255\255\255\255\255\255\255\017\001\255\255\
\255\255\255\255\021\001\006\001\007\001\008\001\009\001\010\001\
\011\001\255\255\255\255\255\255\255\255\255\255\017\001\006\001\
\007\001\008\001\009\001\010\001\011\001\255\255\255\255\255\255\
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
\255\255\255\255\255\255\255\255\255\255\255\255\006\001\007\001\
\008\001\009\001\010\001\011\001\255\255\255\255\255\255\006\001\
\007\001\017\001\255\255\010\001\011\001\021\001\022\001\255\255\
\255\255\025\001\017\001\027\001\255\255\255\255\021\001\022\001\
\032\001\255\255\025\001\255\255\027\001\255\255\006\001\007\001\
\017\001\032\001\010\001\011\001\021\001\022\001\255\255\255\255\
\025\001\017\001\027\001\010\001\011\001\021\001\022\001\032\001\
\255\255\025\001\017\001\027\001\010\001\011\001\021\001\022\001\
\032\001\255\255\025\001\017\001\027\001\255\255\255\255\021\001\
\022\001\032\001\255\255\025\001\017\001\027\001\255\255\255\255\
\021\001\022\001\032\001\255\255\025\001\017\001\027\001\255\255\
\255\255\021\001\022\001\032\001\255\255\025\001\017\001\027\001\
\255\255\255\255\021\001\022\001\032\001\255\255\025\001\017\001\
\027\001\255\255\255\255\021\001\022\001\032\001\255\255\025\001\
\255\255\027\001\255\255\021\001\022\001\255\255\032\001\025\001\
\255\255\027\001\255\255\255\255\255\255\255\255\032\001\006\001\
\007\001\008\001\009\001\010\001\011\001\255\255\255\255\255\255\
\255\255\255\255\017\001"

let yynames_const = "\
  UNIT\000\
  TRUE\000\
  FALSE\000\
  PLUS\000\
  MINUS\000\
  STAR\000\
  SLASH\000\
  EQUAL\000\
  LB\000\
  RB\000\
  LBLOCK\000\
  RBLOCK\000\
  NOT\000\
  COLONEQ\000\
  SEMICOLON\000\
  COMMA\000\
  PERIOD\000\
  IF\000\
  THEN\000\
  ELSE\000\
  END\000\
  WHILE\000\
  DO\000\
  LET\000\
  IN\000\
  READ\000\
  WRITE\000\
  PROC\000\
  LP\000\
  RP\000\
  LC\000\
  RC\000\
  EOF\000\
  "

let yynames_block = "\
  NUM\000\
  ID\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 56 "parser.mly"
                ( _1 )
# 300 "parser.ml"
               : K.K.exp))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 60 "parser.mly"
                 ( _2 )
# 307 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 61 "parser.mly"
        (K.K.UNIT)
# 313 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 62 "parser.mly"
                ( K.K.NUM (-_2) )
# 320 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 63 "parser.mly"
          ( K.K.NUM (_1) )
# 327 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 64 "parser.mly"
           ( K.K.TRUE )
# 333 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 65 "parser.mly"
            ( K.K.FALSE )
# 339 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 66 "parser.mly"
            ( K.K.UNIT )
# 345 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 67 "parser.mly"
         ( K.K.VAR (_1) )
# 352 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 68 "parser.mly"
                     ( K.K.ADD (_1, _3) )
# 360 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 69 "parser.mly"
                       (K.K.SUB (_1,_3) )
# 368 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 70 "parser.mly"
                     ( K.K.MUL (_1,_3) )
# 376 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 71 "parser.mly"
                      ( K.K.DIV (_1,_3) )
# 384 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 72 "parser.mly"
                      ( K.K.EQUAL (_1,_3) )
# 392 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 73 "parser.mly"
                   ( K.K.LESS (_1,_3) )
# 400 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 74 "parser.mly"
               ( K.K.NOT (_2) )
# 407 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 75 "parser.mly"
                      ( K.K.ASSIGN (_1,_3) )
# 415 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 76 "parser.mly"
                          ( K.K.SEQ (_1,_3) )
# 423 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 77 "parser.mly"
                                  ( K.K.IF (_2, _4, _6) )
# 432 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 78 "parser.mly"
                         ( K.K.WHILE (_2, _4) )
# 440 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'decl) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 79 "parser.mly"
                       ( desugarLet(_2, _4) )
# 448 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 80 "parser.mly"
              ( K.K.READ (_2) )
# 455 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 81 "parser.mly"
                 ( K.K.WRITE (_2) )
# 462 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 83 "parser.mly"
                         ( (_1, _3) )
# 470 "parser.ml"
               : 'vardecl))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'vardecl) in
    Obj.repr(
# 85 "parser.mly"
              ( _1 )
# 477 "parser.ml"
               : 'decl))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 87 "parser.mly"
            ( [_1] )
# 484 "parser.ml"
               : 'exprs))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'exprs) in
    Obj.repr(
# 88 "parser.mly"
                    ( _1::_3 )
# 492 "parser.ml"
               : 'exprs))
(* Entry program *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let program (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : K.K.exp)
;;
