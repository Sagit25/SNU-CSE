(* 2021-15738 Yang Sukhun *)
(* HW1 Exercise5 Friend Sum *)

type crazy2 = NIL 
    | ZERO of crazy2 
    | ONE of crazy2 
    | MONE of crazy2

let rec crazy2add ((f, g) : crazy2 * crazy2) : crazy2 = 
    match f, g with
    | NIL, gg -> gg
    | ff, NIL -> ff
    | ONE a, MONE b -> ZERO (crazy2add (a, b))
    | MONE a, ONE b -> ZERO (crazy2add (a, b))
    | ZERO a, ONE b -> ONE (crazy2add (a, b))
    | ZERO a, MONE b -> MONE (crazy2add (a, b))
    | ONE a, ZERO b -> ONE (crazy2add (a, b))
    | MONE a, ZERO b -> MONE (crazy2add (a, b))
    | ZERO a, ZERO b -> ZERO (crazy2add (a, b))
    | ONE a, ONE b -> ZERO (crazy2add((crazy2add (a, b)), ONE(NIL)))
    | MONE a, MONE b -> ZERO (crazy2add((crazy2add (a, b)), MONE(NIL)))