(* 2021-15738 Yang Sukhun *)
(* HW1 Exercise1 List Sum *)

let rec merge ((a, b) : int list * int list) : int list = 
    match a, b with
    | a, [] -> a
    | [], b -> b
    | a1 :: aa, b1 :: bb -> 
        if a1 > b1 then [a1] @ merge (aa, b) 
        else [b1] @ merge (a, bb)