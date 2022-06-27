(*
 * SNU 4190.310 Programming Languages
 * Type Checker Skeleton Code
 *)

open M
open Pp

type var = string

let count = ref 0 

let new_var () = 
  let _ = count := !count +1 in
  "x_" ^ (string_of_int !count)

type typ = 
  | TInt
  | TBool
  | TString
  | TPair of typ * typ
  | TLoc of typ
  | TFun of typ * typ
  | TVar of var
  (* Modify, or add more if needed *)

let rec unify (env, t1, t2) = 
  match (t1, t2) with
  | (TBool, TBool) -> fun t -> t
  | (TInt, TInt) -> fun t -> t
  | (TString, TString) -> fun t -> t
  | (t, TVar v) | (TVar v, t) ->     
    let rec do_subs (t') = 
      match t' with
      | TBool | TInt | TString -> t'
      | TVar v' -> if (v = v') then t else t'
      | TPair (t1', t2') -> TPair (do_subs t1', do_subs t2')
      | TLoc t'' -> TLoc (do_subs t'')
      | TFun (t1', t2') -> TFun (do_subs t1', do_subs t2')
    in 
    do_subs
  | (TLoc t1', TLoc t2') -> unify (env, t1', t2')
  | (TPair (t11, t12), TPair (t21, t22)) ->
    let u1 = unify (env, t11, t21) in
    let u2 = unify (env, u1 (t12), u1 (t22)) in
    fun t -> u1 (u2 t)
  | (TFun (f1, x1), TFun (f2, x2)) ->
    let u1 = unify (env, f1, f2) in
    let u2 = unify (env, u1 (x1), u1 (x2)) in
    fun t -> u1 (u2 t)
  | _ -> raise (M.TypeError "Type Error at Unify Algorithm")
           
