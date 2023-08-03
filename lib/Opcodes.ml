type t =
  | PUSHI (* Push Immediate *)
  | PUSHA (* Push Accumulator *)
  | POPI (* Pop Immediate *)
  | POPA (* Pop Accumulator *)
  | ADDS (* Add Stack *)
  | ADDA (* Add Accumulator *)
  | SUBS (* Subtract Stack *)
  | SUBA (* Subtract Accumulator *)
  | MULS (* Multiply Stack *)
  | MULA (* Multiply Accumulator *)
  | DIVS (* Divide Stack *)
  | DIVA (* Divide Accumulator *)
  | LDA (* Load Accumulator *)
  | HLRS (* Halt & Return top of stack *)

let value op =
  match op with
  | PUSHI -> 0x00
  | PUSHA -> 0x01
  | POPI -> 0x05
  | POPA -> 0x06
  | ADDS -> 0x10
  | ADDA -> 0x11
  | SUBS -> 0x15
  | SUBA -> 0x16
  | MULS -> 0x20
  | MULA -> 0x21
  | DIVS -> 0x25
  | DIVA -> 0x26
  | LDA -> 0x30
  | HLRS -> 0xFF

module Values = struct
  let pushi = 0x00
  let pusha = 0x01
  let popi = 0x05
  let popa = 0x06
  let adds = 0x10
  let adda = 0x11
  let subs = 0x15
  let suba = 0x16
  let muls = 0x20
  let mula = 0x21
  let divs = 0x25
  let diva = 0x26
  let lda = 0x30
  let hlrs = 0xFF
end
