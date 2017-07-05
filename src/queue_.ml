include Caml.Queue 

let dequeue t =
  if is_empty t
  then None
  else Some (take t)

let enqueue t a = add a t
