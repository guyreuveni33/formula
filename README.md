# README

This repository contains C code implementing two mathematical formulas (`formula1` and `formula2`) along with test functions to verify their correctness. Additionally, it includes assembly code for optimizing `formula2` using SIMD instructions.

## Formula 1:
<img src="https://github.com/guyreuveni33/formula/assets/116805344/81dba5ec-f008-4a51-ad69-b85185753dca" width="400">

## Formula 2:
<img src="https://github.com/guyreuveni33/formula/assets/116805344/d6be455e-9bd3-4e5e-85d4-ed2c2a343df1" width="300">

## Contents
- `formula1.c`: C code implementing `formula1` using SIMD intrinsics.
- `formula2.s`: Assembly code implementing `formula2` optimized with AVX instructions.
- `main.c`: Test harness to verify the correctness of both formulas.
- `formulas.h`: Header file containing function prototypes for `formula1` and `formula2`.
- `Makefile`: Makefile for compiling the code.
- `README.md`: This readme file.

## Instructions

To get started, follow these steps:

1. **Clone the repository**:
   ```sh
   git clone https://github.com/your-username/formulas.git
2. **Navigate to the directory:**:
   ```sh
   cd formulas
3. **Compile the code:**:
   ```sh
   make
4. **Run the tests:**:
  ./part2.out


## Testing
The `main.c` file contains test functions to verify the correctness of both `formula1` and `formula2`. The tests involve comparing the outputs of the implemented formulas with reference functions (`formula1_test` and `formula2_test`) for a variety of input values. If all tests pass within acceptable error margins, the program prints "test completed successfully."

