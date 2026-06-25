# 8-bit ALU (Arithmetic Logic Unit) - FPGA Assignment

## Student Information
Name:- Bishesh Paudel
Roll No: 079BEI016

---

## Project Overview
This project implements an 8-bit Arithmetic Logic Unit (ALU) in Verilog, designed to perform various arithmetic and logical operations on two 8-bit inputs. The ALU is a fundamental component in digital circuit design and serves as the computational core in microprocessors.

---

## Project Components

### 1. ALU.v - Main Module
The core ALU module (`eight_bit_alu`) that implements operations.

Supported Operations:

| Selection (sel) | Operation | Description |
|---|---|---|
| 000 | Addition | a + b |
| 001 | Subtraction | a - b |
| 010 | AND | a AND b (bitwise) |
| 011 | OR | a OR b (bitwise) |
| 100 | XOR | a XOR b (bitwise) |
| 101 | NOT | NOT a (bitwise complement) |
| 110 | Left Shift | a << 1 (left shift by 1) |
| 111 | Right Shift | b >> 1 (right shift by 1) |

### 2. alu_tb.v - Testbench
The testbench module (`eight_bit_alu_tb`) that validates the ALU functionality.

**Testing Features:**
- Monitors all inputs and outputs in real-time
- Tests all 8 operations with different operand values
- Generates waveform data in VCD format for visualization
- Each test case runs for 100 ns

Test Cases:
- Addition: 0xFF + 0xF0
- Subtraction: 0x0A - 0xF0
- AND Operation: 0x8D AND 0xF0
- OR Operation: 0x3E OR 0xF0
- XOR Operation: 0x3E XOR 0xF0
- NOT Operation: NOT 0x3E
- Left Shift: 0x3E << 1
- Right Shift: 0xF0 >> 1

3. eight_bit_tb.vcd - Waveform File
VCD (Value Change Dump) file containing the simulation waveforms for visualization in waveform viewers.

## Conclusion
This 8-bit ALU implementation demonstrates fundamental FPGA design concepts including modular design, testbench development, and functional verification through simulation.
