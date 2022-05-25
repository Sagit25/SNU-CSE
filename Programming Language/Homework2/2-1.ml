(* 2021-15738 Yang Sukhun *)
(* HW2 Exercise1 Iterator *)

let rec iter ((n, f) : int * ('a -> 'a)) : ('a -> 'a) = 
    if n <= 0 then function x -> x
    else let comp ((f, g) : ('a -> 'a) * ('a -> 'a)) = function x -> f(g(x)) 
        in comp (f, iter(n-1, f))
