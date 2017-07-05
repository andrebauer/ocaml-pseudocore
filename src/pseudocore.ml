(* open Sexplib
   open Sexplib.Conv *)


include (Shadow_stdlib
         : module type of struct include Shadow_stdlib end
         (* Modules defined in Pseudocore *)
         with module Array     := Caml.Array
         with module Buffer    := Caml.Buffer
         with module Char      := Caml.Char
         with module Hashtbl   := Caml.Hashtbl
         with module Int32     := Caml.Int32
         with module Int64     := Caml.Int64
         with module Lazy      := Caml.Lazy
         with module List      := Caml.List
         with module Map       := Caml.Map
         with module Nativeint := Caml.Nativeint
         with module Printf    := Caml.Printf
         with module Random    := Caml.Random
         with module Set       := Caml.Set
         with module Queue     := Caml.Queue
         with module String    := Caml.String 
         with module Sys       := Caml.Sys
         with module Uchar     := Caml.Uchar

         (* Support for generated lexers *)
         with module Lexing    := Caml.Lexing

         with type ('a, 'b, 'c) format              := ('a, 'b, 'c) format
         with type ('a, 'b, 'c, 'd) format4         := ('a, 'b, 'c, 'd) format4
         with type ('a, 'b, 'c, 'd, 'e, 'f) format6 := ('a, 'b, 'c, 'd, 'e, 'f) format6

         with type 'a ref := 'a ref
        )

(*
open! Import0 
*)

module Option = Option
module Queue = Queue_
module String = String_
module Bigstring = Bigstring
module Bigbuffer = Bigbuffer
module Exn = Exn
module Fn = Fn
module Result = Result
module List = List_
module Staged = Staged

let unstage = Staged.unstage
let sprintf = Fmt.strf


let (|!) a f = f a

