# Ocaml Stack Machines

A repo that I use to learn Ocaml by making stack machines.

## The Machines

Currently there are currently two machines.

Both use a recursive "main" function.

### The Stack Machine

Found in `lib/StackMachine.ml`. 

This is a classic Stack Machine. Can do some basic math, but that's about it.

Has 7 instructions.

### Stack Machine w/ Acc

A Stack machine with a single register, (the Accumulator).

Each of the below flavors has the same instructions and functionality.
The main difference is that the Minimized version removes comments and
shrinks the State module to a single type. This exists so I can see how
small the code is, while trying to preserve some readability.

The math operations all wind up in the Accumulator.

Has 10 instructions / opcodes.

#### Full Sized

Found in `lib/StackAccMachine.ml`

Fully documented version with a full State module.

#### Minimized

Found in `lib/StackAccMachine_min.ml`.

Yes, I know technically it can be smaller, but my goal here was
more to balance readability with minimalism.

