include
  (Shadow_stdlib
   : (module type of struct include Shadow_stdlib end
       with type 'a ref                           := 'a ref
       with type ('a, 'b, 'c) format              := ('a, 'b, 'c) format
       with type ('a, 'b, 'c, 'd) format4         := ('a, 'b, 'c, 'd) format4
       with type ('a, 'b, 'c, 'd, 'e, 'f) format6 := ('a, 'b, 'c, 'd, 'e, 'f) format6
       with module Pervasives := Pervasives
       (* These modules are redefined in Base *)
       with module String    := Caml.String
       with module Queue     := Caml.Queue
     ))
