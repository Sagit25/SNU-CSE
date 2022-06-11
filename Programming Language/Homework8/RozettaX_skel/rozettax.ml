(*
 * SNU 4190.310 Programming Languages 
 * Homework "RozettaX" Skeleton
 *)

let trans_v : Sm5.value -> Sonata.value = function
  | Sm5.Z z  -> Sonata.Z z
  | Sm5.B b  -> Sonata.B b
  | Sm5.L _ -> raise (Sonata.Error "Invalid input program : pushing location")
  | Sm5.Unit -> Sonata.Unit
  | Sm5.R _ -> raise (Sonata.Error "Invalid input program : pushing record")

(* TODO : complete this function *)
let rec trans_obj : Sm5.obj -> Sonata.obj = function
  | Sm5.Val v -> Sonata.Val (trans_v v)
  | Sm5.Id id -> Sonata.Id id
  | Sm5.Fn (arg, command) -> 
    let save = "#bind" in
    let command1 = command @ [Sm5.PUSH (Sm5.Id save)] in
    let command2 = command1 @ [Sm5.PUSH (Sm5.Val Sm5.Unit)] in
    let command3 = command2 @ [Sm5.MALLOC] @ [Sm5.CALL] in
    let command4 = [Sonata.BIND save] @ (trans' command3) in
    Sonata.Fn (arg, command4)

(* TODO : complete this function *)
and trans' : Sm5.command -> Sonata.command = function
  | Sm5.PUSH obj :: cmds -> Sonata.PUSH (trans_obj obj) :: (trans' cmds)
  | Sm5.POP :: cmds -> Sonata.POP :: (trans' cmds)
  | Sm5.STORE :: cmds -> Sonata.STORE :: (trans' cmds)
  | Sm5.LOAD :: cmds -> Sonata.LOAD :: (trans' cmds)
  | Sm5.JTR (c1, c2) :: cmds ->
    let c1' = c1 @ cmds in
    let c2' = c2 @ cmds in
    [Sonata.JTR (trans' c1', trans' c2')]
  | Sm5.MALLOC :: cmds -> Sonata.MALLOC :: (trans' cmds)
  | Sm5.BOX z :: cmds -> Sonata.BOX z :: (trans' cmds)
  | Sm5.UNBOX id :: cmds -> Sonata.UNBOX id :: (trans' cmds)
  | Sm5.BIND id :: cmds -> Sonata.BIND id :: (trans' cmds)
  | Sm5.UNBIND :: cmds -> Sonata.UNBIND :: (trans' cmds)
  | Sm5.GET ::cmds -> Sonata.GET :: (trans' cmds)
  | Sm5.PUT ::cmds -> Sonata.PUT :: (trans' cmds)
  | Sm5.CALL :: cmds -> 
    (
    match cmds with
    | [] -> [Sonata.CALL]
    | commands -> 
      let t1 = "#tmp1" in
      let t2 = "#tmp2" in
      let s = "#save" in
      let bind = (Sonata.BIND t1) :: Sonata.PUSH (Sonata.Id t1) :: Sonata.STORE :: (Sonata.BIND t2) :: [] in
      let cmds' = Sm5.UNBIND :: Sm5.POP :: Sm5.UNBIND :: Sm5.POP :: Sm5.UNBIND :: Sm5.POP :: cmds in
      let push = Sonata.PUSH (Sonata.Fn (s, trans' cmds')) :: [] in
      let push' = Sonata.PUSH (Sonata.Id t2) :: Sonata.PUSH (Sonata.Id t1) :: Sonata.LOAD :: [] in
      let call = Sonata.PUSH (Sonata.Id t1) :: Sonata.CALL :: [] in
      bind @ push @ push' @ call
    )
  | Sm5.ADD :: cmds -> Sonata.ADD :: (trans' cmds)
  | Sm5.SUB :: cmds -> Sonata.SUB :: (trans' cmds)
  | Sm5.MUL :: cmds -> Sonata.MUL :: (trans' cmds)
  | Sm5.DIV :: cmds -> Sonata.DIV :: (trans' cmds)
  | Sm5.EQ :: cmds -> Sonata.EQ :: (trans' cmds)
  | Sm5.LESS :: cmds -> Sonata.LESS :: (trans' cmds)
  | Sm5.NOT :: cmds -> Sonata.NOT :: (trans' cmds)
  | [] -> []

(* TODO : complete this function *)
let trans : Sm5.command -> Sonata.command = fun command ->
  (trans' command)
