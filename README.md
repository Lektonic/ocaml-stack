# Ocaml Stack Machines

A repo that I use to learn Ocaml by making stack machines.

## The Machines

Currently there are currently two machines.

Both use a recursive `run` function that takes in a `int List` which is
the list of instructions to execute.

The stack is a list of integers provided to the run function. This allows it
to function a bit closer to how a CPU would function. Next steps would be to
get a bit closer, so this is less of a skin deep comparison.

These machines lack any type of control flow aside from halting. There exist
no opcodes currently that allow the stack to grow larger then it was before
executing the operation.

### High-level Overview

Steps:
    1. Pop top value off of stack
    2. Decode value into an operation
    3. Pops the needed number of arguments off the stack
    4. Perform operation
    5. Push result to stack
    6. Go to Step 1

The machine will run until getting a halt instruction, or an error state.

### The Stack Machine

Found in `lib/StackMachine.ml`. 

This is a classic Stack Machine. Can do some basic math, but that's about it.

Has 7 instructions.

### Stack Machine w/ Register

Found in `lib/StackAccMachine.ml`

A Stack machine with a single register, (the Accumulator).

Supports 14 instructions / opcodes. (The entire set defined in `lib/Opcodes.md`)

