(*
 * SNU 4190.310 Programming Languages
 * Type Checker Skeleton
 *)

open M

type var = string

type typ = 
  | TInt
  | TBool
  | TString
  | TPair of typ * typ
  | TLoc of typ
  | TFun of typ * typ
  | TComp of var (* int, bool, string, loc *)
  | TWrite of var (* int, bool, string*)
  | TVar of var (* all *)
  (* Modify, or add more if needed *)

type typ_scheme =
  | SimpleTyp of typ 
  | GenTyp of (var list * typ)

type typ_env = (M.id * typ_scheme) list

let count = ref 0 

let new_var () = 
  let _ = count := !count +1 in
  "x_" ^ (string_of_int !count)

(* Definitions related to free type variable *)

let union_ftv ftv_1 ftv_2 = 
  let ftv_1' = List.filter (fun v -> not (List.mem v ftv_2)) ftv_1 in
  ftv_1' @ ftv_2
  
let sub_ftv ftv_1 ftv_2 =
  List.filter (fun v -> not (List.mem v ftv_2)) ftv_1

let rec ftv_of_typ : typ -> var list = function
  | TInt | TBool | TString -> []
  | TPair (t1, t2) -> union_ftv (ftv_of_typ t1) (ftv_of_typ t2)
  | TLoc t -> ftv_of_typ t
  | TFun (t1, t2) ->  union_ftv (ftv_of_typ t1) (ftv_of_typ t2)
  | TVar v -> [v]
  | TComp v -> [v]
  | TWrite v -> [v]

let ftv_of_scheme : typ_scheme -> var list = function
  | SimpleTyp t -> ftv_of_typ t
  | GenTyp (alphas, t) -> sub_ftv (ftv_of_typ t) alphas 

let ftv_of_env : typ_env -> var list = fun tyenv ->
  List.fold_left 
    (fun acc_ftv (id, tyscm) -> union_ftv acc_ftv (ftv_of_scheme tyscm))
    [] tyenv 

(* Generalize given type into a type scheme *)
let generalize : typ_env -> typ -> typ_scheme = fun tyenv t ->
  let env_ftv = ftv_of_env tyenv in
  let typ_ftv = ftv_of_typ t in
  let ftv = sub_ftv typ_ftv env_ftv in
  if List.length ftv = 0 then
    SimpleTyp t
  else
    GenTyp(ftv, t)

(* Definitions related to substitution *)

type subst = typ -> typ

let empty_subst : subst = fun t -> t

let make_subst : var -> typ -> subst = fun x t ->
  let rec subs t' = 
    match t' with
    | TVar x' -> if (x = x') then t else t'
    | TComp x' -> if (x = x') then t else t'
    | TWrite x' -> if (x = x') then t else t'
    | TPair (t1, t2) -> TPair (subs t1, subs t2)
    | TLoc t'' -> TLoc (subs t'')
    | TFun (t1, t2) -> TFun (subs t1, subs t2)
    | TInt | TBool | TString -> t'
  in subs

let (@@) s1 s2 = (fun t -> s1 (s2 t)) (* substitution composition *)

