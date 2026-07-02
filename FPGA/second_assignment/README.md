# FPGA Control Unit Instruction Set Reference

This README documents the current 8-bit instruction encoding used by the control unit in this project.

The design currently uses the following interpretation:

- Bits [7:6] = instruction class / opcode
- Bits [5:3] = register selector or destination register
- Bits [2:0] = source register or ALU operation code

If an instruction field is not used by the current implementation, it is marked as NULL.

## 1. ALU Operation Encoding

The current control logic uses the lower 3 bits of the instruction as the ALU operation code for the accumulator-based instructions.

| code[2:0] | Meaning |
|---|---|
| 000 | NULL |
| 001 | ADD |
| 010 | INC |
| 011 | DEC |
| 100 | XOR |
| 101 | AND |
| 110 | OR |
| 111 | NOT |

## 2. Full 8-bit Instruction Set

### 2.1 Opcode `00` — Move register to register

Format: `00 DDD SSS`

Meaning: `MOV Rd <- Rs`

| Instruction | Meaning |
|---|---|
| `00000000` (`0x00`) | MOV R0 <- R0 |
| `00000001` (`0x01`) | MOV R0 <- R1 |
| `00000010` (`0x02`) | MOV R0 <- R2 |
| `00000011` (`0x03`) | MOV R0 <- R3 |
| `00000100` (`0x04`) | MOV R0 <- R4 |
| `00000101` (`0x05`) | MOV R0 <- R5 |
| `00000110` (`0x06`) | MOV R0 <- R6 |
| `00000111` (`0x07`) | MOV R0 <- R7 |
| `00001000` (`0x08`) | MOV R1 <- R0 |
| `00001001` (`0x09`) | MOV R1 <- R1 |
| `00001010` (`0x0A`) | MOV R1 <- R2 |
| `00001011` (`0x0B`) | MOV R1 <- R3 |
| `00001100` (`0x0C`) | MOV R1 <- R4 |
| `00001101` (`0x0D`) | MOV R1 <- R5 |
| `00001110` (`0x0E`) | MOV R1 <- R6 |
| `00001111` (`0x0F`) | MOV R1 <- R7 |
| `00010000` (`0x10`) | MOV R2 <- R0 |
| `00010001` (`0x11`) | MOV R2 <- R1 |
| `00010010` (`0x12`) | MOV R2 <- R2 |
| `00010011` (`0x13`) | MOV R2 <- R3 |
| `00010100` (`0x14`) | MOV R2 <- R4 |
| `00010101` (`0x15`) | MOV R2 <- R5 |
| `00010110` (`0x16`) | MOV R2 <- R6 |
| `00010111` (`0x17`) | MOV R2 <- R7 |
| `00011000` (`0x18`) | MOV R3 <- R0 |
| `00011001` (`0x19`) | MOV R3 <- R1 |
| `00011010` (`0x1A`) | MOV R3 <- R2 |
| `00011011` (`0x1B`) | MOV R3 <- R3 |
| `00011100` (`0x1C`) | MOV R3 <- R4 |
| `00011101` (`0x1D`) | MOV R3 <- R5 |
| `00011110` (`0x1E`) | MOV R3 <- R6 |
| `00011111` (`0x1F`) | MOV R3 <- R7 |
| `00100000` (`0x20`) | MOV R4 <- R0 |
| `00100001` (`0x21`) | MOV R4 <- R1 |
| `00100010` (`0x22`) | MOV R4 <- R2 |
| `00100011` (`0x23`) | MOV R4 <- R3 |
| `00100100` (`0x24`) | MOV R4 <- R4 |
| `00100101` (`0x25`) | MOV R4 <- R5 |
| `00100110` (`0x26`) | MOV R4 <- R6 |
| `00100111` (`0x27`) | MOV R4 <- R7 |
| `00101000` (`0x28`) | MOV R5 <- R0 |
| `00101001` (`0x29`) | MOV R5 <- R1 |
| `00101010` (`0x2A`) | MOV R5 <- R2 |
| `00101011` (`0x2B`) | MOV R5 <- R3 |
| `00101100` (`0x2C`) | MOV R5 <- R4 |
| `00101101` (`0x2D`) | MOV R5 <- R5 |
| `00101110` (`0x2E`) | MOV R5 <- R6 |
| `00101111` (`0x2F`) | MOV R5 <- R7 |
| `00110000` (`0x30`) | MOV R6 <- R0 |
| `00110001` (`0x31`) | MOV R6 <- R1 |
| `00110010` (`0x32`) | MOV R6 <- R2 |
| `00110011` (`0x33`) | MOV R6 <- R3 |
| `00110100` (`0x34`) | MOV R6 <- R4 |
| `00110101` (`0x35`) | MOV R6 <- R5 |
| `00110110` (`0x36`) | MOV R6 <- R6 |
| `00110111` (`0x37`) | MOV R6 <- R7 |
| `00111000` (`0x38`) | MOV R7 <- R0 |
| `00111001` (`0x39`) | MOV R7 <- R1 |
| `00111010` (`0x3A`) | MOV R7 <- R2 |
| `00111011` (`0x3B`) | MOV R7 <- R3 |
| `00111100` (`0x3C`) | MOV R7 <- R4 |
| `00111101` (`0x3D`) | MOV R7 <- R5 |
| `00111110` (`0x3E`) | MOV R7 <- R6 |
| `00111111` (`0x3F`) | MOV R7 <- R7 |

