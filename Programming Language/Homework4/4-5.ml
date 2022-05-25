(* 2021-15738 Yang Sukhun *)
(* HW4 Exercise5 Treasure Island *)

type treasure = StarBox | NameBox of string
type key = Bar | Node of key * key
type map = End of treasure
    | Branch of map * map
    | Guide of string * map

type shape = Dontknow of map
    | Single of key
    | Synth of shape * shape

type dictionary = {id: map; mutable k: shape}

exception IMPOSSIBLE
exception Nothing

let rec dicupdate (dic, id, k) = 
    match dic with
    | [] -> [{id = id; k = k}]
    | h :: t ->
        if (h.id = id) then (h.k <- k; dic)
        else [h] @ dicupdate (t, id, k)

let rec findkey (dic, m) = 
    let rec findlock (dic', m') =
        match dic' with
        | [] -> raise Nothing
        | h :: t -> if (h.id = m') then h.k else findlock (t, m')
    in
    let rec caseupdate (dic, k1, k2) = 
        if (k1 = k2) then dic else
        let rec dont (m, k) = 
            match k with
            | Dontknow s -> if (m = s) then true else false
            | Single s -> false
            | Synth (k1, k2) -> (dont (m, k1)) || (dont (m, k2))
        in
        let sinsyn (k, e1, e2) = 
            match k with
            | Bar -> raise IMPOSSIBLE
            | Node (n1, n2) ->
                let dic' = caseupdate (dic, Single n1, e1) in
                caseupdate (dic', Single n2, e2)
        in
        match k1, k2 with
        | Dontknow m1, Dontknow m2 -> dicupdate (dic, m2, findlock (dic, m1))
        | Dontknow m1, Single m2 -> dicupdate (dic, m1, Single m2)
        | Single m1, Dontknow m2 -> dicupdate (dic, m2, Single m1)
        | Dontknow m1, Synth (m21, m22) ->  
            if dont (m1, k2) then raise IMPOSSIBLE
            else dicupdate (dic, m1, k2)
        | Synth (m11, m12), Dontknow m2 ->  
            if dont (m2, k1) then raise IMPOSSIBLE
            else dicupdate (dic, m2, k1)
        | Single m1, Single m2 -> if (k1 = k2) then dic else raise IMPOSSIBLE
        | Single m1, Synth (m21, m22) -> sinsyn (m1, m21, m22)
        | Synth (m11, m12), Single m2 -> sinsyn (m2, m11, m12)
        | Synth (m11, m12), Synth (m21, m22) ->
            let dic' = caseupdate (dic, m11, m21) in 
            caseupdate (dic', m12, m22)
    in
    match m with
    | End StarBox -> (dic, Single Bar)
    | End NameBox s -> 
        (
        try (let k' = findlock (dic, m) in (dic, k'))
        with Nothing -> (dicupdate (dic, m, Dontknow m), Dontknow m)
        )
    | Branch (m1, m2) -> 
        let (dic2, k2) = findkey (dic, m2) in
        let (dic1, k1) = findkey (dic2, m1) in
        let dic' = dicupdate (dic1, m, Dontknow m) in
        let dic'' = caseupdate (dic', k1, Synth (k2, Dontknow m)) in
        (dic'', findlock (dic'', m))
    | Guide (s, m') ->
        let (dic', k) = findkey (dic, m') in
        let k' = findlock (dic', End (NameBox s)) in
        match k, k' with
        | Single k1, Single k2 -> (dic', Single (Node (k2, k1)))
        | _, _ -> (dic', Synth (k', k))

let rec getReady (m : map) : key list = 
    let rec findstar (m') = 
        match m' with
        | End StarBox -> true
        | End NameBox s -> false
        | Branch (m1, m2) -> (findstar m2) || (findstar m1)
        | Guide (s, m'') -> (findstar m'') 
    in
    let rec initialkey (dic, kl, dic0) = 
        match dic with
        | [] -> kl
        | h :: t ->
            match h.id with
            | End NameBox s -> 
                let rec getkey (dic0, h) = 
                    match h with
                    | Single k -> (dic0, k)
                    | Synth (k1, k2) -> 
                        let (dic2, k2') = getkey (dic0, k1) in
                        let (dic1, k1') = getkey (dic2, k2) in
                        (dic1, Node (k2', k1'))
                    | Dontknow s -> 
                        let rec findlock (dic', m') =
                            match dic' with
                            | [] -> raise Nothing
                            | h :: t -> if (h.id = m') then h.k else findlock (t, m')
                        in
                        let m = findlock (dic0, s) in
                        match m with
                        | Dontknow m' ->
                            if (m' = s) then (dicupdate (dic0, s, Single Bar), Bar) 
                            else (let (dic', k') = getkey (dic0, m) in dicupdate (dic', s, Single k'), k')
                        | Single k' -> (dic0, k')
                        | Synth (k1, k2) -> 
                            let (dic', k') = getkey (dic0, m) in
                            (dicupdate (dic', s, Single k'), k')
                in
                let rec newkey (kl, k) =
                    match kl with
                    | [] -> [k]
                    | h :: t -> if (h = k) then kl
                                else [h] @ (newkey (t, k))
                in
                let (dic0', k') = getkey (dic0, h.k) in
                initialkey (t, newkey (kl, k'), dic0')
            | _ -> initialkey (t, kl, dic0)
    in
    let (dic, k) = findkey ([], m) in
    if (findstar m) then initialkey (dic, [Bar], dic)
    else initialkey (dic, [], dic)
    