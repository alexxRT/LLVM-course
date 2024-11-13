#[LLVM IR]:
; ModuleID = 'top'
source_filename = "top"

@REG = external global [8 x i32]
@COLORS = external global [2 x i32]
@SPEED = external global i32
@CENTER_X = external global i32

define void @main() {
"0":
  call void @MOV(i32 1, i32 125)
  call void @MOV(i32 2, i32 50)
  br label %"1"

"1":                                              ; preds = %"88", %"0"
  call void @MOV(i32 3, i32 0)
  call void @MOV(i32 4, i32 0)
  br label %"7"

"7":                                              ; preds = %"3", %"11", %"1"
  call void @SQUARE_ABS(i32 4, i32 3, i32 1, i32 6)
  call void @BLE(i32 2, i32 6, i32 0)
  call void @SET_COLOR(i32 6, i32 1)
  %0 = load i32, ptr @REG, align 4
  %1 = trunc i32 %0 to i1
  br i1 %1, label %"11", label %"8"

"8":                                              ; preds = %"7"
  call void @SET_COLOR(i32 6, i32 0)
  br label %"11"

"11":                                             ; preds = %"8", %"7"
  call void @PAINT_PIXEL(i32 4, i32 3, i32 6)
  call void @INC_LT(i32 4, i32 500, i32 0)
  %2 = load i32, ptr @REG, align 4
  %3 = trunc i32 %2 to i1
  br i1 %3, label %"7", label %"3"

"3":                                              ; preds = %"11"
  call void @MOV(i32 4, i32 0)
  call void @INC_LT(i32 3, i32 250, i32 0)
  %4 = load i32, ptr @REG, align 4
  %5 = trunc i32 %4 to i1
  br i1 %5, label %"7", label %"4"

"4":                                              ; preds = %"3"
  call void @MOV(i32 3, i32 0)
  call void @FLUSH()
  call void @MOVE(i32 1)
  call void @DIV(i32 2, i32 2, i32 6)
  call void @ADD(i32 6, i32 250, i32 6)
  call void @BLE(i32 1, i32 6, i32 0)
  %6 = load i32, ptr @REG, align 4
  %7 = trunc i32 %6 to i1
  br i1 %7, label %"88", label %"9"

"9":                                              ; preds = %"4"
  call void @DIV(i32 2, i32 -2, i32 1)
  br label %"88"

"88":                                             ; preds = %"9", %"4"
  call void @INC_LT(i32 5, i32 1000, i32 0)
  %8 = load i32, ptr @REG, align 4
  %9 = trunc i32 %8 to i1
  br i1 %9, label %"1", label %"77"

"77":                                             ; preds = %"88"
  ret void
}

declare void @SQUARE_ABS(i32, i32, i32, i32)

declare void @ADD(i32, i32, i32)

declare void @DIV(i32, i32, i32)

declare void @BLE(i32, i32, i32)

declare void @PAINT_PIXEL(i32, i32, i32)

declare void @INC_LT(i32, i32, i32)

declare void @MOV(i32, i32)

declare void @SET_COLOR(i32, i32)

declare void @MOVE(i32)

declare void @FLUSH()
