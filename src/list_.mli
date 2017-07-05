include module type of List
val rev_filter_map : 'a list -> f:('a -> 'b option) -> 'b list
val filter_map : 'a list -> f:('a -> 'b option) -> 'b list
val reduce : 'a list -> f:('a -> 'a -> 'a) -> 'a option
val dedup : ?compare:('a -> 'a -> int) -> 'a list -> 'a list
val hd : 'a list -> 'a option
val find_map : 'a list -> f:('a -> 'b option) -> 'b option
val findi : 'a list -> f:(int -> 'a -> bool) -> (int * 'a) option
val findi_exn : 'a list -> f:(int -> 'a -> bool) -> (int * 'a)
val fold :  'a list -> init:'accum -> f:('accum -> 'a -> 'accum) -> 'accum

val fold_right : 'a list -> f:('a -> 'b -> 'b) -> init:'b -> 'b

val iter : 'a list -> f:('a -> unit) -> unit 
module Assoc : sig
  type ('a, 'b) t = ('a * 'b) list
  val mem : ('a, 'b) t -> ?equal:('a -> 'a -> bool) -> 'a -> bool
  val inverse : ('a, 'b) t -> ('b, 'a) t
  val find_exn : ('a, 'b) t -> ?equal:('a -> 'a -> bool) -> 'a -> 'b
  val find : ('a, 'b) t -> ?equal:('a -> 'a -> bool) -> 'a -> 'b option
end
