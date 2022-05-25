(* 2021-15738 Yang Sukhun *)
(* HW2 Exercise6 Queue = 2Stacks *)

module type Queue = sig
    type element
    type queue
    exception EMPTY_Q
    val emptyQ: queue
    val enQ: queue * element -> queue
    val deQ: queue -> element * queue
end

module IntListQ = struct
    type element = int list
    type queue = element list * element list
    exception EMPTY_Q
    let emptyQ = ([], [])
    let enQ (((l, r), x) : queue * element) : queue = (x::l, r)
    let rec deQ ((l, r) : queue) : element * queue = 
        match l, r with
        | [], [] -> raise EMPTY_Q
        | l, [] -> deQ([], List.rev(l))
        | l, r -> (List.hd(r), (l, List.tl(r)))
end