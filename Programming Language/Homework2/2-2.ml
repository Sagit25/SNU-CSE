(* 2021-15738 Yang Sukhun *)
(* HW2 Exercise2 League String *)

type team = Korea | France | Usa | Brazil | Japan | Nigeria | Cameroon
    | Poland | Portugal | Italy | Germany | Norway | Sweden | England
    | Argentina

type tourna = LEAF of team
    | NODE of tourna * tourna

let rec parenize (t : tourna) : string =
    let namestr (tt : team) : string = 
        match tt with
        | Korea -> "Korea"
        | France -> "France"
        | Usa -> "Usa"
        | Brazil -> "Brazil"
        | Japan -> "Japan"
        | Nigeria -> "Nigeria"
        | Cameroon -> "Cameroon"
        | Poland -> "Poland"
        | Portugal -> "Portugal"
        | Italy -> "Italy"
        | Germany -> "Germany"
        | Norway -> "Norway"
        | Sweden -> "Sweden"
        | England -> "England"
        | Argentina -> "Argentina"
    in
    match t with
    | LEAF a -> namestr(a)
    | NODE (a, b) -> "(" ^ parenize(a) ^ " " ^ parenize(b) ^ ")"