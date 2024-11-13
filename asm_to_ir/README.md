# Asm to IR generator

## Custom instructions based on collected trace

1. `MOVE` x1 - moves square SPEED pixels down
2. `SET_COLOR` x1 code - sets color to paint pixel from `COLORS_SET[]`
3. `SQUARE_ABS` x1 x2 x3 x4 - evaluates square's equation
4. `INC_LT` x1 x2 x3 - increments x1 and x3 = x1 < x2

## Build and run

```bash
clang++ -std=c++20 instr_to_ir.cpp $(llvm-config --libs --cflags --ldflags) ../app/sim.cpp $($SDL --libs --cflags) -o out
./out asm.s 
```