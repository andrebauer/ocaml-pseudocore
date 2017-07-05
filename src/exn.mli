type t

exception Finally of t * t

val protect : f:(unit -> 'a) -> finally:(unit -> unit) -> 'a
