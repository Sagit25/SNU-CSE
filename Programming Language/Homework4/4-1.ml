(*
 * SNU 4190.310 Programming Languages 2022 Spring
 *  K- Interpreter Skeleton Code
 *)

(* Location Signature *)
module type LOC =
sig
  type t
  val base : t
  val equal : t -> t -> bool
  val diff : t -> t -> int
  val increase : t -> int -> t
end

module Loc : LOC =
struct
  type t = Location of int
  let base = Location(0)
  let equal (Location(a)) (Location(b)) = (a = b)
  let diff (Location(a)) (Location(b)) = a - b
  let increase (Location(base)) n = Location(base+n)
end

(* Memory Signature *)
module type MEM = 
sig
  type 'a t
  exception Not_allocated
  exception Not_initialized
  val empty : 'a t (* get empty memory *)
  val load : 'a t -> Loc.t  -> 'a (* load value : Mem.load mem loc => value *)
  val store : 'a t -> Loc.t -> 'a -> 'a t (* save value : Mem.store mem loc value => mem' *)
  val alloc : 'a t -> Loc.t * 'a t (* get fresh memory cell : Mem.alloc mem => (loc, mem') *)
end

(* Environment Signature *)
module type ENV =
sig
  type ('a, 'b) t
  exception Not_bound
  val empty : ('a, 'b) t (* get empty environment *)
  val lookup : ('a, 'b) t -> 'a -> 'b (* lookup environment : Env.lookup env key => content *)
  val bind : ('a, 'b) t -> 'a -> 'b -> ('a, 'b) t  (* id binding : Env.bind env key content => env'*)
end

(* Memory Implementation *)
module Mem : MEM =
struct
  exception Not_allocated
  exception Not_initialized
  type 'a content = V of 'a | U
  type 'a t = M of Loc.t * 'a content list
  let empty = M (Loc.base,[])

  let rec replace_nth = fun l n c -> 
    match l with
    | h::t -> if n = 1 then c :: t else h :: (replace_nth t (n - 1) c)
    | [] -> raise Not_allocated

  let load (M (boundary,storage)) loc =
    match (List.nth storage ((Loc.diff boundary loc) - 1)) with
    | V v -> v 
    | U -> raise Not_initialized

  let store (M (boundary,storage)) loc content =
    M (boundary, replace_nth storage (Loc.diff boundary loc) (V content))

  let alloc (M (boundary,storage)) = 
    (boundary, M (Loc.increase boundary 1, U :: storage))
end

(* Environment Implementation *)
module Env : ENV=
struct
  exception Not_bound
  type ('a, 'b) t = E of ('a -> 'b)
  let empty = E (fun x -> raise Not_bound)
  let lookup (E (env)) id = env id
  let bind (E (env)) id loc = E (fun x -> if x = id then loc else env x)
end

(*
 * K- Interpreter
 *)
module type KMINUS =
sig
  exception Error of string
  type id = string
  type exp =
    | NUM of int | TRUE | FALSE | UNIT
    | VAR of id
    | ADD of exp * exp
    | SUB of exp * exp
    | MUL of exp * exp
    | DIV of exp * exp
    | EQUAL of exp * exp
    | LESS of exp * exp
    | NOT of exp
    | SEQ of exp * exp            (* sequence *)
    | IF of exp * exp * exp       (* if-then-else *)
    | WHILE of exp * exp          (* while loop *)
    | LETV of id * exp * exp      (* variable binding *)
    | LETF of id * id list * exp * exp (* procedure binding *)
    | CALLV of id * exp list      (* call by value *)
    | CALLR of id * id list       (* call by referenece *)
    | RECORD of (id * exp) list   (* record construction *)
    | FIELD of exp * id           (* access record field *)
    | ASSIGN of id * exp          (* assgin to variable *)
    | ASSIGNF of exp * id * exp   (* assign to record field *)
    | READ of id
    | WRITE of exp
    
  type program = exp
  type memory
  type env
  type value =
    | Num of int
    | Bool of bool
    | Unit
    | Record of (id -> Loc.t)
  val emptyMemory : memory
  val emptyEnv : env
  val run : memory * env * program -> value
end

module K : KMINUS =
struct
  exception Error of string

  type id = string
  type exp =
    | NUM of int | TRUE | FALSE | UNIT
    | VAR of id
    | ADD of exp * exp
    | SUB of exp * exp
    | MUL of exp * exp
    | DIV of exp * exp
    | EQUAL of exp * exp
    | LESS of exp * exp
    | NOT of exp
    | SEQ of exp * exp            (* sequence *)
    | IF of exp * exp * exp       (* if-then-else *)
    | WHILE of exp * exp          (* while loop *)
    | LETV of id * exp * exp      (* variable binding *)
    | LETF of id * id list * exp * exp (* procedure binding *)
    | CALLV of id * exp list      (* call by value *)
    | CALLR of id * id list       (* call by referenece *)
    | RECORD of (id * exp) list   (* record construction *)
    | FIELD of exp * id           (* access record field *)
    | ASSIGN of id * exp          (* assgin to variable *)
    | ASSIGNF of exp * id * exp   (* assign to record field *)
    | READ of id
    | WRITE of exp

  type program = exp

  type value =
    | Num of int
    | Bool of bool
    | Unit
    | Record of (id -> Loc.t)
    
  type memory = value Mem.t
  type env = (id, env_entry) Env.t
  and  env_entry = Addr of Loc.t | Proc of id list * exp * env

  let emptyMemory = Mem.empty
  let emptyEnv = Env.empty

  let value_int v =
    match v with
    | Num n -> n
    | _ -> raise (Error "TypeError : not int")

  let value_bool v =
    match v with
    | Bool b -> b
    | _ -> raise (Error "TypeError : not bool")

  let value_unit v =
    match v with
    | Unit -> ()
    | _ -> raise (Error "TypeError : not unit")

  let value_record v =
    match v with
    | Record r -> r
    | _ -> raise (Error "TypeError : not record")

  let lookup_env_loc e x =
    try
      (match Env.lookup e x with
      | Addr l -> l
      | Proc _ -> raise (Error "TypeError : not addr")) 
    with Env.Not_bound -> raise (Error "Unbound")

  let lookup_env_proc e f =
    try
      (match Env.lookup e f with
      | Addr _ -> raise (Error "TypeError : not proc") 
      | Proc (id_list, exp, env) -> (id_list, exp, env))
    with Env.Not_bound -> raise (Error "Unbound")

  let rec eval mem env e =
    match e with
    | READ x -> 
      let v = Num (read_int()) in
      let l = lookup_env_loc env x in
      (v, Mem.store mem l v)
    | WRITE e ->
      let (v, mem') = eval mem env e in
      let n = value_int v in
      let _ = print_endline (string_of_int n) in
      (v, mem')
    | LETV (x, e1, e2) ->
      let (v, mem') = eval mem env e1 in
      let (l, mem'') = Mem.alloc mem' in
      eval (Mem.store mem'' l v) (Env.bind env x (Addr l)) e2
    | ASSIGN (x, e) ->
      let (v, mem') = eval mem env e in
      let l = lookup_env_loc env x in
      (v, Mem.store mem' l v)
    | TRUE -> (Bool true, mem)
    | FALSE -> (Bool false, mem)
    | NUM n -> (Num n, mem)
    | UNIT -> (Unit, mem)
    | VAR id -> 
      let v = Mem.load mem (lookup_env_loc env id) in
      (v, mem)
    | ADD (e1, e2) -> 
      let (v1, mem) = eval mem env e1 in
      let (v2, mem) = eval mem env e2 in
      (Num (value_int v1 + value_int v2), mem)
    | SUB (e1, e2) ->
      let (v1, mem) = eval mem env e1 in
      let (v2, mem) = eval mem env e2 in
      (Num (value_int v1 - value_int v2), mem)
    | MUL (e1, e2) ->
      let (v1, mem) = eval mem env e1 in
      let (v2, mem) = eval mem env e2 in
      (Num (value_int v1 * value_int v2), mem)
    | DIV (e1, e2) ->
      let (v1, mem) = eval mem env e1 in
      let (v2, mem) = eval mem env e2 in
      (Num (value_int v1 / value_int v2), mem)
    | EQUAL (e1, e2) -> 
      let (v1, mem) = eval mem env e1 in
      let (v2, mem) = eval mem env e2 in
      (Bool (v1 = v2), mem)
    | LESS (e1, e2) -> 
      let (v1, mem) = eval mem env e1 in
      let (v2, mem) = eval mem env e2 in
      (Bool (value_int v1 < value_int v2), mem)
    | NOT e -> 
      let (v, mem) = eval mem env e in 
      (Bool (not (value_bool v)), mem)
    | SEQ (e1, e2) ->
      let (v, mem) = eval mem env e1 in 
      eval mem env e2
    | IF (e1, e2, e3) -> 
      let (v, mem) = eval mem env e1 in
      let e4 = if (value_bool v) then e2 else e3 in
      eval mem env e4
    | WHILE (e1, s) -> 
      let (v1, mem) = eval mem env e1 in
      if (value_bool v1) then 
      let (v2, mem) = eval mem env s in eval mem env e
      else (Unit, mem)
    | LETF (x, l, e1, e2) -> (* procedure binding *)
      let proc = Proc (l, e1, env) in
      eval mem (Env.bind env x proc) e2
    | CALLV (id, el) -> (* call by value *)
      let rec listeval (vl, mem, l) = 
        match l with
        | [] -> (vl, mem)
        | h :: lt -> let (v', mem) = eval mem env h in
                     listeval (vl@[v'], mem, lt)
      in
      let rec listassign (mem, env, l) = 
        match l with
        | [] -> (mem, env)
        | h :: lt -> let (id, v) = h in
                     let (loc, mem) = Mem.alloc mem in
                     listassign ((Mem.store mem loc v), (Env.bind env id (Addr loc)), lt)
      in
      let (v, mem) = listeval ([], mem, el) in
      let envtmp = env in
      let (x, e, env) = lookup_env_proc env id in
      if List.length(x) != List.length(v) then raise (Error "InvalidArg") else
      let (mem, env) = listassign (mem, env, (List.combine x v)) in
      eval mem (Env.bind env id (Proc (x, e, envtmp))) e
    | CALLR (id, il) -> (* call by referenece *) 
      let envtmp = env in
      let (x, e, env) = lookup_env_proc env id in
      let envtmp' = env in
      let rec listfind (env, l) =
        match l with
        | [] -> env
        | h :: lt -> let (id1, id2) = h in
                     let loc = lookup_env_loc envtmp id2 in
                     listfind ((Env.bind env id1 (Addr loc)), lt)
      in
      if List.length(x) != List.length(il) then raise (Error "InvalidArg") else
      let env = listfind (env, (List.combine x il)) in
      eval mem (Env.bind env id (Proc (x, e, envtmp'))) e
    | RECORD l -> (* record construction *)
      if l == [] then (Unit, mem) else 
      let rec listeval (vl, mem, l) = 
        match l with
          | [] -> (vl, mem)
          | h :: lt -> let (v', mem) = eval mem env h in
                       listeval (vl@[v'], mem, lt)
      in
      let rec listassign (mem, env, l) = 
        match l with
          | [] -> (mem, env)
          | h :: lt -> let (id, v) = h in
                       let (loc, mem) = Mem.alloc mem in
                       listassign ((Mem.store mem loc v), (Env.bind env id (Addr loc)), lt)
      in
      let (idl, el) = List.split(l) in
      let (vl, mem) = listeval ([], mem, el) in
      let (mem, env) = listassign (mem, emptyEnv, (List.combine idl vl)) in
      (Record (lookup_env_loc env), mem)
    | FIELD (e, id) -> (* access record field *)
      let (r, mem) = eval mem env e in
      (Mem.load mem ((value_record r) id), mem)
    | ASSIGNF (e1, id, e2) -> (* assign to record field *)
      let (r, mem) = eval mem env e1 in
      let (v, mem) = eval mem env e2 in
      let mem = Mem.store mem ((value_record r) id) v in
      (v, mem)

  let run (mem, env, pgm) = 
    let (v, _ ) = eval mem env pgm in
    v
end
