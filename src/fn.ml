let compose f g = (); fun x -> f (g x)

let id a = a

let const c = (); fun _ -> c

let non f = (); fun x -> not (f x)
