open Bigarray

type t = (char, int8_unsigned_elt, c_layout) Array1.t 
module To_string : sig
  val blit : src:t -> src_pos:int -> dst:string -> dst_pos:int -> len:int -> unit
  val blito : src:t -> ?src_pos:int -> ?src_len:int -> dst:string -> ?dst_pos:int ->
    unit -> unit
end
module From_string : sig
  val blito : src:string -> ?src_pos:int -> ?src_len:int -> dst:t -> ?dst_pos:int ->
    unit -> unit
end
val blito : src:t -> ?src_pos:int -> ?src_len:int -> dst:t -> ?dst_pos:int ->
  unit -> unit
(* val t_of_sexp : Sexp.t -> t
   val sexp_of_t : t -> Sexp.t *)
val sub_shared : ?pos:int -> ?len:int -> t -> t
val of_string : ?pos : int -> ?len : int -> string -> t
val to_string : ?pos : int -> ?len : int -> t -> string
val subo : ?pos:int -> ?len:int -> t -> t
val length : t -> int
val create : int -> t
