module State = struct
  type instructions = int list
  type stack = int list
  type accumulator = int
  type runtime = instructions * stack * accumulator
  type t = Exit of int | Exception of runtime * string | Runtime of runtime
end

(* PUSHI - 0x00 : Push Immediate
    Arguments: 1
    Push next value directly to Stack, bypassing accumulator *)
let pushi ((instructions, stack, accumulator) : State.runtime) =
  State.Runtime
    (List.tl instructions, List.hd instructions :: stack, accumulator)

(* POPI - 0x01 : Pop Immediate
    Arguments: 0
    Delete top stack value, do not move it somewhere *)
let popi ((instructions, stack, accumulator) : State.runtime) =
  State.Runtime (instructions, List.tl stack, accumulator)

(* PUSHA - 0x05 : Push Accumulator
    Arguments: 0
    Push Accumulator to stack *)
let pusha (instructions, stack, accumulator) =
  State.Runtime (instructions, accumulator :: stack, accumulator)

(* POPA - 0x06 : Pop to Accumulator
    Arguments: 0
    Pop value from stack into Accumulator *)
let popa (instructions, stack, _) =
  State.Runtime (instructions, List.tl stack, List.hd stack)

(* Stack Math operations *)
let math_stack_op operation (instructions, stack, accumulator) =
  match stack with
  | a :: b :: stack_tail ->
      State.Runtime (instructions, operation a b :: stack_tail, accumulator)
  | _ ->
      State.Exception ((instructions, stack, accumulator), "Not enough Operands")

(* Accumulator Math operations *)
let math_acc_op operation (instructions, stack, accumulator) =
  State.Runtime
    (instructions, List.tl stack, operation accumulator (List.hd stack))

(* Decides if this is a stack or accumulator operation
    Returns one of the math op functions with the operation argument filled.
    Run function will then provide the state argument and finish the function call.
*)
let do_math opcode operation (*state*) =
  (* BEWARE: Functional Black Magic Ahead *)
  match opcode mod 2 with
  | 0 -> math_stack_op operation (* state *)
  | 1 -> math_acc_op operation (* state *)
  | _ -> raise (Failure "Reached Unreachable branch.")

(* LDA - 0x30 : Load Accumulator
    Arguments: 1
    Set accumulator to the next value in instruction set. *)
let lda (instructions, stack, _) =
  State.Runtime (List.tl instructions, stack, List.hd instructions)

(* HLRS - 0xff : Halt and Return
    Arguments: 0
    Has Stack Machine stop execution and return the accumulator value to the caller. *)
let hlrs (_, stack, _) = State.Exit (List.hd stack)

(* Maps opcode values to functions *)
let parse_opcode (opcode : int) =
  match opcode with
  | 0x00 -> pushi
  | 0x01 -> pusha
  | 0x05 -> popi
  | 0x06 -> popa
  (* BEGIN Functional Magic *)
  | 0x10 | 0x11 -> do_math opcode ( + )
  | 0x15 | 0x16 -> do_math opcode ( - )
  | 0x20 | 0x21 -> do_math opcode ( * )
  | 0x25 | 0x26 -> do_math opcode ( / )
  (* END Functional Magic*)
  | 0x30 -> lda
  | 0xff -> hlrs
  | _ -> raise (Failure "Unable to parse opcode")

(* Recursive run call *)
let rec _run (m_state : State.t) =
  match m_state with
  | Exit a -> a
  | Exception (_, s) -> raise (Failure s)
  | Runtime ((i, s, a) : State.runtime) -> (
      match i with
      | [] -> raise (Failure "Out of Instructions")
      | o :: t -> _run (parse_opcode o (t, s, a)))

let run (inst : State.instructions) : int = _run (State.Runtime (inst, [], 0))
