(* 2021-15738 Yang Sukhun *)
(* HW2 Exercise3 Mathemadiga *)

type ae = CONST of int
    | VAR of string
    | POWER of string * int
    | TIMES of ae list
    | SUM of ae list

exception InvalidArgument

let rec diff ((f, x) : ae * string) : ae =
    match f with
    | CONST a -> CONST 0
    | VAR a -> if a = x then CONST 1 else CONST 0
    | POWER (a, n) -> if a = x then 
                          if n = 0 then CONST 0
                          else TIMES ([CONST n; POWER (a, n-1)]) 
                      else CONST 0
    | TIMES [] -> raise InvalidArgument
    | TIMES l -> let g = function y -> 
                 TIMES ([diff(y, x)] @ List.find_all (function z -> z != y) l) in
                 SUM (List.map g l)
    | SUM [] -> raise InvalidArgument
    | SUM l -> let g = function y -> diff(y, x) in
               SUM (List.map g l)
               