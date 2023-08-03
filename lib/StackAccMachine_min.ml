type state =
  | Exit of int
  | Runtime of int list * int list * int
  | Exception of state * string

let pusha (i, s, a) = Runtime (i, a :: s, a)
let popa (i, s, _) = Runtime (i, List.tl s, List.hd s)
let pushi (i, s, a) = Runtime (List.tl i, List.hd i :: s, a)
let popi (i, s, a) = Runtime (i, List.tl s, a)

let math_op opcode (op : int -> int -> int) (i, s, a) =
  match opcode mod 2 with
  | 0 ->
      Runtime (i, op (List.hd s) (List.hd (List.tl s)) :: List.tl (List.tl s), a)
  | 1 -> Runtime (i, List.tl s, op a (List.hd s))
  | _ -> raise (Failure "Unreachable branch")

let lda (i, s, _) = Runtime (List.tl i, s, List.hd i)
let exit (_, _, a) = Exit a

let parse_opcode (o : int) =
  match o with
  | 0x00 -> pusha
  | 0x01 -> pushi
  | 0x05 -> popa
  | 0x06 -> popi
  | 0x10 | 0x11 -> math_op o ( + )
  | 0x15 | 0x16 -> math_op o ( - )
  | 0x20 | 0x21 -> math_op o ( * )
  | 0x25 | 0x26 -> math_op o ( / )
  | 0x30 -> lda
  | 0xff -> exit
  | _ -> raise (Failure "Unable to parse opcode")

let rec run m_state =
  match m_state with
  | Exit a -> a
  | Exception (_, s) -> raise (Failure s)
  | Runtime (i, s, a) -> (
      match i with
      | [] -> raise (Failure "Out of Instructions")
      | o :: t -> run (parse_opcode o (t, s, a)))
