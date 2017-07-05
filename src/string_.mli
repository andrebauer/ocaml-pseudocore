include module type of Caml.String

(* val t_of_sexp : Sexplib.Sexp.t -> string

   val sexp_of_t : string -> Sexplib.Sexp.t *)

val equal : string -> string -> bool

val hash : string -> int

val is_empty : string -> bool

val chop_prefix_exn : string -> prefix:string -> string

val split : string -> on:char -> string list

val to_string : string -> string

val of_string : string -> string

val blit :                                               
    src:string -> src_pos:int -> dst:string -> dst_pos:int -> len:int -> unit 
