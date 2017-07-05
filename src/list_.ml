include List
let rev_filter_map l ~f =
  List.fold_left (fun acc a -> 
      match f a with
      | Some a -> a::acc
      | None -> acc
    ) [] l

let filter_map l ~f =
  List.fold_right (fun a acc -> match (f a) with |Some a->a::acc|None->acc) l [];;

let dedup ?compare l =
  let l =
    match compare with
    | Some compare -> fast_sort compare l
    | None -> fast_sort (fun a1 a2 -> Pervasives.compare a1 a2) l
  in
  let (_,l) =
    fold_right (fun a (prev,acc) ->
        if prev <> None && a = Option.value_exn prev then
          (prev,acc)
        else
          (Some a,a::acc)
      ) l (None,[])
  in l

let reduce l ~f =
  match l with
  | [] -> None
  | hd :: [] -> Some hd
  | hd1 :: hd2 :: tl  ->
    let rec reduce_ l acc =
      List.fold_left (fun acc i -> f acc i) acc l
    in Some (reduce_ tl (f hd1 hd2));;

let hd l =
  try
    Some (List.hd l)
  with _ -> None

let rec find_map l ~f =
  match l with
  | [] -> None
  | hd :: tl ->
    match f hd with
    | None -> find_map tl ~f
    | Some b -> Some b

let findi l ~f =
  let rec find_ l i f =
    match l with
    | [] -> None
    | hd :: tl ->
      if f i hd = true then
        Some (i,hd)
      else
        find_ tl (i + 1) f
  in
  find_ l 0 f

let findi_exn l ~f =
  match findi l ~f with
  | None -> raise Not_found
  | Some (i,a) -> (i,a)

let fold t ~init ~f = fold_left f init t

let fold_right t ~f ~init = fold_right f t init

let iter t ~f = iter f t

module Assoc = struct
  type ('a, 'b) t = ('a * 'b) list
  let mem t ?equal a =
    match equal with
    | None -> List.mem_assoc a t
    | Some f -> try let _ = List.find (fun (a1,a2) -> f a1 a) t in true with Not_found -> false
  let inverse t =
    List.fold_right (fun (a,b) acc -> (b,a) :: acc) t [] 
  let find_exn t ?equal a =
    let f =
      match equal with
      | None -> (fun (a1,a2) -> a1 = a)
      | Some f -> (fun (a1,a2) -> f a1 a)
    in
    let (a1,a2) = List.find (fun (a1,a2) -> f (a1,a2)) t in a2
  let find t ?equal a =
    try
      Some (find_exn t ?equal a)
    with Not_found -> None
end