### 2.2 Opcode `01` — Move immediate to register

Format: `01 DDD XXX`

Meaning: `MOV Rd <- imm` where the next byte is the immediate value. The lower three bits are not used by the current control logic.

| Instruction | Meaning |
|---|---|
| `01000000` (`0x40`) | MOV R0 <- imm (next byte) |
| `01000001` (`0x41`) | MOV R0 <- imm (next byte) |
| `01000010` (`0x42`) | MOV R0 <- imm (next byte) |
| `01000011` (`0x43`) | MOV R0 <- imm (next byte) |
| `01000100` (`0x44`) | MOV R0 <- imm (next byte) |
| `01000101` (`0x45`) | MOV R0 <- imm (next byte) |
| `01000110` (`0x46`) | MOV R0 <- imm (next byte) |
| `01000111` (`0x47`) | MOV R0 <- imm (next byte) |
| `01001000` (`0x48`) | MOV R1 <- imm (next byte) |
| `01001001` (`0x49`) | MOV R1 <- imm (next byte) |
| `01001010` (`0x4A`) | MOV R1 <- imm (next byte) |
| `01001011` (`0x4B`) | MOV R1 <- imm (next byte) |
| `01001100` (`0x4C`) | MOV R1 <- imm (next byte) |
| `01001101` (`0x4D`) | MOV R1 <- imm (next byte) |
| `01001110` (`0x4E`) | MOV R1 <- imm (next byte) |
| `01001111` (`0x4F`) | MOV R1 <- imm (next byte) |
| `01010000` (`0x50`) | MOV R2 <- imm (next byte) |
| `01010001` (`0x51`) | MOV R2 <- imm (next byte) |
| `01010010` (`0x52`) | MOV R2 <- imm (next byte) |
| `01010011` (`0x53`) | MOV R2 <- imm (next byte) |
| `01010100` (`0x54`) | MOV R2 <- imm (next byte) |
| `01010101` (`0x55`) | MOV R2 <- imm (next byte) |
| `01010110` (`0x56`) | MOV R2 <- imm (next byte) |
| `01010111` (`0x57`) | MOV R2 <- imm (next byte) |
| `01011000` (`0x58`) | MOV R3 <- imm (next byte) |
| `01011001` (`0x59`) | MOV R3 <- imm (next byte) |
| `01011010` (`0x5A`) | MOV R3 <- imm (next byte) |
| `01011011` (`0x5B`) | MOV R3 <- imm (next byte) |
| `01011100` (`0x5C`) | MOV R3 <- imm (next byte) |
| `01011101` (`0x5D`) | MOV R3 <- imm (next byte) |
| `01011110` (`0x5E`) | MOV R3 <- imm (next byte) |
| `01011111` (`0x5F`) | MOV R3 <- imm (next byte) |
| `01100000` (`0x60`) | MOV R4 <- imm (next byte) |
| `01100001` (`0x61`) | MOV R4 <- imm (next byte) |
| `01100010` (`0x62`) | MOV R4 <- imm (next byte) |
| `01100011` (`0x63`) | MOV R4 <- imm (next byte) |
| `01100100` (`0x64`) | MOV R4 <- imm (next byte) |
| `01100101` (`0x65`) | MOV R4 <- imm (next byte) |
| `01100110` (`0x66`) | MOV R4 <- imm (next byte) |
| `01100111` (`0x67`) | MOV R4 <- imm (next byte) |
| `01101000` (`0x68`) | MOV R5 <- imm (next byte) |
| `01101001` (`0x69`) | MOV R5 <- imm (next byte) |
| `01101010` (`0x6A`) | MOV R5 <- imm (next byte) |
| `01101011` (`0x6B`) | MOV R5 <- imm (next byte) |
| `01101100` (`0x6C`) | MOV R5 <- imm (next byte) |
| `01101101` (`0x6D`) | MOV R5 <- imm (next byte) |
| `01101110` (`0x6E`) | MOV R5 <- imm (next byte) |
| `01101111` (`0x6F`) | MOV R5 <- imm (next byte) |
| `01110000` (`0x70`) | MOV R6 <- imm (next byte) |
| `01110001` (`0x71`) | MOV R6 <- imm (next byte) |
| `01110010` (`0x72`) | MOV R6 <- imm (next byte) |
| `01110011` (`0x73`) | MOV R6 <- imm (next byte) |
| `01110100` (`0x74`) | MOV R6 <- imm (next byte) |
| `01110101` (`0x75`) | MOV R6 <- imm (next byte) |
| `01110110` (`0x76`) | MOV R6 <- imm (next byte) |
| `01110111` (`0x77`) | MOV R6 <- imm (next byte) |
| `01111000` (`0x78`) | MOV R7 <- imm (next byte) |
| `01111001` (`0x79`) | MOV R7 <- imm (next byte) |
| `01111010` (`0x7A`) | MOV R7 <- imm (next byte) |
| `01111011` (`0x7B`) | MOV R7 <- imm (next byte) |
| `01111100` (`0x7C`) | MOV R7 <- imm (next byte) |
| `01111101` (`0x7D`) | MOV R7 <- imm (next byte) |
| `01111110` (`0x7E`) | MOV R7 <- imm (next byte) |
| `01111111` (`0x7F`) | MOV R7 <- imm (next byte) |

