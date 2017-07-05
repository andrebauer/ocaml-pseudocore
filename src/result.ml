type ('ok, 'err) t = 
  | Ok of 'ok
  | Error of 'err

let of_option o ~error =
  match o with 
  | None -> Error error
  | Some o -> Ok o

let ok_or_failwith = function
  | Ok ok -> ok
  | Error err -> failwith err

let ok = function
  | Ok ok -> Some ok
  | Error err -> None

let map_error r ~f =
  match r with
  | Ok o -> Ok o
  | Error e -> Error (f e)

module Monad_infix =
struct
  let (>>|) a f = 
    match a with
    | Error e -> Error e
    | Ok b -> Ok (f b)
  let (>>=) a f =
    match a with
    | Error e -> Error e
    | Ok b -> f b
end
