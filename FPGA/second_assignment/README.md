# FPGA Control Unit Instruction Set Reference

This document describes the 8-bit instruction encoding implemented by `control.v`.

Overview:

- Bits [7:6] : instruction class
- Bits [5:3] : destination register (or register index field)
- Bits [2:0] : source register or ALU operation code

Register conventions used in `control.v`:

- `ACC` (accumulator) = address `3'b000` (R0)
- `G` = address `3'b110` (R6) — hard-wired constant `1`
- `H` = address `3'b111` (R7) — hard-wired constant `0`

ALU operation codes (3-bit, used for accumulator operations):

- `000` : NULL / no-op
- `001` : ADD (also used as pass-through when adding 0)
- `010` : INC  (ACC + 1)
- `011` : DEC  (ACC - 1)
- `100` : XOR
- `101` : AND
- `110` : OR
- `111` : NOT (unary, `b` input is ignored / set to `H`)

Opcode classes implemented:

1) `00` — Move register to register

	- Format: `00 DDD SSS`
	- Semantics: write `Rs` into `Rd`.
	- Implementation notes: ALU is used with `aluop = ADD` and `b = H (0)` so `a + 0` passes the source through.

2) `01` — Move immediate to register

	- Format: `01 DDD XXX` (lower 3 bits ignored)
	- Semantics: the next byte on the bus is loaded as the immediate value and written into `Rd`.
	- Implementation notes: `immux` is asserted so the ALU input `a` comes from the immediate value; `b` is `H (0)` and `aluop = ADD` to pass the immediate through.

3) `10` — Accumulator ALU operations

	- Format: `10 RRR OOO`
	- Semantics: operations operate on `ACC` (R0). Results are written back to `ACC`.
	- Operand selection rules (from `control.v`):
	  - For `aluop == 3'b001` (ADD): `b` is the register selected by `RRR` (so `ACC <- ACC + RRR`).
	  - For `aluop == 3'b010` (INC) and `3'b011` (DEC): `b` is `G` (constant 1), producing `ACC+1` or `ACC-1`.
	  - For `aluop == 3'b111` (NOT): `b` is `H` (constant 0); the ALU performs the unary NOT.
	  - For other ALU codes that use two-operand functions (XOR/AND/OR), `b` is `RRR`.

4) `11` — Reserved / not implemented

	- `control.v` does not implement decoding for opcode class `11`; such values are treated as invalid / ignored by the decoder.

State machine and timing notes (matching `control.v`):

- The controller has three states: `S_DECODE`, `S_FETCH_IMM`, and `S_EXECUTE`.
- For immediate writes (`01`), the controller enters `S_FETCH_IMM` to read the next byte into the `imm` register, then proceeds to `S_EXECUTE` to perform the write.
- `writeenable` is asserted only during `S_EXECUTE` (the value is derived as `writeenable = (state == S_EXECUTE)`).

Implementation details and pointers:

- See `control.v` for exact register addresses (`ACC_ADDR`, `G_ADDR`, `H_ADDR`), the local `ALU_ADD` constant, and the explicit state transitions.
- The design intentionally uses `R6` and `R7` as hard-wired constants to simplify unary and increment/decrement operations.

If you want, I can also generate a compact table of supported opcodes (hex ranges) matching `control.v`.