### 2.3 Opcode `10` — Accumulator ALU operation

Format: `10 RRR OOO`

Meaning: `ACC <- ACC op RRR` or `ACC <- ACC op 1` / `ACC <- NOT ACC` depending on the operation code.

| Instruction | Meaning |
|---|---|
| `10000000` (`0x80`) | ACC <- ACC op R0 (op=000) -> NULL |
| `10000001` (`0x81`) | ACC <- ACC + R0 |
| `10000010` (`0x82`) | ACC <- ACC + 1 |
| `10000011` (`0x83`) | ACC <- ACC - 1 |
| `10000100` (`0x84`) | ACC <- ACC XOR R0 |
| `10000101` (`0x85`) | ACC <- ACC AND R0 |
| `10000110` (`0x86`) | ACC <- ACC OR R0 |
| `10000111` (`0x87`) | ACC <- NOT ACC |
| `10001000` (`0x88`) | ACC <- ACC op R1 (op=000) -> NULL |
| `10001001` (`0x89`) | ACC <- ACC + R1 |
| `10001010` (`0x8A`) | ACC <- ACC + 1 |
| `10001011` (`0x8B`) | ACC <- ACC - 1 |
| `10001100` (`0x8C`) | ACC <- ACC XOR R1 |
| `10001101` (`0x8D`) | ACC <- ACC AND R1 |
| `10001110` (`0x8E`) | ACC <- ACC OR R1 |
| `10001111` (`0x8F`) | ACC <- NOT ACC |
| `10010000` (`0x90`) | ACC <- ACC op R2 (op=000) -> NULL |
| `10010001` (`0x91`) | ACC <- ACC + R2 |
| `10010010` (`0x92`) | ACC <- ACC + 1 |
| `10010011` (`0x93`) | ACC <- ACC - 1 |
| `10010100` (`0x94`) | ACC <- ACC XOR R2 |
| `10010101` (`0x95`) | ACC <- ACC AND R2 |
| `10010110` (`0x96`) | ACC <- ACC OR R2 |
| `10010111` (`0x97`) | ACC <- NOT ACC |
| `10011000` (`0x98`) | ACC <- ACC op R3 (op=000) -> NULL |
| `10011001` (`0x99`) | ACC <- ACC + R3 |
| `10011010` (`0x9A`) | ACC <- ACC + 1 |
| `10011011` (`0x9B`) | ACC <- ACC - 1 |
| `10011100` (`0x9C`) | ACC <- ACC XOR R3 |
| `10011101` (`0x9D`) | ACC <- ACC AND R3 |
| `10011110` (`0x9E`) | ACC <- ACC OR R3 |
| `10011111` (`0x9F`) | ACC <- NOT ACC |
| `10100000` (`0xA0`) | ACC <- ACC op R4 (op=000) -> NULL |
| `10100001` (`0xA1`) | ACC <- ACC + R4 |
| `10100010` (`0xA2`) | ACC <- ACC + 1 |
| `10100011` (`0xA3`) | ACC <- ACC - 1 |
| `10100100` (`0xA4`) | ACC <- ACC XOR R4 |
| `10100101` (`0xA5`) | ACC <- ACC AND R4 |
| `10100110` (`0xA6`) | ACC <- ACC OR R4 |
| `10100111` (`0xA7`) | ACC <- NOT ACC |
| `10101000` (`0xA8`) | ACC <- ACC op R5 (op=000) -> NULL |
| `10101001` (`0xA9`) | ACC <- ACC + R5 |
| `10101010` (`0xAA`) | ACC <- ACC + 1 |
| `10101011` (`0xAB`) | ACC <- ACC - 1 |
| `10101100` (`0xAC`) | ACC <- ACC XOR R5 |
| `10101101` (`0xAD`) | ACC <- ACC AND R5 |
| `10101110` (`0xAE`) | ACC <- ACC OR R5 |
| `10101111` (`0xAF`) | ACC <- NOT ACC |
| `10110000` (`0xB0`) | ACC <- ACC op R6 (op=000) -> NULL |
| `10110001` (`0xB1`) | ACC <- ACC + R6 |
| `10110010` (`0xB2`) | ACC <- ACC + 1 |
| `10110011` (`0xB3`) | ACC <- ACC - 1 |
| `10110100` (`0xB4`) | ACC <- ACC XOR R6 |
| `10110101` (`0xB5`) | ACC <- ACC AND R6 |
| `10110110` (`0xB6`) | ACC <- ACC OR R6 |
| `10110111` (`0xB7`) | ACC <- NOT ACC |
| `10111000` (`0xB8`) | ACC <- ACC op R7 (op=000) -> NULL |
| `10111001` (`0xB9`) | ACC <- ACC + R7 |
| `10111010` (`0xBA`) | ACC <- ACC + 1 |
| `10111011` (`0xBB`) | ACC <- ACC - 1 |
| `10111100` (`0xBC`) | ACC <- ACC XOR R7 |
| `10111101` (`0xBD`) | ACC <- ACC AND R7 |
| `10111110` (`0xBE`) | ACC <- ACC OR R7 |
| `10111111` (`0xBF`) | ACC <- NOT ACC |

