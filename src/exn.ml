type t = exn
exception Finally of t * t
let protectx ~f x ~(finally : _ -> unit) =
  let res =
    try f x
    with exn ->
      (try finally x with final_exn -> raise (Finally (exn, final_exn)));
      raise exn
  in
  finally x;
  res

let protect ~f ~finally = protectx ~f () ~finally