let subst_scheme : subst -> typ_scheme -> typ_scheme = fun subs tyscm ->
  match tyscm with
  | SimpleTyp t -> SimpleTyp (subs t)
  | GenTyp (alphas, t) ->
    (* S (\all a.t) = \all b.S{a->b}t  (where b is new variable) *)
    let betas = List.map (fun _ -> new_var()) alphas in
    let s' =
      List.fold_left2 (
        fun acc_subst alpha beta -> 
        let rec do_subs = fun t' ->
          let tv = TVar (beta) in
          let tc = TComp (beta) in
          let tw = TWrite (beta) in
          match t' with
            | TBool -> t'
            | TInt -> t'
            | TString -> t'
            | TVar v' -> if (alpha = v') then tv else t'
            | TComp v' -> if (alpha = v') then tc else t'
            | TWrite v' -> if (alpha = v') then tw else t'
            | TPair (t1', t2') -> TPair (do_subs t1', do_subs t2')
            | TLoc t'' -> TLoc (do_subs t'')
            | TFun (t1', t2') -> TFun (do_subs t1', do_subs t2')
        in
        do_subs @@ acc_subst
        )
      empty_subst alphas betas
    in
    GenTyp (betas, subs (s' t))

let subst_env : subst -> typ_env -> typ_env = fun subs tyenv ->
  List.map (fun (x, tyscm) -> (x, subst_scheme subs tyscm)) tyenv

(* Implement Unify and M Algorithm for my self *)

let rec expansive (exp) = 
  match exp with
  | M.CONST n -> false
  | M.VAR v -> false
  | M.FN (x, e) -> false
  | M.APP (e1, e2) -> true
  | M.LET (d, e2) -> 
    (
      match d with
      | M.VAL (x, e1) -> (expansive e1) || (expansive e2)
      | M.REC (f, x, e1) -> (expansive e2)
    )
  | M.IF (e1, e2, e3) -> (expansive e1) || (expansive e2) || (expansive e3)
  | M.BOP (op, e1, e2) -> (expansive e1) || (expansive e2)
  | M.READ -> false
  | M.WRITE e -> (expansive e)
  | M.MALLOC e -> true
  | M.ASSIGN (e1, e2) -> (expansive e1) || (expansive e2)
  | M.BANG e -> (expansive e)
  | M.SEQ (e1, e2) -> (expansive e1) || (expansive e2)
  | M.PAIR (e1, e2) -> (expansive e1) || (expansive e2)
  | M.FST e -> (expansive e)         
  | M.SND e -> (expansive e) 

let rec unify (env, t1, t2) =
  let rec do_subs (v, t, t') = 
    match t' with
    | TBool -> t'
    | TInt -> t'
    | TString -> t'
    | TVar v' -> if (v = v') then t else t'
    | TComp v' -> if (v = v') then t else t'
    | TWrite v' -> if (v = v') then t else t'
    | TPair (t1', t2') -> TPair (do_subs (v, t, t1'), do_subs (v, t, t2'))
    | TLoc t'' -> TLoc (do_subs (v, t, t''))
    | TFun (t1', t2') -> TFun (do_subs (v, t, t1'), do_subs (v, t, t2'))
  in
  match (t1, t2) with
  | (TBool, TBool) -> fun t -> t
  | (TInt, TInt) -> fun t -> t
  | (TString, TString) -> fun t -> t
  | (TVar v1, TVar v2) -> if (v1 = v2) then empty_subst else (fun t' -> do_subs (v1, (TVar v2), t'))
  | (t, TVar v) | (TVar v, t) -> 
    let ts = ftv_of_typ t in
    let rec check_type (v, ts) = 
      match ts with
      | [] -> false
      | hd :: tl -> if (hd = v) then true else check_type (v, tl)
    in
    if (check_type (v, ts)) 
    then raise (M.TypeError "Type Error at Unify Algorithm")
    else (fun t' -> do_subs (v, t, t'))
  | (TComp v1, TComp v2) -> if (v1 = v2) then empty_subst else (fun t' -> do_subs (v1, (TComp v2), t'))
  | (TComp v, t) | (t, TComp v) ->
    let ts = ftv_of_typ t in
    let rec check_type (v, ts) = 
       match ts with
      | [] -> false
      | hd :: tl -> if (hd = v) then true else check_type (v, tl)
    in
    if (check_type (v, ts)) 
    then raise (M.TypeError "Type Error at Unify Algorithm")
    else
    (
      match t with 
      | TInt -> (fun t' -> do_subs (v, t, t'))
      | TString -> (fun t' -> do_subs (v, t, t'))
      | TBool -> (fun t' -> do_subs (v, t, t'))
      | TLoc loc -> (fun t' -> do_subs (v, t, t'))
      | TWrite v' -> (fun t' -> do_subs (v, t, t'))
      | _ -> raise (M.TypeError "Type Error at Unify Algorithm")
    )
  | (TWrite v1, TWrite v2) -> if (v1 = v2) then empty_subst else (fun t' -> do_subs (v1, (TWrite v2), t'))
  | (TWrite v, t) | (t, TWrite v) ->
    let ts = ftv_of_typ t in
    let rec check_type (v, ts) = 
      match ts with
      | [] -> false
      | hd :: tl -> if (hd = v) then true else check_type (v, tl)
    in
    if (check_type (v, ts)) 
    then raise (M.TypeError "Type Error at Unify Algorithm")
    else
      (
        match t with 
        | TInt -> (fun t' -> do_subs (v, t, t'))
        | TString -> (fun t' -> do_subs (v, t, t'))
        | TBool -> (fun t' -> do_subs (v, t, t'))
        | _ -> raise (M.TypeError "Type Error at Unify Algorithm")
      )
  | (TLoc t1', TLoc t2') -> unify (env, t1', t2')
  | (TPair (t11, t12), TPair (t21, t22)) ->
    let s1 = unify (env, t11, t21) in
    let s2 = unify (env, (s1 t12), (s1 t22)) in
    (fun t' -> s2 (s1 t'))
  | (TFun (f1, x1), TFun (f2, x2)) ->
    let s1 = unify (env, f1, f2) in
    let s2 = unify (env, (s1 x1), (s1 x2)) in
    (fun t' -> s2 (s1 t'))
  | _ -> raise (M.TypeError "Type Error at Unify Algorithm")

