open Lib
open Lib.Opcodes.Values

let test_program = [ pushi; 7; pushi; 23; adds; hlrs ]
let () = assert (30 = StackMachine.run test_program)
let () = assert (30 = StackAccMachine.run test_program)

let () =
  assert (
    30 = StackMachine_min.run (StackMachine_min.Runtime (test_program, [])))

let () =
  assert (
    30
    = StackAccMachine_min.run
        (StackAccMachine_min.Runtime (test_program, [], 0)))
