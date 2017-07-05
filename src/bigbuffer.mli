type t (* [@@deriving sexp] *)
val create : int -> t
val contents : t -> string
val volatile_contents : t -> Bigstring.t
val length : t -> int
val clear : t -> unit
val add_char : t -> char -> unit
val add_string : t -> string -> unit
val add_buffer : t -> t -> unit
