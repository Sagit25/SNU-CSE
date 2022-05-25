(*
 * SNU 4190.310 Programming Languages 
 * K-- to SM5 translator skeleton code
 *)

open K
open Sm5
module Translator = struct
  (* TODO : complete this function  *)
  let rec trans : K.program -> Sm5.command = function
    | K.TRUE -> [Sm5.PUSH (Sm5.Val (Sm5.B true))]
    | K.FALSE -> [Sm5.PUSH (Sm5.Val (Sm5.B false))]
    | K.NUM i -> [Sm5.PUSH (Sm5.Val (Sm5.Z i))]
    | K.UNIT -> [Sm5.PUSH (Sm5.Val (Sm5.Unit))]
    | K.VAR x -> [Sm5.PUSH (Sm5.Id (x))] @ [Sm5.LOAD]
    | K.ADD (e1, e2) -> trans e1 @ trans e2 @ [Sm5.ADD]
    | K.SUB (e1, e2) -> trans e1 @ trans e2 @ [Sm5.SUB]
    | K.MUL (e1, e2) -> trans e1 @ trans e2 @ [Sm5.MUL]
    | K.DIV (e1, e2) -> trans e1 @ trans e2 @ [Sm5.DIV]
    | K.EQUAL (e1, e2) -> trans e1 @ trans e2 @ [Sm5.EQ]
    | K.LESS (e1, e2) -> trans e1 @ trans e2 @ [Sm5.LESS]
    | K.NOT e -> trans e @ [Sm5.NOT] 
    | K.ASSIGN (x, e) -> 
      trans e @ [Sm5.PUSH (Sm5.Id (x)); Sm5.STORE] @ 
      [Sm5.PUSH (Sm5.Id (x)); Sm5.LOAD]
    | K.SEQ (e1, e2) -> trans e1 @ [Sm5.POP] @ trans e2
    | K.IF (e1, e2, e3) -> trans e1 @ [Sm5.JTR (trans e2, trans e3)]
    | K.WHILE (e1, e2) -> 
      let iff = K.IF (K.VAR ("#c"), K.SEQ (e2, K.CALLV ("#w", e1)), K.UNIT) in
      let exp = K.LETF ("#w", "#c", iff, K.CALLV ("#w", e1)) in
      trans exp
    | K.FOR (x, e1, e2, e3) -> 
      let cond = K.NOT (K.LESS (K.VAR ("#n"), K.VAR ("#i"))) in
      let seq = K.SEQ (e3, K.ASSIGN ("#i", K.ADD (K.VAR "#i", K.NUM 1))) in
      let ord = K.SEQ (K.ASSIGN (x, K.VAR ("#i")), seq) in 
      let exp = K.LETV ("#i", e1, K.LETV ("#n", e2, K.WHILE (cond, ord))) in
      trans exp
    | K.LETV (x, e1, e2) ->
      trans e1 @ [Sm5.MALLOC; Sm5.BIND x] @ 
      [Sm5.PUSH (Sm5.Id x); Sm5.STORE] @
      trans e2 @ [Sm5.UNBIND; Sm5.POP]
    | K.LETF (f, x, e1, e2) ->
      [Sm5.PUSH (Sm5.Fn (x, [Sm5.BIND f] @ trans e1))] @ 
      [Sm5.BIND f] @ trans e2 @ [Sm5.UNBIND] @ [Sm5.POP]
    | K.CALLV (x, e) -> 
      [Sm5.PUSH (Sm5.Id (x))] @ [Sm5.PUSH (Sm5.Id (x))] @
      trans e @ [Sm5.MALLOC; Sm5.CALL]
    | K.CALLR (f, x) ->
      [Sm5.PUSH (Sm5.Id (f))] @ [Sm5.PUSH (Sm5.Id (f))] @
      [Sm5.PUSH (Sm5.Id (x))] @ [Sm5.LOAD] @ [Sm5.PUSH (Sm5.Id (x))] @
      [Sm5.CALL]
    | K.READ x -> [Sm5.GET; Sm5.PUSH (Sm5.Id x); Sm5.STORE; Sm5.PUSH (Sm5.Id x); Sm5.LOAD]
    | K.WRITE e -> 
      trans e @ [Sm5.MALLOC; Sm5.BIND ("#tmp")] @ 
      [Sm5.PUSH (Sm5.Id ("#tmp")); Sm5.STORE] @
      [Sm5.PUSH (Sm5.Id ("#tmp")); Sm5.LOAD; Sm5.PUT] @
      [Sm5.PUSH (Sm5.Id ("#tmp")); Sm5.LOAD] @
      [Sm5.UNBIND; Sm5.POP]
end
