(* 2021-15738 Yang Sukhun *)
(* HW1 Exercise3 TrueFalse *)

type formula = TRUE
    | FALSE
    | NOT of formula
    | ANDALSO of formula * formula
    | ORELSE of formula * formula
    | IMPLY of formula * formula
    | LESS of expr * expr
and expr = NUM of int
    | PLUS of expr * expr
    | MINUS of expr * expr

let rec number (f : expr) : int =
    match f with
    | NUM a -> a
    | PLUS (a, b) -> (number a) + (number b)
    | MINUS (a, b) -> (number a) - (number b)

let rec eval (f : formula) : bool = 
    match f with
    | TRUE -> true
    | FALSE -> false
    | NOT a -> not (eval a)
    | ANDALSO (a, b) -> (eval a) && (eval b)
    | ORELSE (a, b) -> (eval a) || (eval b)
    | IMPLY (a, b) -> (not (eval a)) || (eval b)
    | LESS (a, b) -> (number a) < (number b)
        
