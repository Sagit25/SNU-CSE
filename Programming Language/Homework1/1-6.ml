(* 2021-15738 Yang Sukhun *)
(* HW1 Exercise6 Calculus! *)

type expr = NUM of int
    | PLUS of expr * expr
    | MINUS of expr * expr
    | MULT of expr * expr
    | DIVIDE of expr * expr
    | MAX of expr list

let rec eval (f : expr) : int = 
    let rec findm (l : expr list) : int = 
        match l with
        | [] -> 0
        | a :: [] -> (eval a)
        | a :: b :: c -> if (eval a) > (eval b) then findm([a] @ c)
                         else findm([b] @ c)
    in
    match f with
    | NUM a -> a
    | PLUS (a, b) -> (eval a) + (eval b)
    | MINUS (a, b) -> (eval a) - (eval b)
    | MULT (a, b) -> (eval a) * (eval b)
    | DIVIDE (a, b) -> (eval a) / (eval b)
    | MAX l -> (findm l)
        