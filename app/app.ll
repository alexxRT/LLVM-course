; ModuleID = 'app.c'
source_filename = "app.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx14.0.0"

%struct.circle_t = type { i32, i32, i32, i32, i32 }

@SPEED = constant i32 1, align 4
@.str = private unnamed_addr constant [44 x i8] c"x coordinate is out of range to paint pixel\00", align 1
@__func__.get_pixel_color = private unnamed_addr constant [16 x i8] c"get_pixel_color\00", align 1
@.str.1 = private unnamed_addr constant [6 x i8] c"app.c\00", align 1
@.str.2 = private unnamed_addr constant [64 x i8] c"x <= WIN_WIDTH && \22x coordinate is out of range to paint pixel\22\00", align 1
@.str.3 = private unnamed_addr constant [44 x i8] c"y coordinate is out of range to paint pixel\00", align 1
@.str.4 = private unnamed_addr constant [64 x i8] c"y <= WIN_HIGHT && \22y coordinate is out of range to paint pixel\22\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @get_pixel_color(i32 noundef %0, i32 noundef %1, ptr noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  store i32 %0, ptr %5, align 4
  store i32 %1, ptr %6, align 4
  store ptr %2, ptr %7, align 8
  %12 = load i32, ptr %5, align 4
  %13 = icmp sle i32 %12, 500
  br i1 %13, label %14, label %15

14:                                               ; preds = %3
  br label %15

15:                                               ; preds = %14, %3
  %16 = phi i1 [ false, %3 ], [ true, %14 ]
  %17 = xor i1 %16, true
  %18 = zext i1 %17 to i32
  %19 = sext i32 %18 to i64
  %20 = icmp ne i64 %19, 0
  br i1 %20, label %21, label %23

21:                                               ; preds = %15
  call void @__assert_rtn(ptr noundef @__func__.get_pixel_color, ptr noundef @.str.1, i32 noundef 17, ptr noundef @.str.2) #3
  unreachable

22:                                               ; No predecessors!
  br label %24

23:                                               ; preds = %15
  br label %24

24:                                               ; preds = %23, %22
  %25 = load i32, ptr %6, align 4
  %26 = icmp sle i32 %25, 250
  br i1 %26, label %27, label %28

27:                                               ; preds = %24
  br label %28

28:                                               ; preds = %27, %24
  %29 = phi i1 [ false, %24 ], [ true, %27 ]
  %30 = xor i1 %29, true
  %31 = zext i1 %30 to i32
  %32 = sext i32 %31 to i64
  %33 = icmp ne i64 %32, 0
  br i1 %33, label %34, label %36

34:                                               ; preds = %28
  call void @__assert_rtn(ptr noundef @__func__.get_pixel_color, ptr noundef @.str.1, i32 noundef 18, ptr noundef @.str.4) #3
  unreachable

35:                                               ; No predecessors!
  br label %37

36:                                               ; preds = %28
  br label %37

37:                                               ; preds = %36, %35
  store i32 0, ptr %8, align 4
  br label %38

38:                                               ; preds = %102, %37
  %39 = load i32, ptr %8, align 4
  %40 = icmp slt i32 %39, 8
  br i1 %40, label %41, label %105

41:                                               ; preds = %38
  %42 = load i32, ptr %5, align 4
  %43 = load ptr, ptr %7, align 8
  %44 = load i32, ptr %8, align 4
  %45 = sext i32 %44 to i64
  %46 = getelementptr inbounds %struct.circle_t, ptr %43, i64 %45
  %47 = getelementptr inbounds %struct.circle_t, ptr %46, i32 0, i32 0
  %48 = load i32, ptr %47, align 4
  %49 = sub nsw i32 %42, %48
  %50 = load i32, ptr %5, align 4
  %51 = load ptr, ptr %7, align 8
  %52 = load i32, ptr %8, align 4
  %53 = sext i32 %52 to i64
  %54 = getelementptr inbounds %struct.circle_t, ptr %51, i64 %53
  %55 = getelementptr inbounds %struct.circle_t, ptr %54, i32 0, i32 0
  %56 = load i32, ptr %55, align 4
  %57 = sub nsw i32 %50, %56
  %58 = mul nsw i32 %49, %57
  store i32 %58, ptr %9, align 4
  %59 = load i32, ptr %6, align 4
  %60 = load ptr, ptr %7, align 8
  %61 = load i32, ptr %8, align 4
  %62 = sext i32 %61 to i64
  %63 = getelementptr inbounds %struct.circle_t, ptr %60, i64 %62
  %64 = getelementptr inbounds %struct.circle_t, ptr %63, i32 0, i32 1
  %65 = load i32, ptr %64, align 4
  %66 = sub nsw i32 %59, %65
  %67 = load i32, ptr %6, align 4
  %68 = load ptr, ptr %7, align 8
  %69 = load i32, ptr %8, align 4
  %70 = sext i32 %69 to i64
  %71 = getelementptr inbounds %struct.circle_t, ptr %68, i64 %70
  %72 = getelementptr inbounds %struct.circle_t, ptr %71, i32 0, i32 1
  %73 = load i32, ptr %72, align 4
  %74 = sub nsw i32 %67, %73
  %75 = mul nsw i32 %66, %74
  store i32 %75, ptr %10, align 4
  %76 = load ptr, ptr %7, align 8
  %77 = load i32, ptr %8, align 4
  %78 = sext i32 %77 to i64
  %79 = getelementptr inbounds %struct.circle_t, ptr %76, i64 %78
  %80 = getelementptr inbounds %struct.circle_t, ptr %79, i32 0, i32 3
  %81 = load i32, ptr %80, align 4
  %82 = load ptr, ptr %7, align 8
  %83 = load i32, ptr %8, align 4
  %84 = sext i32 %83 to i64
  %85 = getelementptr inbounds %struct.circle_t, ptr %82, i64 %84
  %86 = getelementptr inbounds %struct.circle_t, ptr %85, i32 0, i32 3
  %87 = load i32, ptr %86, align 4
  %88 = mul nsw i32 %81, %87
  store i32 %88, ptr %11, align 4
  %89 = load i32, ptr %9, align 4
  %90 = load i32, ptr %10, align 4
  %91 = add nsw i32 %89, %90
  %92 = load i32, ptr %11, align 4
  %93 = icmp sle i32 %91, %92
  br i1 %93, label %94, label %101

