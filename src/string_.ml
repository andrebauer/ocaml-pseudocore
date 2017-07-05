include Caml.String
         
(* let t_of_sexp s = Conv.string_of_sexp s
   let sexp_of_t t = Conv.sexp_of_string t *)
let equal t1 t2 = (Pervasives.compare t1 t2 = 0)
let hash s = Hashtbl.hash s
let is_empty s = (length s = 0)
let chop_prefix_exn s ~prefix =
  let lenpr = length prefix in
  let pr = sub s 0 lenpr in
  if pr = prefix then
    sub s (lenpr - 1) ((length s) - lenpr)  
  else
    raise Not_found
let split str ~on =
  let rec fold_right (end_,acc) i =
    if i < 0 then
      let item = sub str (i + 1) (end_ - i) in
      item::acc
    else if str.[i] = on then (
      let item = 
        if i = end_ then
          ""
        else
          sub str (i + 1) (end_ - i)
      in
      fold_right (i - 1,item::acc) (i - 1)
    ) else
      fold_right (end_, acc) (i - 1)
  in
  let end_ = (length str) - 1 in
  fold_right (end_,[]) end_
let to_string t = t
let of_string s = s

let blit ~src ~src_pos ~dst ~dst_pos ~len =
  blit src src_pos dst dst_pos len
