(* 2021-15738 Yang Sukhun *)
(* HW4 Exercise4 Happy Worries *)

type require = id * (cond list)
    and cond = Items of gift list (* gifts *)
    | Same of id (* same gifts as for id *)
    | Common of cond * cond (* gifts of common conditions *)
    | Except of cond * gift list (* exclude gifts *)
    and gift = int (* gift number *)
    and id = A | B | C | D | E (* id names *)

let rec makeGifts ((gl, r) : (id * gift list) list * cond) : gift list = 
    match r with
    | Items l -> List.sort_uniq compare l
    | Same id -> 
        snd (List.find (fun x -> if (fst x = id) then true else false) gl)
    | Common (c1, c2) -> 
        let l' = makeGifts (gl, c1) in
        let l'' = makeGifts (gl, c2) in
        let rec makeCommon (l1, l2) =  
            match l1 with
            | [] -> []
            | h :: t -> 
                let rec checkIn (li, a) = 
                    match li with
                    | [] -> false
                    | h' :: t' -> 
                        if (h' = a) then true
                        else checkIn (t', a) 
                in
                if checkIn (l2, h) then h :: makeCommon (t, l2) 
                else makeCommon (t, l2)
        in
        makeCommon (l', l'')
    | Except (c, l) -> 
        let l' = makeGifts (gl, c) in
        match l with
        | [] -> l'
        | h :: t ->
            let rec makeExcept (l1, l2) =
                let rec del (l, a) = 
                    match l with
                    | [] -> []
                    | h :: t -> if (h = a) then t
                    else h :: del (t, a) 
                in 
                match l2 with
                | [] -> l1
                | h :: t -> makeExcept (del (l1, h), t)
            in 
            makeExcept (l', l)

let rec findList ((now, rl) : (id * gift list) list * require list) : (id * gift list) list = 
    let past (r) = 
        snd (List.find (fun x -> if (fst x = fst r) then true else false) now)
    in
    let neww (x) = 
        let listUpdate z y = z @ (makeGifts (now, y)) in
        let initialList = List.fold_left listUpdate [] (snd x) in
        List.sort_uniq compare initialList
    in
    let next = 
        let concat a b =
            a @ [(fst b), List.sort_uniq compare (List.merge compare (past b) (neww b))]
        in 
        List.fold_left concat [] rl
    in
    if (now = next) then now else findList (next, rl)

let shoppingList (rl : require list) : (id * gift list) list = 
    let initial_value = [(A, []); (B, []); (C, []); (D, []); (E, [])] in
    let cmp a b = if (fst a > fst b) then 1 else -1 in
    findList (initial_value, List.sort cmp rl)