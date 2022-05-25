(* 2021-15738 Yang Sukhun *)
(* HW1 Exercise2 Sigma *)

let rec sigma ((a, b, f) : int * int * (int -> int)) : int =
    if a > b then 0
    else (f a) + sigma(a+1, b, f)