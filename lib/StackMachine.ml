module State = struct
  type instructions = int list
  type stack = int list
  type runtime = instructions * stack
  type t = Exit of int | Runtime of runtime | Exception of runtime * string
end

(* PUSHI - 0x00 : Push Immediate
    Arguments: 1
    Push next value to the top of the stack. *)
let push ((i, s) : State.runtime) = State.Runtime (List.tl i, List.hd i :: s)

(* POPI - 0x05 : Pop Immediate
    Arguments: 1
    Pop top value off of the top of the stack. *)
let pop ((i, s) : State.runtime) = State.Runtime (i, List.tl s)

(* Stack Math operations *)
let math_stack_op operation (instructions, stack) =
  match stack with
  | a :: b :: stack_tail ->
      State.Runtime (instructions, operation a b :: stack_tail)
  | _ -> State.Exception ((instructions, stack), "Not enough Operands")

(* HLRS - 0xFF : Halt & Return top of stack
    Arguments: 1
    Halts execution and returns the top of the stack to the caller. *)
let hlrs (_, s) = State.Exit (List.hd s)

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

let rec run (m_state : State.t) : int =
  match m_state with
  | Exception (_, error) -> raise (Failure error)
  | Exit a -> a
  | Runtime (i, s) -> (
      match i with
      | [] -> raise (Failure "Out of Instructions")
      | h :: t -> run (parse_opcode h (t, s)))
