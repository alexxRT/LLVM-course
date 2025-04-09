# intrinsics

## X52 graphic intrinsics

To support graphic instruction in educational architechture, we should implement intrinsics in IR to later write them in ASM and Object files respectively.

Added clang builins for these functions:

- void x52PaintPixel(uint32_t, uint32_t, uint32_t)

- void x52Flush()

Changed opCodes for instruction's set

Run command to test results:

```bash
llc main.ll -march X52 --filetype=asm/obj
```

on file main.ll:

```llvm
define dso_local void @app() {
entry:
    call void @llvm.x52.paintpixel(i32 1, i32 2, i32 3)
    call void @llvm.x52.flush()
    ret void
}

declare void @llvm.x52.paintpixel(i32, i32, i32)
declare void @llvm.x52.flush()
```

got output:

```bash
app:                                    ; @app
; %bb.0:                                ; %entry
	MOVli r2 3
	MOVli r4 2
	MOVli r9 1
	PAINTPIXEL r9 r4 r2
	FLUSH
	BR r0
.Lfunc_end0:
 ```

```bash
./llvm-project/llvm/lib/Target/X52/main.o:      file format elf32-x52
Contents of section .strtab:
 0000 002e7465 78740061 7070006d 61696e2e  ..text.app.main.
 0010 6c6c002e 6e6f7465 2e474e55 2d737461  ll..note.GNU-sta
 0020 636b002e 73747274 6162002e 73796d74  ck..strtab..symt
 0030 616200                               ab.
Contents of section .text:
 0000 030020ab 020040ab 010090ab 020094df  .. ...@.........
 0010 000000bc 000000aa                    ........
Contents of section .symtab:
 0000 00000000 00000000 00000000 00000000  ................
 0010 0b000000 00000000 00000000 0400f1ff  ................
 0020 07000000 00000000 18000000 12000200  ................
```
