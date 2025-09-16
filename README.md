# CPU Design Project

A complete 32-bit CPU implementation in Verilog featuring a custom instruction set architecture with ALU operations, memory management, and control unit functionality.

## Overview

This project implements a fully functional CPU capable of executing a custom instruction set. The design includes arithmetic operations, logical operations, memory access, branching, and I/O operations with comprehensive testbench validation.

## Architecture Components

**Arithmetic Logic Unit (ALU)**: Supports 17 operations including arithmetic, logical, shift, rotate, and comparison operations

**Control Unit**: Finite state machine managing instruction fetch, decode, and execute cycles with support for 20+ instruction types

**Datapath**: Complete data routing system with 32-bit bus architecture, register file, and memory interface

**Memory System**: RAM module with instruction and data storage capabilities

**Register File**: 16 general-purpose 32-bit registers plus specialized registers (HI, LO, PC, IR, MAR, MDR)

## Key Features

- 32-bit instruction set architecture
- Multi-cycle instruction execution
- Branch prediction and conditional execution
- Memory-mapped I/O operations
- Booth multiplication algorithm
- Hardware division implementation
- Comprehensive shift and rotate operations
- Complete testbench suite for validation

## Tech Stack

- **Hardware Description**: Verilog HDL
- **Simulation**: Testbench-driven verification
- **Architecture**: Harvard architecture with separate instruction/data paths
- **ALU Operations**: Addition, subtraction, multiplication, division, logical operations, shifts, rotates
