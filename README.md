# 8-bit CPU Design in Verilog

This project implements a simple 8-bit CPU using Verilog, supporting basic arithmetic, logic operations, load/store, and jump instructions. This README provides instructions on setting up, simulating, and interacting with the CPU.

## Table of Contents

1. [Introduction](#introduction)
2. [Project Structure](#project-structure)
3. [Setup](#setup)
4. [Simulation](#simulation)
5. [Instruction Set](#instruction-set)
6. [Interacting with the CPU](#interacting-with-the-cpu)

## Introduction

The 8-bit CPU is designed to execute a set of instructions from an instruction memory. It supports basic arithmetic and logic operations, load/store operations with data memory, and jump instructions for control flow.

## Project Structure

    ├── alu.v
    ├── control_unit.v
    ├── cpu.v
    ├── data_memory.v
    ├── instruction_memory.v
    ├── register_file.v
    ├── testbench.v
    └── README.md


- `alu.v`: Implements the Arithmetic Logic Unit.
- `control_unit.v`: Implements the Control Unit for instruction decoding.
- `cpu.v`: Top-level module integrating all components.
- `data_memory.v`: Implements the Data Memory.
- `instruction_memory.v`: Implements the Instruction Memory.
- `register_file.v`: Implements the Register File.
- `testbench.v`: Testbench for simulating the CPU.

## Setup

To run this project, you need a Verilog simulator like ModelSim, Vivado, or any other Verilog simulation tool.

1. Clone the repository:
   ```sh
   git clone <repository_url>
   cd <repository_directory>
2. Ensure you have a Verilog simulator installed on your system.

## Simulation
1. Open your Verilog simulator.
2. Add all the Verilog files (alu.v, control_unit.v, cpu.v, data_memory.v, instruction_memory.v, register_file.v, testbench.v) to your project.
3. Set testbench.v as the top module for simulation.
4. Run the simulation.
5. The testbench provides an initial set of instructions to test the CPU. You can modify the instruction_memory.v file to change or add new instructions.

## Instruction Set
The CPU supports the following instructions:

    0000: ADD (Add)
    0001: SUB (Subtract)
    0010: AND (Bitwise AND)
    0011: OR (Bitwise OR)
    0100: LOAD (Load from memory)
    0101: STORE (Store to memory)
    0110: JUMP (Jump to address)
    
Each instruction is 16 bits wide, divided as follows:
- [15:12] [11:8]  [7:5]  [4:2]   [1:0]
- Opcode  DestReg SrcReg1 SrcReg2 Immediate/Address

Example Instructions
- 0000 011 000 001 0000: ADD R3, R0, R1
- 0001 011 001 010 0000: SUB R3, R1, R2
- 0100 010 000 000 0011: LOAD R2, 3
- 0101 010 000 000 0001: STORE R2, 1
- 0110 000 000 000 1010: JUMP to address 10


## Interacting with the CPU
To interact with the CPU, you need to modify the instruction_memory.v file with your desired instructions. Follow these steps:

1. Open instruction_memory.v.
2. Modify the initial block to add your instructions. Example:
```sh
initial begin
  memory[0] = 16'b0000011000000101;  // ADD R0, R1, R2
  memory[1] = 16'b0001001100100110;  // SUB R1, R3, R6
  memory[2] = 16'b0100010000000011;  // LOAD R2, 3
  memory[3] = 16'b0101010101000001;  // STORE R2, 1
  memory[4] = 16'b0110000000001010;  // JUMP to address 10
  // Add more instructions as needed
end
```
3. Save your changes.
4. Re-run the simulation to see the effects of your instructions.
