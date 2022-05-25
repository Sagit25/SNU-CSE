(* 2021-15738 Yang Sukhun *)
(* HW1 Exercise4 kFriend *)

type crazy2 = NIL 
    | ZERO of crazy2 
    | ONE of crazy2 
    | MONE of crazy2

let rec crazy2val (f : crazy2) : int = 
    match f with
    | NIL -> 0
    | ZERO g -> 2 * (crazy2val g)
    | ONE g -> 1 + 2 * (crazy2val g)
    | MONE g -> -1 + 2 * (crazy2val g)