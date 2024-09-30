# Graphic application

## Build and Run

sdl-config - bin utility comes together with sdl library. If clone and build manualy add sdl-config to PATH first.

```bash
export PATH=path_to_sdl-config:$PATH
gcc main.c app.c sim.c -o app `sdl-config --libs --cflags
```

## Visual Result

![result](./example/moving_circles.png)

## Generate llvm IR

Output app.ll file with app.cc IR:


```bash
# -S stands for text assembly 
clang -emit-llvm -S app.c -o app.ll
```