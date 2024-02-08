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
To compile and run the code:

1. Clone the repository to your local machine.
2. Ensure you have GCC installed.
3. Open a terminal and navigate to the directory containing the code files.
4. Run the command `make` to compile the code.
5. Execute the generated binary `part2.out` to perform tests.

## Testing
The `main.c` file contains test functions to verify the correctness of both `formula1` and `formula2`. The tests involve comparing the outputs of the implemented formulas with reference functions (`formula1_test` and `formula2_test`) for a variety of input values. If all tests pass within acceptable error margins, the program prints "test completed successfully."

## Contributors
- Guy Reuveni (ID: 206398596)
- Niv Swisa (ID: 208189126)

## License
This code is provided under the [MIT License](https://opensource.org/licenses/MIT). Feel free to use and modify it according to your needs.
