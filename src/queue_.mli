include module type of Caml.Queue

val dequeue : 'a t -> 'a option                               
(** [dequeue t] removes and returns the front element of [t], if any.  *)

val enqueue : 'a t -> 'a -> unit                              
(** [enqueue t a] adds [a] to the end of [t]. *)
