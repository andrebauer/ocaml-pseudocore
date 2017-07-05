open Bigarray

type t = (char, int8_unsigned_elt, c_layout) Array1.t

let length = Array1.dim

let create size = Array1.create char c_layout size

let rec copy f len = function
  | l when l = len -> ()
  | i -> f i; copy f len (i + 1)

module To_string = struct
  let blit ~src ~src_pos ~dst ~dst_pos ~len =
    copy (fun i -> dst.[dst_pos + i] <- src.{src_pos + i}) len 0
  let blito ~src ?src_pos ?src_len ~dst ?dst_pos () =
    let src_pos = Option.value src_pos ~default:0 in
    let len = Option.value src_len ~default:((length src) - src_pos) in
    let dst_pos = Option.value dst_pos ~default:0 in
    blit ~src ~src_pos ~dst ~dst_pos ~len
end
module From_string = struct
  let blito ~src ?src_pos ?src_len ~dst ?dst_pos () =
    let src_pos = Option.value src_pos ~default:0 in
    let src_len = Option.value src_len ~default:((String.length src) - src_pos) in
    let dst_pos = Option.value dst_pos ~default:0 in
    copy (fun i -> dst.{dst_pos + i} <- src.[src_pos + i]) src_len 0
end

let blito ~src ?src_pos ?src_len ~dst ?dst_pos () =
  let src_pos = Option.value src_pos ~default:0 in
  let src_len = Option.value src_len ~default:((length src) - src_pos) in
  let dst_pos = Option.value dst_pos ~default:0 in
  copy (fun i -> dst.{dst_pos + i} <- src.{src_pos + i}) src_len 0

(* let t_of_sexp s = 
   let l = Conv.list_of_sexp (fun cs -> Conv.char_of_sexp cs) s in
   let t = create (List.length l) in
   List.iteri (fun i c -> t.{i} <- c) l;
   t

   let sexp_of_t t = 
   let len = length t in
   let rec fold_right acc = function
     | l when l = len -> acc
     | i -> fold_right ((t.{len - i - 1}) :: acc) (i + 1)
   in
   Conv.sexp_of_list (fun c -> Conv.sexp_of_char c) (fold_right [] 0) *)

let get_opt_len bstr ~pos = function
  | Some len -> len
  | None -> length bstr - pos

let sub_shared ?(pos = 0) ?len (bstr : t) =
  let len = get_opt_len bstr ~pos len in
  Array1.sub bstr pos len

let of_string ?pos ?len src = 
  let src_pos = Option.value pos ~default:0 in
  let src_len = Option.value len ~default:((String.length src) - src_pos) in
  let dst = Array1.create char c_layout src_len in
  From_string.blito ~src ~src_pos ~src_len ~dst ();
  dst

let to_string ?pos ?len src = 
  let src_pos = Option.value pos ~default:0 in
  let src_len = Option.value len ~default:((length src) - src_pos) in
  let dst = Bytes.create src_len in
  To_string.blito ~src ~src_pos ~src_len ~dst ();
  dst

let subo ?pos ?len t =
  let pos = Option.value pos ~default:0 in
  let len = Option.value len ~default:((length t) - pos) in
  let dst = Array1.create char c_layout len in
  let src = Array1.sub t pos len in
  Array1.blit src dst;
  dst