### 2.4 Opcode `11` — Register ALU operation

Format: `11 RRR OOO`

Meaning: `R <- R op 1` where the operation comes from the lower 3 bits.
 
| Instruction | Meaning |
|---|---|
| `11000000` (`0xC0`) | R0 <- R0 op 1 (op=000) -> NULL |
| `11000001` (`0xC1`) | R0 <- R0 + 1 |
| `11000010` (`0xC2`) | R0 <- R0 + 1 |
| `11000011` (`0xC3`) | R0 <- R0 - 1 |
| `11000100` (`0xC4`) | R0 <- R0 XOR 1 |
| `11000101` (`0xC5`) | R0 <- R0 AND 1 |
| `11000110` (`0xC6`) | R0 <- R0 OR 1 |
| `11000111` (`0xC7`) | R0 <- NOT R0 |
| `11001000` (`0xC8`) | R1 <- R1 op 1 (op=000) -> NULL |
| `11001001` (`0xC9`) | R1 <- R1 + 1 |
| `11001010` (`0xCA`) | R1 <- R1 + 1 |
| `11001011` (`0xCB`) | R1 <- R1 - 1 |
| `11001100` (`0xCC`) | R1 <- R1 XOR 1 |
| `11001101` (`0xCD`) | R1 <- R1 AND 1 |
| `11001110` (`0xCE`) | R1 <- R1 OR 1 |
| `11001111` (`0xCF`) | R1 <- NOT R1 |
| `11010000` (`0xD0`) | R2 <- R2 op 1 (op=000) -> NULL |
| `11010001` (`0xD1`) | R2 <- R2 + 1 |
| `11010010` (`0xD2`) | R2 <- R2 + 1 |
| `11010011` (`0xD3`) | R2 <- R2 - 1 |
| `11010100` (`0xD4`) | R2 <- R2 XOR 1 |
| `11010101` (`0xD5`) | R2 <- R2 AND 1 |
| `11010110` (`0xD6`) | R2 <- R2 OR 1 |
| `11010111` (`0xD7`) | R2 <- NOT R2 |
| `11011000` (`0xD8`) | R3 <- R3 op 1 (op=000) -> NULL |
| `11011001` (`0xD9`) | R3 <- R3 + 1 |
| `11011010` (`0xDA`) | R3 <- R3 + 1 |
| `11011011` (`0xDB`) | R3 <- R3 - 1 |
| `11011100` (`0xDC`) | R3 <- R3 XOR 1 |
| `11011101` (`0xDD`) | R3 <- R3 AND 1 |
| `11011110` (`0xDE`) | R3 <- R3 OR 1 |
| `11011111` (`0xDF`) | R3 <- NOT R3 |
| `11100000` (`0xE0`) | R4 <- R4 op 1 (op=000) -> NULL |
| `11100001` (`0xE1`) | R4 <- R4 + 1 |
| `11100010` (`0xE2`) | R4 <- R4 + 1 |
| `11100011` (`0xE3`) | R4 <- R4 - 1 |
| `11100100` (`0xE4`) | R4 <- R4 XOR 1 |
| `11100101` (`0xE5`) | R4 <- R4 AND 1 |
| `11100110` (`0xE6`) | R4 <- R4 OR 1 |
| `11100111` (`0xE7`) | R4 <- NOT R4 |
| `11101000` (`0xE8`) | R5 <- R5 op 1 (op=000) -> NULL |
| `11101001` (`0xE9`) | R5 <- R5 + 1 |
| `11101010` (`0xEA`) | R5 <- R5 + 1 |
| `11101011` (`0xEB`) | R5 <- R5 - 1 |
| `11101100` (`0xEC`) | R5 <- R5 XOR 1 |
| `11101101` (`0xED`) | R5 <- R5 AND 1 |
| `11101110` (`0xEE`) | R5 <- R5 OR 1 |
| `11101111` (`0xEF`) | R5 <- NOT R5 |
| `11110000` (`0xF0`) | R6 <- R6 op 1 (op=000) -> NULL |
| `11110001` (`0xF1`) | R6 <- R6 + 1 |
| `11110010` (`0xF2`) | R6 <- R6 + 1 |
| `11110011` (`0xF3`) | R6 <- R6 - 1 |
| `11110100` (`0xF4`) | R6 <- R6 XOR 1 |
| `11110101` (`0xF5`) | R6 <- R6 AND 1 |
| `11110110` (`0xF6`) | R6 <- R6 OR 1 |
| `11110111` (`0xF7`) | R6 <- NOT R6 |
| `11111000` (`0xF8`) | R7 <- R7 op 1 (op=000) -> NULL |
| `11111001` (`0xF9`) | R7 <- R7 + 1 |
| `11111010` (`0xFA`) | R7 <- R7 + 1 |
| `11111011` (`0xFB`) | R7 <- R7 - 1 |
| `11111100` (`0xFC`) | R7 <- R7 XOR 1 |
| `11111101` (`0xFD`) | R7 <- R7 AND 1 |
| `11111110` (`0xFE`) | R7 <- R7 OR 1 |
| `11111111` (`0xFF`) | R7 <- NOT R7 |

## 3. Notes

- This README reflects the current behavior of the Verilog control logic.
- The opcode classes `00`, `01`, `10`, and `11` are the only ones currently decoded.
- Any instruction with an unassigned operation code is marked as NULL.
- The immediate-form instructions use the next byte as the data value.