let rec env_subs (env, subs) =
  let f (env') = 
    let (x, t) = env' in
    (x, (subs t))
  in
  match env with
  | [] -> []
  | hd :: tl -> [f(hd)] @ env_subs(tl, subs)
           
let rec find_env (v', env') = 
  match env' with
  | [] -> raise Not_found
  | hd :: tl -> 
    let (v1, v2) = hd in
    if (v' = v1) then v2 else find_env(v', tl) 
    
let rec malgorithm (env, exp, typs) = 
  match exp with 
  | M.CONST (M.B b) -> unify (env, TBool, typs)
  | M.CONST (M.N n) -> unify (env, TInt, typs)
  | M.CONST (M.S s) -> unify (env, TString, typs)
  | M.VAR v ->
    let t' = find_env (v, env) in
    unify (env, typs, t')
  | M.FN (v, e) ->
    let v1 = TVar (new_var()) in
    let v2 = TVar (new_var()) in
    let f = TFun (v1, v2) in
    let s1 = unify (env, f, typs) in
    let env' = [v, (s1 v1)] @ env_subs (env, s1) in
    let s2 = malgorithm (env', e, (s1 v2)) in
    (fun t' -> s2 (s1 t'))  
  | M.APP (e1, e2) -> 
    let v = TVar (new_var()) in
    let s1 = malgorithm (env, e1, TFun (v, typs)) in
    let v' = (s1 v) in
    let env' = env_subs (env, s1) in
    let s2 = malgorithm (env', e2, v') in
    (fun t' -> s1 (s2 t'))
         
  | M.LET (M.REC (f, x, e1), e2) ->
    let v1, v2 = TVar(new_var ()), TVar(new_var ()) in
    let env = env @ [x, v1] @ [f, TFun(v1, v2)] in
    let s1 = malgorithm (env, e1, v2) in
    let env = env_subs (env, s1) in
    let s2 = unify (env, v2, s1 v1) in
    let env = env_subs (env, s2) in
    let v' = s2 (s1 typs) in 
    let s3 = malgorithm (env, e2, v') in
    (fun t' -> s3 (s2 (s1 t')))
  | M.LET (M.VAL (x, e1), e2) ->
    let v = TVar (new_var()) in
    let s1 = malgorithm (env, e1, v) in
    let env' = env_subs (env, s1) in
    let env'' = env' @ [(x, (s1 v))] in
    let s2 = malgorithm (env'', e2, s1 typs) in 
    (fun t' -> s2 (s1 t'))
  | M.IF (e1, e2, e3) -> 
    let v = TVar (new_var()) in
    let s1 = unify (env, v, typs) in
    let env = env_subs (env, s1) in
    let s2 = malgorithm (env, e1, TBool) in
    let env = env_subs (env, s2) in
    let s3 = malgorithm (env, e2, s1 v) in
    let env = env_subs (env, s3) in
    let v' = s3 (s1 v) in
    let s4 = malgorithm (env, e3, v') in
    (fun t' -> s4 (s3 (s2 (s1 t'))))
  | M.BOP (M.ADD, e1, e2) | M.BOP (M.SUB, e1, e2) -> 
    let s1 = unify (env, TInt, typs) in
    let env' = env_subs (env, s1) in
    let s2 = malgorithm (env', e1, TInt) in
    let env'' = env_subs (env', s2) in
    let s3 = malgorithm (env'', e2, TInt) in
    (fun t' -> (s3 (s2 (s1 t'))))
  | M.BOP (M.AND, e1, e2) | M.BOP (M.OR, e1, e2) -> 
    let s1 = unify (env, TBool, typs) in
    let env' = env_subs (env, s1) in
    let s2 = malgorithm (env', e1, TBool) in
    let env'' = env_subs (env', s2) in
    let s3 = malgorithm (env'', e2, TBool) in
    (fun t' -> (s3 (s2 (s1 t'))))
  | M.BOP (M.EQ, e1, e2) -> 
    let v = TVar (new_var()) in
    let s1 = unify (env, TBool, typs) in
    let env' = env_subs (env, s1) in 
    let s2 = malgorithm (env', e1, (s1 v)) in
    let env'' = env_subs (env', s2) in 
    let v' = (s2 (s1 v)) in
    let s3 = malgorithm (env'', e2, v') in
    (fun t' -> (s3 (s2 (s1 t'))))
  | M.READ -> unify (env, TInt, typs)
  | M.WRITE e ->
    let v = TVar (new_var()) in
    let subs' = unify (env, v, typs) in
    let typs' = (subs' typs) in
    let env' = env_subs (env, subs') in
    malgorithm (env', e, typs')
  | M.MALLOC e -> 
    let v = TVar (new_var()) in
    let s1 = unify (env, TLoc v, typs) in
    let env' = env_subs (env, s1) in 
    let v' = (s1 v) in
    let s2 = malgorithm (env', e, v') in
    (fun t' -> s2 (s1 t'))
  | M.ASSIGN (e1, e2) ->
    let s1 = malgorithm (env, e1, TLoc typs) in
    let env' = env_subs (env, s1) in 
    let s2 = malgorithm (env', e2, (s1 typs)) in
    (fun t' -> s2 (s1 t'))         
  | M.BANG e -> malgorithm (env, e, (TLoc typs))
  | M.SEQ (e1, e2) ->
    let v = TVar (new_var()) in
    let s1 = unify (env, v, typs) in
    let env' = env_subs (env, s1) in
    let s2 = malgorithm (env', e2, (s1 v)) in
    (fun t' -> s2 (s1 t'))
  | M.PAIR (e1, e2) ->
    let v1 = TVar (new_var()) in
    let v2 = TVar (new_var()) in
    let tp = TPair (v1, v2) in
    let s1 = unify (env, tp, typs) in
    let env' = env_subs (env, s1) in
    let s2 = malgorithm (env', e1, (s1 v1)) in
    let env'' = env_subs (env', s2) in
    let s3 = malgorithm (env'', e2, (s1 v2)) in
    (fun t' -> s3 (s2 (s1 t')))
  | M.FST e -> 
    let v2 = TVar (new_var()) in
    let tp = TPair (typs, v2) in
    malgorithm (env, e, tp)
  | M.SND e -> 
    let v1 = TVar (new_var()) in
    let tp = TPair (v1, typs) in
    malgorithm (env, e, tp)

        
(* TODO : Implement this function *)
let check : M.exp -> M.types = fun exp ->
  let rec trans_types (typs) = 
    match typs with
    | TInt -> M.TyInt
    | TBool -> M.TyBool
    | TString -> M.TyString
    | TPair (t1, t2) -> M.TyPair (trans_types t1, trans_types t2)
    | TLoc t -> M.TyLoc (trans_types t)
    | TFun (t1, t2) -> M.TyArrow (trans_types t1, trans_types t2)
    | TVar _ -> raise (M.TypeError "Type Error at Trans to M Types")
  in
  let v = TVar(new_var()) in
  let s = malgorithm ([], exp, v) in
  let t = (s (s v)) in
  (trans_types t)





    (*




let rec malgorithm (env, exp, typs) = 
  match exp with


















  *)