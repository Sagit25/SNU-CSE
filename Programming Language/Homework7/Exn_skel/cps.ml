(*
 * SNU 4190.310 Programming Languages 
 * Homework "Continuation Passing Style" Skeleton
 *)

open Xexp

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
  | Raise e -> Raise (alpha_conv e subst)
  | Handle (e1, x, e2) ->
    let x' = new_name () in
    let subst' = (x, x') :: subst in
    Handle (alpha_conv e1 subst, x', alpha_conv e2 subst')

(* TODO : Complete this function *)
let rec xcps' exp = 
  let k_h = new_name () in
  match exp with
  (* Constant expressions *)
  | Num n -> Fn (k_h, App (Fst (Var k_h), exp))
  | Var x -> Fn (k_h, App (Fst (Var k_h), exp))
  | Fn (x, e) -> Fn (k_h, App (Fst (Var k_h), Fn (f, xcps' e)))
  | Fnr (f, x, e) -> Fn (k_h, App (Fst (Var k_h), Fnr (f, x, xcps' e)))
  (* Non constant expressions *)
  | App (e1, e2) -> 
    let v1 = new_name () in
    let v2 = new_name () in
    let app = App (App (Var v1, Var v2), Fst (Var k_h)) in
    Fn (k_h, App (xcps' e1, 
      Pair (Fn (v1, App (xcps' e2, 
        Pair (Fn (v2, app), 
      Snd (Var k_h)))), 
    Snd (Var k_h))))
  | Ifp (e1, e2, e3) -> 
    let v1 = new_name () in
    let v2 = new_name () in
    let v3 = new_name () in
    let if2 = App (xcps' e2, Pair (Fn (v2, 
      App (Fst (Var k_h), Var v2)), Snd (Var k_h))) in
    let if3 = App (xcps' e3, Pair (Fn (v3, 
      App (Fst (Var k_h), Var v3)), Snd (Var k_h))) in
    let if1 = Ifp (Var v1, if2, if3) in
    Fn (k_h, App (xcps' e1, Pair (Fn (v1, if1), Snd (Var k_h))))
  | Add (e1, e2) ->
    let v1 = new_name () in
    let v2 = new_name () in
    let add = App (Fst (Var k_h), Add (Var v1, Var v2)) in
    Fn (k_h, App (xcps' e1, 
      Pair (Fn (v1, App (xcps' e2, 
        Pair (Fn (v2, add), 
      Snd (Var k_h)))), 
    Snd (Var k_h))))
  | Pair (e1, e2) ->     
    let v1 = new_name () in
    let v2 = new_name () in
    let pair = App (Fst (Var k_h), Pair (Var v1, Var v2)) in
    Fn (k_h, App (xcps' e1, 
      Pair (Fn (v1, App (xcps' e2, 
        Pair (Fn (v2, pair), 
      Snd (Var k_h)))), 
    Snd (Var k_h))))
  | Fst e -> 
    let v = new_name() in
    let fst = App (Fst (Var k_h), Fst (Var v)) in
    Fn (k_h, App (xcps' e, Pair (Fn (v, fst), Snd (Var k_h))))
  | Snd e -> 
    let v = new_name() in
    let snd = App (Fst (Var k_h), Snd (Var v)) in
    Fn (k_h, App (xcps' e, Pair (Fn (v, snd), Snd (Var k_h))))
  | Raise e -> Fn (k_h, App (xcps' e, Pair (Snd (Var k_h), Snd (Var k_h))))
  | Handle (e1, x, e2) -> 
    let v = new_name() in
    Fn (k_h, App (xcps' e1, 
      Pair (Fn (v, App (Fst (Var k_h), Var v)), 
        Fn (x, App (xcps' e2, 
      Pair (Fst (Var k_h), 
    Snd (Var k_h)))))))

let xcps exp = xcps' (alpha_conv exp [])
