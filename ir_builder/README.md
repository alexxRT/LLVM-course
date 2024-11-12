# IR Builder

## Description

This `builder.cpp` file generates IR for my graphical application and executes.

## To run

```bash
    clang++ $(llvm-config --cppflags --ldflags --libs) ../SDL/sim.cpp builder.cpp $(sdl2-config --libs --cflags) -o out
```