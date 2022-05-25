(* 2021-15738 Yang Sukhun *)
(* HW2 Exercise5 Zip-Zip-Tree *)

type item = string

type tree = LEAF of item
    | NODE of tree list

type zipper = TOP
    | HAND of tree list * zipper * tree list

type location = LOC of tree * zipper

exception NOMOVE of string

let goLeft (loc : location) : location = 
    match loc with 
        | LOC (t, TOP) -> raise (NOMOVE "left of top")
        | LOC (t, HAND ([], up, right)) -> raise (NOMOVE "left of first")
        | LOC (t, HAND (l::left, up, right)) -> LOC (l, HAND (left, up, t::right))

let goRight (loc : location) : location =
    match loc with 
        | LOC (t, TOP) -> raise (NOMOVE "right of top")
        | LOC (t, HAND (left, up, [])) -> raise (NOMOVE "right of first")
        | LOC (t, HAND (left, up, r::right)) -> LOC (r, HAND (t::left, up, right))

let goUp (loc : location) : location =
    match loc with
        | LOC (t, TOP) -> raise (NOMOVE "This root is top")
        | LOC (t, HAND (l, u, r)) -> LOC (NODE (List.rev(l) @ [t] @ r), u)

let goDown (loc : location) : location =
    match loc with
        | LOC (LEAF l, x) -> raise (NOMOVE "This root is bottom")
        | LOC (NODE [], x) -> raise (NOMOVE "Can't move!")
        | LOC (NODE ch, x) -> LOC (List.hd(ch), HAND ([], x, List.tl(ch)))