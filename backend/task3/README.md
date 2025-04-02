# Object Writer

## X52 object simple writer

Registered X52 architechture in llvm backend and generated simple object file for future execution on self-written X52 simulator.

Using my latest llvm fork version, run the command:

```bash
llc main.ll -march X52 --filetype=obj
```

on file main.ll:

```llvm
define dso_local i32 @main() {
    ret i32 12
}
```

got output:

```bash
./../llvm-project/llvm/lib/Target/X52/main.o:   file format elf32-x52
Contents of section .strtab:
 0000 002e7465 7874006d 61696e00 6d61696e  ..text.main.main
 0010 2e6c6c00 2e6e6f74 652e474e 552d7374  .ll..note.GNU-st
 0020 61636b00 2e737472 74616200 2e73796d  ack..strtab..sym
 0030 74616200                             tab.
Contents of section .text:
 0000 00000000 00000000                    ........
Contents of section .symtab:
 0000 00000000 00000000 00000000 00000000  ................
 0010 0c000000 00000000 00000000 0400f1ff  ................
 0020 07000000 00000000 08000000 12000200  ................
 ```
