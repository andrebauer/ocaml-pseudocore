type t =
  {
    mutable bstr : Bigstring.t;
    mutable pos : int;
    mutable len : int;
    init : Bigstring.t;
  }  (* [@@deriving sexp] *)


let resize buf more =
  let min_len = buf.len + more in
  let new_len = min_len + min_len in
  let new_buf = Bigstring.create new_len in
  Bigstring.blito ~src:buf.bstr ~src_len:buf.pos ~dst:new_buf ();
  buf.bstr <- new_buf;
  buf.len <- new_len;
;;

let length t = t.pos

let create n =
  let n = max 1 n in
  let bstr = Bigstring.create n in
  {
    bstr = bstr;
    pos = 0;
    len = n;
    init = bstr;
  }

let contents buf = Bigstring.to_string buf.bstr ~len:buf.pos

let volatile_contents buf = buf.bstr

let add_char buf c =
  let pos = buf.pos in
  if pos >= buf.len then resize buf 1;
  buf.bstr.{pos} <- c;
  buf.pos <- pos + 1;
;;

let clear buf = buf.pos <- 0

let add_string buf src =
  let len = String.length src in
  let new_pos = buf.pos + len in
  if new_pos > buf.len then resize buf len;
  Bigstring.From_string.blito ~src ~src_len:len ~dst:buf.bstr ~dst_pos:buf.pos ();
  buf.pos <- new_pos;
;;

let add_buffer buf_dst buf_src =
  let len = buf_src.pos in
  let dst_pos = buf_dst.pos in
  let new_pos = dst_pos + len in
  if new_pos > buf_dst.len then resize buf_dst len;
  Bigstring.blito ~src:buf_src.bstr ~src_len:len ~dst:buf_dst.bstr ~dst_pos ();
  buf_dst.pos <- new_pos;
;;

