(*
 * SNU 4190.310 Programming Languages 
 * Homework "Continuation Passing Style" Skeleton
 *)

open M0

let count = ref 0

let new_name () = 
  let _ = count := !count + 1 in
  "x_" ^ (string_of_int !count)

let rec alpha_conv exp subst = 
  match exp with
  | Num n -> Num n
  | Var x -> (try Var (List.assoc x subst) with Not_found -> Var x)
  | Fn (x, e) ->
    let x' = new_name () in
    let subst' = (x, x') :: subst in
    Fn (x', alpha_conv e subst')
  | Fnr (f, x, e) -> 
    let x' = new_name () in
    let f' = new_name () in
    let subst' = (f, f') :: (x, x') :: subst in
    Fnr (f', x', alpha_conv e subst')
  | App (e1, e2) -> App (alpha_conv e1 subst, alpha_conv e2 subst)
  | Ifp (e1, e2, e3) -> 
    Ifp (alpha_conv e1 subst, alpha_conv e2 subst, alpha_conv e3 subst)
  | Add (e1, e2) -> Add (alpha_conv e1 subst, alpha_conv e2 subst)
  | Pair (e1, e2) -> Pair (alpha_conv e1 subst, alpha_conv e2 subst)
  | Fst e -> Fst (alpha_conv e subst)
  | Snd e -> Snd (alpha_conv e subst)

(* TODO : Complete this function *)
let rec cps' exp = 
  let k = new_name () in
  match exp with
  (* Constant expressions *)
  | Num n -> Fn (k, App (Var k, exp))
  | Var x -> Fn (k, App (Var k, exp))
  | Fn (x, e) -> Fn (k, App (Var k, Fn (x, cps' e)))
  | Fnr (f, x, e) -> Fn (k, App (Var k, Fnr (f, x, cps' e)))
  (* Non constant expressions *)
  | App (e1, e2) -> 
    let v1 = new_name () in
    let v2 = new_name () in
    let app = App (App (Var v1, Var v2), Var k) in
    Fn (k, App (cps' e1, Fn (v1, App (cps' e2, Fn (v2, app)))))
  | Ifp (e1, e2, e3) -> 
    let v1 = new_name () in
    let v2 = new_name () in
    let v3 = new_name () in
    let if2 = App (cps' e2, Fn (v2, App (Var k, Var v2))) in
    let if3 = App (cps' e3, Fn (v3, App (Var k, Var v3))) in
    let if1 = Ifp (Var v1, if2, if3) in
    Fn (k, App (cps' e1, Fn (v1, if1)))
  | Add (e1, e2) ->
    let v1 = new_name () in
    let v2 = new_name () in
    let add = App (Var k, Add (Var v1, Var v2)) in
    Fn (k, App (cps' e1, Fn (v1, App (cps' e2, Fn (v2, add)))))
  | Pair (e1, e2) -> 
    let v1 = new_name () in
    let v2 = new_name () in
    let pair = App (Var k, Pair (Var v1, Var v2)) in
    Fn (k, App (cps' e1, Fn (v1, App (cps' e2, Fn (v2, pair)))))
  | Fst e ->  
    let v = new_name () in
    let fst = App (Var k, Fst (Var v)) in
    Fn (k, App (cps' e, Fn (v, fst)))
  | Snd e -> 
    let v = new_name () in
    let snd = App (Var k, Snd (Var v)) in
    Fn (k, App (cps' e, Fn (v, snd)))

let cps exp = cps' (alpha_conv exp [])
