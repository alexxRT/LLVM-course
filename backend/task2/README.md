# Backend IR to ASM


## Registering target X52

After nights of commiting, finally made able to print simple custome assembler from IR input.
Using my forked llvm and building llc only, run command:

```bash
llc main.ll -march X52
```

with main.ll

```llvm
define dso_local i32 @main() {
    ret i32 12
}
```

got the output:

```asm
main:                                   ; @main
; %bb.0:
	MOVli r9 12
	BR r0
.Lfunc_end0:
```