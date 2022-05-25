(* 2021-15738 Yang Sukhun *)
(* HW2 Exercise4 Priority Queue *)

type heap = EMPTY 
    | NODE of rank * value * heap * heap
        and rank = int
        and value = int

exception EmptyHeap

let rank h = 
    match h with
    | EMPTY -> -1
    | NODE (r, _, _, _) -> r

let rec merge ((lh, rh) : heap * heap) : heap =
    let shake (x, lh, rh) = 
        if (rank lh) >= (rank rh) then NODE(rank rh + 1, x, lh, rh)
        else NODE(rank lh + 1, x, rh, lh)
    in
    match lh, rh with
    | _, EMPTY -> lh
    | EMPTY, _ -> rh
    | NODE(_, v1, l1, r1), NODE(_, v2, _, _) -> 
        if v1 > v2 then merge(rh, lh)
        else shake(v1, l1, merge(r1, rh))

let insert (x, h) = merge(h, NODE(0, x, EMPTY, EMPTY))

let findMin h = 
    match h with
    | EMPTY -> raise EmptyHeap
    | NODE (_, x, _, _) -> x

let deleteMin h = 
    match h with
    | EMPTY -> raise EmptyHeap
    | NODE (_, x, lh, rh) -> merge(lh, rh)
