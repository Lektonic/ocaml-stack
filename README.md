# Ocaml Stack Machines

A repo that I use to learn Ocaml by making stack machines.

## The Machines

Currently there are currently two machines.

Both use a recursive `run` function that takes in a `int List` which is
the list of instructions to execute.

Each machine also has a fully commented code file, and a minimized file.
The minimized files are to see how much I can strip out of the full version
while still keeping it somewhat readable.

### The Stack Machine

Found in `lib/StackMachine.ml`. 

This is a classic Stack Machine. Can do some basic math, but that's about it.

Has 7 instructions.

### Stack Machine w/ Acc

Found in `lib/StackAccMachine.ml`

A Stack machine with a single register, (the Accumulator).

Each of the below flavors has the same instructions and functionality.
The main difference is that the Minimized version removes comments and
shrinks the State module to a single type. This exists so I can see how
small the code is, while trying to preserve some readability.

The math operations all wind up in the Accumulator.

Support 14 instructions / opcodes. (The entire set defined in `lib/Opcodes.md`)

