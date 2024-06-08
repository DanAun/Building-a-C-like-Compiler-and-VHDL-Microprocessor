# Simple C-like Language Compiler and VHDL Microprocessor

## Project Overview

This project involves the development of a compiler for a simplified C-like language and the creation of a microprocessor in VHDL to execute the machine code generated by the compiler. The project is divided into three main components: lexical analysis, syntax analysis, and the VHDL microprocessor.

This project was completed as part of the Automatas & Languages course and the Hardware Architecture course at INSA Toulouse, which is why some of the projects content is in french.

## Components

### 1. Lexical Analysis

We used Flex (a fast lexical analyzer generator) to design the lexical analyzer. The analyzer identifies specific tokens in the simplified language, including arithmetic operators, keywords (such as 'if' and 'while'), identifiers, and constants. The lexical analyzer outputs messages indicating each detected token, facilitating verification of its functionality for subsequent syntax analysis.

### 2. Syntax Analysis

The syntax analyzer, created using Bison (a parser generator), takes the tokens detected by the lexical analyzer and verifies the source code structure. It produces corresponding assembly code, ensuring the source code adheres to the defined grammar rules and generates correct executable assembly code.

### 3. VHDL Microprocessor

We developed a VHDL program capable of executing the generated assembly code using a pipeline architecture. The interpreter supports basic arithmetic operations like addition, subtraction, multiplication, assignment, and copying, enabling simulation and verification of the generated assembly code's functionality.

## Implementation Details

### Lexical Analysis with Flex

The lexical analyzer is structured to recognize keywords, identifiers, and symbols specific to the pseudo C language. It also manages multi-line and single-line comments using Flex states to ensure correct analysis. Key components include:

- Keywords: 'main', 'if', 'else'
- Identifiers and numbers: Supports various numeric formats including scientific and hexadecimal notation
- Operators: '+', '-', '*', etc.
- Whitespace and error handling: Ignores whitespace and signals errors for unknown expressions

### Syntax Analysis with Bison

The syntax analyzer defines a grammar capable of handling various language constructs, such as function declarations, arithmetic expressions, and control structures like loops and conditions. It also manages variable declarations and function calls using a symbol table to track declared variables and functions and an assembly table to generate corresponding instructions.

### VHDL Microprocessor Design

The microprocessor design follows a RISC architecture with a 5-stage pipeline, including:

- Instruction set: ADD (x"01"), MUL (x"02"), SOU (x"03"), COP (x"05"), AFC (x"06"), LOAD (x"07"), STORE (x"08")
- Memory and register bank: Manages data storage and transfer within the processor
- Arithmetic and Logic Unit (ALU): Executes arithmetic and logical operations
- Instruction memory: Stores the program instructions to be executed

The microprocessor incorporates hazard detection at the second pipeline stage to manage data, control, and structural conflicts, ensuring smooth and accurate instruction execution.

## Results

- **LEX**: Efficiently handles multi-line and single-line comments, recognizes keywords, identifiers, numbers, and operators, and manages whitespace and errors.
- **YACC**: Successfully parses the entire program, handles variable declarations, assignments, conditional instructions, loops, and prints the created tables.
- **VHDL**: Robust and efficient microprocessor with a 5-stage pipeline architecture, tested and verified through the execution of the generated assembly code.

## Repository Structure

The GitHub repository is divided into two main folders:

- `compiler/`: Contains the lexical analyzer and syntax analyzer code.
- `microprocessor/`: Contains the VHDL code for the microprocessor.
