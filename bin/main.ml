open Lib
open Lib.Opcodes.Values

let a = StackAccMachine.run [ pushi; 7; pushi; 23; adds; popa; hlrs ]
let () = print_endline (string_of_int a)
