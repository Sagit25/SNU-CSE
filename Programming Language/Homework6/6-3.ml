(*
 * SNU 4190.310 Programming Languages (Spring 2022)
 *
 * Lambda Calculus
 *)
open Lambda
module Evaluator =
  struct
	exception Error of string

  module StrSet = Set.Make(struct type t = string let compare = Pervasives.compare end)

  type substitution = (string * lexp) list

  let rec new_var_helper n var_set = 
    let var_to_try = "#" ^ (string_of_int n) in
    if not (StrSet.mem var_to_try var_set) then
      var_to_try
    else
      new_var_helper (n + 1) var_set

  let new_var recommend var_set = 
    if not (StrSet.mem recommend var_set) then
      recommend
    else
      new_var_helper 0 var_set

  let rec free_vars = function
    | Var x -> StrSet.singleton x
    | Lam (x, e) -> StrSet.remove x (free_vars e)
    | App (e1, e2) -> StrSet.union (free_vars e1) (free_vars e2)

  let rec subs: (string * lexp) -> lexp -> lexp = fun (var, var_exp) exp ->
  match exp with
  | Var(x) -> if var = x then var_exp else exp
  | Lam(x,e) -> 
      let var_set = StrSet.singleton var in
      let var_set = StrSet.union var_set (free_vars var_exp) in
      let var_set = StrSet.union var_set (free_vars exp) in
      let x' = new_var x var_set in
      let e' = subs (x, Var x') e in
      let e'' = subs (var, var_exp) e' in
      Lam (x', e'')
  | App(e1,e2) -> App(subs (var, var_exp) e1, subs (var, var_exp) e2)

  let subst: substitution * lexp -> lexp = fun (sub, exp) ->
  List.fold_left (
    fun acc sub_ele -> subs sub_ele acc
    )
     exp sub

  let rec reduction : lexp -> lexp = fun exp -> 
    match exp with
      | Var x -> exp
      | Lam (x, e) -> Lam (x, reduction e)
      | App (Lam (x, e1), e2) -> subs (x, e2) e1 
      | App (e1, e2) -> 
        let e1' = reduction e1 in
        if (e1' == e1) then App (e1, reduction e2)
        else App (e1', e2)

  let rec recur : lexp -> lexp = fun exp ->
    let exp' =  reduction exp in
    let b = if (0 != compare exp exp') then false else true in
    if b then exp
    else recur exp'
  
  let reduce : lexp -> lexp = fun exp -> 
    recur exp
    
  end
