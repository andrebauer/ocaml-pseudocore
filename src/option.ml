let value a ~default =
  match a with
  | None -> default
  | Some a -> a

let value_exn = function
  | None -> raise (Failure "Option.value_exn None")
  | Some a -> a

let map a ~f =
  match a with
  |None -> None
  |Some a -> Some (f a)

let value_map a ~default ~f =
  match a with
  |None -> default
  |Some a -> (f a)

let try_with f =
  try
    Some (f ())
  with _ -> None

let iter a ~f =
  match a with
  | None -> ()
  | Some a -> f a

let is_some o = o <> None

module Monad_infix =
struct
  let (>>=) a f =
    match a with 
    | None -> None
    | Some a -> f a

  let (>>|) a f = map a ~f
end
