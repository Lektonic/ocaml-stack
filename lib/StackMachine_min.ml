type state =
  | Exit of int
  | Runtime of int list * int list
  | Exception of state * string

let push (i, s) = Runtime (List.tl i, List.hd i :: s)
let pop (i, s) = Runtime (i, List.tl s)

let math_stack_op operation (instructions, stack) =
  match stack with
  | a :: b :: stack_tail -> Runtime (instructions, operation a b :: stack_tail)
  | _ -> Exception (Runtime (instructions, stack), "Not enough Operands")

let hlrs (_, s) = Exit (List.hd s)

let parse_opcode (op : int) =
  match op with
  | 0x00 -> push
  | 0x05 -> pop
  | 0x10 -> math_stack_op ( + )
  | 0x15 -> math_stack_op ( - )
  | 0x20 -> math_stack_op ( * )
  | 0x25 -> math_stack_op ( / )
  | 0xff -> hlrs
  | _ -> raise (Failure "Unknown opcode")

let rec run (m_state : state) : int =
  match m_state with
  | Exception (_, error) -> raise (Failure error)
  | Exit a -> a
  | Runtime (i, s) -> (
      match i with
      | [] -> raise (Failure "Out of Instructions")
      | h :: t -> run ((parse_opcode h) (t, s)))