94:                                               ; preds = %41
  %95 = load ptr, ptr %7, align 8
  %96 = load i32, ptr %8, align 4
  %97 = sext i32 %96 to i64
  %98 = getelementptr inbounds %struct.circle_t, ptr %95, i64 %97
  %99 = getelementptr inbounds %struct.circle_t, ptr %98, i32 0, i32 4
  %100 = load i32, ptr %99, align 4
  store i32 %100, ptr %4, align 4
  br label %106

101:                                              ; preds = %41
  br label %102

102:                                              ; preds = %101
  %103 = load i32, ptr %8, align 4
  %104 = add nsw i32 %103, 1
  store i32 %104, ptr %8, align 4
  br label %38, !llvm.loop !6

105:                                              ; preds = %38
  store i32 -741092353, ptr %4, align 4
  br label %106

106:                                              ; preds = %105, %94
  %107 = load i32, ptr %4, align 4
  ret i32 %107
}

; Function Attrs: cold noreturn
declare void @__assert_rtn(ptr noundef, ptr noundef, i32 noundef, ptr noundef) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @update_circles(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i64, align 8
  store ptr %0, ptr %2, align 8
  store i64 0, ptr %3, align 8
  br label %4

4:                                                ; preds = %86, %1
  %5 = load i64, ptr %3, align 8
  %6 = icmp ult i64 %5, 8
  br i1 %6, label %7, label %89

7:                                                ; preds = %4
  %8 = load ptr, ptr %2, align 8
  %9 = load i64, ptr %3, align 8
  %10 = getelementptr inbounds %struct.circle_t, ptr %8, i64 %9
  %11 = getelementptr inbounds %struct.circle_t, ptr %10, i32 0, i32 1
  %12 = load i32, ptr %11, align 4
  %13 = sub nsw i32 250, %12
  %14 = load ptr, ptr %2, align 8
  %15 = load i64, ptr %3, align 8
  %16 = getelementptr inbounds %struct.circle_t, ptr %14, i64 %15
  %17 = getelementptr inbounds %struct.circle_t, ptr %16, i32 0, i32 3
  %18 = load i32, ptr %17, align 4
  %19 = icmp slt i32 %13, %18
  br i1 %19, label %20, label %41

20:                                               ; preds = %7
  %21 = load ptr, ptr %2, align 8
  %22 = load i64, ptr %3, align 8
  %23 = getelementptr inbounds %struct.circle_t, ptr %21, i64 %22
  %24 = getelementptr inbounds %struct.circle_t, ptr %23, i32 0, i32 2
  %25 = load i32, ptr %24, align 4
  %26 = sub nsw i32 0, %25
  %27 = load ptr, ptr %2, align 8
  %28 = load i64, ptr %3, align 8
  %29 = getelementptr inbounds %struct.circle_t, ptr %27, i64 %28
  %30 = getelementptr inbounds %struct.circle_t, ptr %29, i32 0, i32 2
  store i32 %26, ptr %30, align 4
  %31 = load ptr, ptr %2, align 8
  %32 = load i64, ptr %3, align 8
  %33 = getelementptr inbounds %struct.circle_t, ptr %31, i64 %32
  %34 = getelementptr inbounds %struct.circle_t, ptr %33, i32 0, i32 3
  %35 = load i32, ptr %34, align 4
  %36 = sub nsw i32 250, %35
  %37 = load ptr, ptr %2, align 8
  %38 = load i64, ptr %3, align 8
  %39 = getelementptr inbounds %struct.circle_t, ptr %37, i64 %38
  %40 = getelementptr inbounds %struct.circle_t, ptr %39, i32 0, i32 1
  store i32 %36, ptr %40, align 4
  br label %74

41:                                               ; preds = %7
  %42 = load ptr, ptr %2, align 8
  %43 = load i64, ptr %3, align 8
  %44 = getelementptr inbounds %struct.circle_t, ptr %42, i64 %43
  %45 = getelementptr inbounds %struct.circle_t, ptr %44, i32 0, i32 1
  %46 = load i32, ptr %45, align 4
  %47 = load ptr, ptr %2, align 8
  %48 = load i64, ptr %3, align 8
  %49 = getelementptr inbounds %struct.circle_t, ptr %47, i64 %48
  %50 = getelementptr inbounds %struct.circle_t, ptr %49, i32 0, i32 3
  %51 = load i32, ptr %50, align 4
  %52 = icmp slt i32 %46, %51
  br i1 %52, label %53, label %73

53:                                               ; preds = %41
  %54 = load ptr, ptr %2, align 8
  %55 = load i64, ptr %3, align 8
  %56 = getelementptr inbounds %struct.circle_t, ptr %54, i64 %55
  %57 = getelementptr inbounds %struct.circle_t, ptr %56, i32 0, i32 2
  %58 = load i32, ptr %57, align 4
  %59 = sub nsw i32 0, %58
  %60 = load ptr, ptr %2, align 8
  %61 = load i64, ptr %3, align 8
  %62 = getelementptr inbounds %struct.circle_t, ptr %60, i64 %61
  %63 = getelementptr inbounds %struct.circle_t, ptr %62, i32 0, i32 2
  store i32 %59, ptr %63, align 4
  %64 = load ptr, ptr %2, align 8
  %65 = load i64, ptr %3, align 8
  %66 = getelementptr inbounds %struct.circle_t, ptr %64, i64 %65
  %67 = getelementptr inbounds %struct.circle_t, ptr %66, i32 0, i32 3
  %68 = load i32, ptr %67, align 4
  %69 = load ptr, ptr %2, align 8
  %70 = load i64, ptr %3, align 8
  %71 = getelementptr inbounds %struct.circle_t, ptr %69, i64 %70
  %72 = getelementptr inbounds %struct.circle_t, ptr %71, i32 0, i32 1
  store i32 %68, ptr %72, align 4
  br label %73

73:                                               ; preds = %53, %41
  br label %74

74:                                               ; preds = %73, %20
  %75 = load ptr, ptr %2, align 8
  %76 = load i64, ptr %3, align 8
  %77 = getelementptr inbounds %struct.circle_t, ptr %75, i64 %76
  %78 = getelementptr inbounds %struct.circle_t, ptr %77, i32 0, i32 2
  %79 = load i32, ptr %78, align 4
  %80 = load ptr, ptr %2, align 8
  %81 = load i64, ptr %3, align 8
  %82 = getelementptr inbounds %struct.circle_t, ptr %80, i64 %81
  %83 = getelementptr inbounds %struct.circle_t, ptr %82, i32 0, i32 1
  %84 = load i32, ptr %83, align 4
  %85 = add nsw i32 %84, %79
  store i32 %85, ptr %83, align 4
  br label %86

86:                                               ; preds = %74
  %87 = load i64, ptr %3, align 8
  %88 = add i64 %87, 1
  store i64 %88, ptr %3, align 8
  br label %4, !llvm.loop !8

89:                                               ; preds = %4
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @app() #0 {
  %1 = alloca [8 x %struct.circle_t], align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store i32 31, ptr %2, align 4
  store i32 -16777216, ptr %3, align 4
  store i32 3, ptr %4, align 4
  store i32 0, ptr %5, align 4
  br label %9

9:                                                ; preds = %57, %0
  %10 = load i32, ptr %5, align 4
  %11 = icmp ult i32 %10, 8
  br i1 %11, label %12, label %60

12:                                               ; preds = %9
  %13 = load i32, ptr %2, align 4
  %14 = load i32, ptr %5, align 4
  %15 = load i32, ptr %2, align 4
  %16 = mul i32 %14, %15
  %17 = udiv i32 %16, 8
  %18 = sub i32 %13, %17
  %19 = load i32, ptr %5, align 4
  %20 = zext i32 %19 to i64
  %21 = getelementptr inbounds [8 x %struct.circle_t], ptr %1, i64 0, i64 %20
  %22 = getelementptr inbounds %struct.circle_t, ptr %21, i32 0, i32 3
  store i32 %18, ptr %22, align 4
  %23 = load i32, ptr %5, align 4
  %24 = mul i32 2, %23
  %25 = load i32, ptr %2, align 4
  %26 = mul i32 %24, %25
  %27 = load i32, ptr %5, align 4
  %28 = zext i32 %27 to i64
  %29 = getelementptr inbounds [8 x %struct.circle_t], ptr %1, i64 0, i64 %28
  %30 = getelementptr inbounds %struct.circle_t, ptr %29, i32 0, i32 3
  %31 = load i32, ptr %30, align 4
  %32 = add i32 %26, %31
  %33 = load i32, ptr %5, align 4
  %34 = zext i32 %33 to i64
  %35 = getelementptr inbounds [8 x %struct.circle_t], ptr %1, i64 0, i64 %34
  %36 = getelementptr inbounds %struct.circle_t, ptr %35, i32 0, i32 0
  store i32 %32, ptr %36, align 4
  %37 = load i32, ptr %5, align 4
  %38 = zext i32 %37 to i64
  %39 = getelementptr inbounds [8 x %struct.circle_t], ptr %1, i64 0, i64 %38
  %40 = getelementptr inbounds %struct.circle_t, ptr %39, i32 0, i32 1
  store i32 125, ptr %40, align 4
  %41 = load i32, ptr %5, align 4
  %42 = add i32 1, %41
  %43 = mul i32 1, %42
  %44 = load i32, ptr %5, align 4
  %45 = zext i32 %44 to i64
  %46 = getelementptr inbounds [8 x %struct.circle_t], ptr %1, i64 0, i64 %45
  %47 = getelementptr inbounds %struct.circle_t, ptr %46, i32 0, i32 2
  store i32 %43, ptr %47, align 4
  %48 = load i32, ptr %3, align 4
  %49 = load i32, ptr %4, align 4
  %50 = load i32, ptr %5, align 4
  %51 = mul i32 %49, %50
  %52 = lshr i32 %48, %51
  %53 = load i32, ptr %5, align 4
  %54 = zext i32 %53 to i64
  %55 = getelementptr inbounds [8 x %struct.circle_t], ptr %1, i64 0, i64 %54
  %56 = getelementptr inbounds %struct.circle_t, ptr %55, i32 0, i32 4
  store i32 %52, ptr %56, align 4
  br label %57

57:                                               ; preds = %12
  %58 = load i32, ptr %5, align 4
  %59 = add i32 %58, 1
  store i32 %59, ptr %5, align 4
  br label %9, !llvm.loop !9

60:                                               ; preds = %9
  br label %61

61:                                               ; preds = %60, %84
  store i32 0, ptr %6, align 4
  br label %62

62:                                               ; preds = %81, %61
  %63 = load i32, ptr %6, align 4
  %64 = icmp slt i32 %63, 250
  br i1 %64, label %65, label %84

65:                                               ; preds = %62
  store i32 0, ptr %7, align 4
  br label %66

66:                                               ; preds = %77, %65
  %67 = load i32, ptr %7, align 4
  %68 = icmp slt i32 %67, 500
  br i1 %68, label %69, label %80

69:                                               ; preds = %66
  %70 = load i32, ptr %7, align 4
  %71 = load i32, ptr %6, align 4
  %72 = getelementptr inbounds [8 x %struct.circle_t], ptr %1, i64 0, i64 0
  %73 = call i32 @get_pixel_color(i32 noundef %70, i32 noundef %71, ptr noundef %72)
  store i32 %73, ptr %8, align 4
  %74 = load i32, ptr %7, align 4
  %75 = load i32, ptr %6, align 4
  %76 = load i32, ptr %8, align 4
  call void @paint_pixel(i32 noundef %74, i32 noundef %75, i32 noundef %76)
  br label %77

77:                                               ; preds = %69
  %78 = load i32, ptr %7, align 4
  %79 = add nsw i32 %78, 1
  store i32 %79, ptr %7, align 4
  br label %66, !llvm.loop !10

80:                                               ; preds = %66
  br label %81

81:                                               ; preds = %80
  %82 = load i32, ptr %6, align 4
  %83 = add nsw i32 %82, 1
  store i32 %83, ptr %6, align 4
  br label %62, !llvm.loop !11

84:                                               ; preds = %62
  call void @flush_window()
  %85 = getelementptr inbounds [8 x %struct.circle_t], ptr %1, i64 0, i64 0
  call void @update_circles(ptr noundef %85)
  br label %61
}

declare void @paint_pixel(i32 noundef, i32 noundef, i32 noundef) #2

declare void @flush_window(...) #2

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #1 = { cold noreturn "disable-tail-calls"="true" "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #2 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #3 = { cold noreturn }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 14, i32 4]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Homebrew clang version 19.1.1"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7}
!11 = distinct !{!11, !7}