let rec find_env (v', env') = 
  match env' with
  | [] -> raise Not_found
  | hd :: tl -> 
    let (v1, v2) = hd in
    if (v' = v1) then v2 else find_env (v', tl)

let rec malgorithm (env, exp, typs) = 
  match exp with
  | M.CONST (M.B b) -> unify (env, TBool, typs)
  | M.CONST (M.N n) -> unify (env, TInt, typs)
  | M.CONST (M.S s) -> unify (env, TString, typs)
  | M.VAR v ->
    (
      let typs' = find_env (v, env) in
      match typs' with
      | SimpleTyp t' -> unify (env, typs, t')
      | GenTyp (vl, t') ->
        (
          let rec rec_subs (sub, al) =
            match al with
            | [] -> sub
            | hd :: tl -> 
              let tv = TVar (new_var()) in
              let tc = TComp (new_var()) in
              let tw = TWrite (new_var()) in
              let rec do_subs t =
                match t with
                | TBool -> t
                | TInt -> t
                | TString -> t
                | TVar v' -> if (hd = v') then tv else t
                | TComp v' -> if (hd = v') then tc else t
                | TWrite v' -> if (hd = v') then tw else t
                | TPair (t1, t2) -> TPair ((do_subs t1), (do_subs t2))
                | TLoc t'' -> TLoc (do_subs t'')
                | TFun (t1, t2) -> TFun ((do_subs t1), (do_subs t2))
              in
              let sub' = do_subs @@ sub in
              rec_subs (sub', tl)
          in
          let s = rec_subs (empty_subst, vl) in
          unify (env, typs, (s t'))
        )
    )
  | M.FN (x, e) ->
    let vx = TVar (new_var()) in
    let ve = TVar (new_var()) in
    let vf = TFun (vx, ve) in
    let s1 = unify (env, vf, typs) in
    let env' = subst_env s1 env in
    let env'' = [(x, SimpleTyp (s1 vx))] @ env' in
    let s2 = malgorithm (env'', e, (s1 ve)) in
    s2 @@ s1
  | M.APP (e1, e2) ->
    let v = TVar (new_var()) in
    let vf = TFun (v, typs) in
    let s1 = malgorithm (env, e1, vf) in
    let v' = (s1 v) in
    let env' = subst_env s1 env in
    let s2 = malgorithm (env', e2, v') in
    s2 @@ s1  
  | M.LET (d, e2) -> 
    (
      match d with
      | M.REC (f, x, e1) ->
        let vx = TVar (new_var()) in
        let ve = TVar (new_var()) in
        let vf = TFun (vx, ve) in
        let env' = [(f, SimpleTyp vf)] @ [(x, SimpleTyp vx)] @ env in
        let s1 = malgorithm (env', e1, ve) in
        let env'' = subst_env s1 env in
        let vf' = TFun ((s1 vx), (s1 ve)) in
        let env''' = [(f, generalize env'' vf')] @ env'' in
        let s2 = malgorithm (env''', e2, (s1 typs)) in
        s2 @@ s1
      | M.VAL (x, e1) ->
        let v = TVar (new_var()) in
        let s1 = malgorithm (env, e1, v) in
        let env' = subst_env s1 env in
        let env'' = (if (expansive e1) then [(x, SimpleTyp (s1 v))]
        else [(x, generalize env' (s1 v))]) in
        let env''' = env'' @ env' in
        let s2 = malgorithm (env''', e2, (s1 typs)) in
        s2 @@ s1
    )
  | M.IF (e1, e2, e3) ->
    let s1 = malgorithm (env, e1, TBool) in
    let env' = subst_env s1 env in
    let s2 = malgorithm (env', e2, (s1 typs)) in
    let env'' = subst_env s2 env' in
    let s3 = malgorithm (env'', e3, (s2 (s1 typs))) in
    s3 @@ s2 @@ s1
  | M.BOP (op, e1, e2) ->
    (
      match op with
      | M.ADD ->
        let s1 = malgorithm (env, e1, TInt) in
        let env' = subst_env s1 env in
        let s2 = malgorithm (env', e2, TInt) in
        let s3 = unify (env', TInt, (s2 (s1 typs))) in
        s3 @@ s2 @@ s1
      | M.SUB ->
        let s1 = malgorithm (env, e1, TInt) in
        let env' = subst_env s1 env in
        let s2 = malgorithm (env', e2, TInt) in
        let s3 = unify (env', TInt, (s2 (s1 typs))) in
        s3 @@ s2 @@ s1
      | M.AND ->
        let s1 = malgorithm (env, e1, TBool) in
        let env' = subst_env s1 env in
        let s2 = malgorithm (env', e2, TBool) in
        let s3 = unify (env', TBool, (s2 (s1 typs))) in
        s3 @@ s2 @@ s1
      | M.OR ->
        let s1 = malgorithm (env, e1, TBool) in
        let env' = subst_env s1 env in
        let s2 = malgorithm (env', e2, TBool) in
        let s3 = unify (env', TBool, (s2 (s1 typs))) in
        s3 @@ s2 @@ s1
      | M.EQ ->
        let v = TComp (new_var()) in
        let s1 = malgorithm (env, e1, v) in
        let env' = subst_env s1 env in
        let s2 = malgorithm (env', e2, (s1 v)) in
        let s3 = unify (env', TBool, (s2 (s1 typs))) in
        s3 @@ s2 @@ s1
    )
  | M.READ -> unify (env, TInt, typs)
  | M.WRITE e -> 
    let v = TWrite (new_var()) in
    let s1 = unify (env, v, typs) in
    let env' = subst_env s1 env in
    let s2 = malgorithm (env', e, (s1 v)) in
    s2 @@ s1
  | M.MALLOC e ->
    let v = TVar (new_var()) in
    let s1 = unify (env, TLoc v, typs) in
    let env' = subst_env s1 env in 
    let s2 = malgorithm (env', e, v) in
    s2 @@ s1
  | M.ASSIGN (e1, e2) -> 
    let s1 = malgorithm (env, e1, (TLoc typs)) in
    let env' = subst_env s1 env in
    let s2 = malgorithm (env', e2, s1 typs) in
    s2 @@ s1
  | M.BANG loc -> malgorithm (env, loc, (TLoc typs))
  | M.SEQ (e1, e2) ->
    let v1 = TVar (new_var ()) in
    let v2 = TVar (new_var ()) in
    let s1 = unify (env, typs, v2) in
    let env' = subst_env s1 env in
    let s2 = malgorithm (env', e1, (s1 v1)) in
    let env'' = subst_env s2 env' in
    let s3 = malgorithm (env'', e2, s2 (s1 v2)) in
    s3 @@ s2 @@ s1
  | M.PAIR (e1, e2) ->
    let v1 = TVar (new_var()) in
    let v2 = TVar (new_var()) in
    let tp = TPair (v1, v2) in
    let s1 = unify (env, tp, typs) in
    let env' = subst_env s1 env in
    let s2 = malgorithm (env', e1, (s1 v1)) in
    let env'' = subst_env s2 env' in
    let s3 = malgorithm (env'', e2, (s2 (s1 v2))) in
    s3 @@ s2 @@ s1
  | M.FST e -> 
    let v2 = TVar (new_var()) in
    let tp = TPair (typs, v2) in
    malgorithm (env, e, tp)
  | M.SND e -> 
    let v1 = TVar (new_var()) in
    let tp = TPair (v1, typs) in
    malgorithm (env, e, tp)

(* TODO : Implement this function *)
let check : M.exp -> M.typ = fun exp ->
    let rec trans_types (typs) = 
    match typs with
    | TInt -> M.TyInt
    | TBool -> M.TyBool
    | TString -> M.TyString
    | TPair (t1, t2) -> M.TyPair (trans_types t1, trans_types t2)
    | TLoc t -> M.TyLoc (trans_types t)
    | _ -> raise (M.TypeError "Type Error at Trans to M Types")
  in
  let v = TVar (new_var()) in
  let s = malgorithm ([], exp, v) in
  let t = (s v) in
  (trans_types t)
