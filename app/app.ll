; ModuleID = 'app.c'
source_filename = "app.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx14.0.0"

%struct.circle_t = type { i32, i32, i32, i32, i32 }

@SPEED = constant i32 1, align 4
@WIN_WIDTH = external global i32, align 4
@.str = private unnamed_addr constant [44 x i8] c"x coordinate is out of range to paint pixel\00", align 1
@__func__.get_pixel_color = private unnamed_addr constant [16 x i8] c"get_pixel_color\00", align 1
@.str.1 = private unnamed_addr constant [6 x i8] c"app.c\00", align 1
@.str.2 = private unnamed_addr constant [64 x i8] c"x <= WIN_WIDTH && \22x coordinate is out of range to paint pixel\22\00", align 1
@WIN_HIGHT = external global i32, align 4
@.str.3 = private unnamed_addr constant [44 x i8] c"y coordinate is out of range to paint pixel\00", align 1
@.str.4 = private unnamed_addr constant [64 x i8] c"y <= WIN_HIGHT && \22y coordinate is out of range to paint pixel\22\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @get_pixel_color(i32 noundef %0, i32 noundef %1, ptr noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 8
  %8 = alloca i32, align 4
  store i32 %0, ptr %5, align 4
  store i32 %1, ptr %6, align 4
  store ptr %2, ptr %7, align 8
  %9 = load i32, ptr %5, align 4
  %10 = load i32, ptr @WIN_WIDTH, align 4
  %11 = icmp sle i32 %9, %10
  br i1 %11, label %12, label %13

12:                                               ; preds = %3
  br label %13

13:                                               ; preds = %12, %3
  %14 = phi i1 [ false, %3 ], [ true, %12 ]
  %15 = xor i1 %14, true
  %16 = zext i1 %15 to i32
  %17 = sext i32 %16 to i64
  %18 = icmp ne i64 %17, 0
  br i1 %18, label %19, label %21

19:                                               ; preds = %13
  call void @__assert_rtn(ptr noundef @__func__.get_pixel_color, ptr noundef @.str.1, i32 noundef 20, ptr noundef @.str.2) #4
  unreachable

20:                                               ; No predecessors!
  br label %22

21:                                               ; preds = %13
  br label %22

22:                                               ; preds = %21, %20
  %23 = load i32, ptr %6, align 4
  %24 = load i32, ptr @WIN_HIGHT, align 4
  %25 = icmp sle i32 %23, %24
  br i1 %25, label %26, label %27

26:                                               ; preds = %22
  br label %27

27:                                               ; preds = %26, %22
  %28 = phi i1 [ false, %22 ], [ true, %26 ]
  %29 = xor i1 %28, true
  %30 = zext i1 %29 to i32
  %31 = sext i32 %30 to i64
  %32 = icmp ne i64 %31, 0
  br i1 %32, label %33, label %35

33:                                               ; preds = %27
  call void @__assert_rtn(ptr noundef @__func__.get_pixel_color, ptr noundef @.str.1, i32 noundef 21, ptr noundef @.str.4) #4
  unreachable

34:                                               ; No predecessors!
  br label %36

35:                                               ; preds = %27
  br label %36

36:                                               ; preds = %35, %34
  store i32 0, ptr %8, align 4
  br label %37

37:                                               ; preds = %79, %36
  %38 = load i32, ptr %8, align 4
  %39 = icmp slt i32 %38, 8
  br i1 %39, label %40, label %82

40:                                               ; preds = %37
  %41 = load i32, ptr %5, align 4
  %42 = load ptr, ptr %7, align 8
  %43 = load i32, ptr %8, align 4
  %44 = sext i32 %43 to i64
  %45 = getelementptr inbounds %struct.circle_t, ptr %42, i64 %44
  %46 = getelementptr inbounds %struct.circle_t, ptr %45, i32 0, i32 0
  %47 = load i32, ptr %46, align 4
  %48 = sub nsw i32 %41, %47
  %49 = sitofp i32 %48 to double
  %50 = call double @llvm.pow.f64(double %49, double 2.000000e+00)
  %51 = load i32, ptr %6, align 4
  %52 = load ptr, ptr %7, align 8
  %53 = load i32, ptr %8, align 4
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds %struct.circle_t, ptr %52, i64 %54
  %56 = getelementptr inbounds %struct.circle_t, ptr %55, i32 0, i32 1
  %57 = load i32, ptr %56, align 4
  %58 = sub nsw i32 %51, %57
  %59 = sitofp i32 %58 to double
  %60 = call double @llvm.pow.f64(double %59, double 2.000000e+00)
  %61 = fadd double %50, %60
  %62 = load ptr, ptr %7, align 8
  %63 = load i32, ptr %8, align 4
  %64 = sext i32 %63 to i64
  %65 = getelementptr inbounds %struct.circle_t, ptr %62, i64 %64
  %66 = getelementptr inbounds %struct.circle_t, ptr %65, i32 0, i32 3
  %67 = load i32, ptr %66, align 4
  %68 = sitofp i32 %67 to double
  %69 = call double @llvm.pow.f64(double %68, double 2.000000e+00)
  %70 = fcmp ole double %61, %69
  br i1 %70, label %71, label %78

71:                                               ; preds = %40
  %72 = load ptr, ptr %7, align 8
  %73 = load i32, ptr %8, align 4
  %74 = sext i32 %73 to i64
  %75 = getelementptr inbounds %struct.circle_t, ptr %72, i64 %74
  %76 = getelementptr inbounds %struct.circle_t, ptr %75, i32 0, i32 4
  %77 = load i32, ptr %76, align 4
  store i32 %77, ptr %4, align 4
  br label %83

78:                                               ; preds = %40
  br label %79

79:                                               ; preds = %78
  %80 = load i32, ptr %8, align 4
  %81 = add nsw i32 %80, 1
  store i32 %81, ptr %8, align 4
  br label %37, !llvm.loop !6

82:                                               ; preds = %37
  store i32 -741092353, ptr %4, align 4
  br label %83

83:                                               ; preds = %82, %71
  %84 = load i32, ptr %4, align 4
  ret i32 %84
}

; Function Attrs: cold noreturn
declare void @__assert_rtn(ptr noundef, ptr noundef, i32 noundef, ptr noundef) #1

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare double @llvm.pow.f64(double, double) #2

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @update_circles(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i64, align 8
  store ptr %0, ptr %2, align 8
  store i64 0, ptr %3, align 8
  br label %4

4:                                                ; preds = %88, %1
  %5 = load i64, ptr %3, align 8
  %6 = icmp ult i64 %5, 8
  br i1 %6, label %7, label %91

7:                                                ; preds = %4
  %8 = load i32, ptr @WIN_HIGHT, align 4
  %9 = load ptr, ptr %2, align 8
  %10 = load i64, ptr %3, align 8
  %11 = getelementptr inbounds %struct.circle_t, ptr %9, i64 %10
  %12 = getelementptr inbounds %struct.circle_t, ptr %11, i32 0, i32 1
  %13 = load i32, ptr %12, align 4
  %14 = sub nsw i32 %8, %13
  %15 = load ptr, ptr %2, align 8
  %16 = load i64, ptr %3, align 8
  %17 = getelementptr inbounds %struct.circle_t, ptr %15, i64 %16
  %18 = getelementptr inbounds %struct.circle_t, ptr %17, i32 0, i32 3
  %19 = load i32, ptr %18, align 4
  %20 = icmp slt i32 %14, %19
  br i1 %20, label %21, label %43

21:                                               ; preds = %7
  %22 = load ptr, ptr %2, align 8
  %23 = load i64, ptr %3, align 8
  %24 = getelementptr inbounds %struct.circle_t, ptr %22, i64 %23
  %25 = getelementptr inbounds %struct.circle_t, ptr %24, i32 0, i32 2
  %26 = load i32, ptr %25, align 4
  %27 = sub nsw i32 0, %26
  %28 = load ptr, ptr %2, align 8
  %29 = load i64, ptr %3, align 8
  %30 = getelementptr inbounds %struct.circle_t, ptr %28, i64 %29
  %31 = getelementptr inbounds %struct.circle_t, ptr %30, i32 0, i32 2
  store i32 %27, ptr %31, align 4
  %32 = load i32, ptr @WIN_HIGHT, align 4
  %33 = load ptr, ptr %2, align 8
  %34 = load i64, ptr %3, align 8
  %35 = getelementptr inbounds %struct.circle_t, ptr %33, i64 %34
  %36 = getelementptr inbounds %struct.circle_t, ptr %35, i32 0, i32 3
  %37 = load i32, ptr %36, align 4
  %38 = sub nsw i32 %32, %37
  %39 = load ptr, ptr %2, align 8
  %40 = load i64, ptr %3, align 8
  %41 = getelementptr inbounds %struct.circle_t, ptr %39, i64 %40
  %42 = getelementptr inbounds %struct.circle_t, ptr %41, i32 0, i32 1
  store i32 %38, ptr %42, align 4
  br label %76

43:                                               ; preds = %7
  %44 = load ptr, ptr %2, align 8
  %45 = load i64, ptr %3, align 8
  %46 = getelementptr inbounds %struct.circle_t, ptr %44, i64 %45
  %47 = getelementptr inbounds %struct.circle_t, ptr %46, i32 0, i32 1
  %48 = load i32, ptr %47, align 4
  %49 = load ptr, ptr %2, align 8
  %50 = load i64, ptr %3, align 8
  %51 = getelementptr inbounds %struct.circle_t, ptr %49, i64 %50
  %52 = getelementptr inbounds %struct.circle_t, ptr %51, i32 0, i32 3
  %53 = load i32, ptr %52, align 4
  %54 = icmp slt i32 %48, %53
  br i1 %54, label %55, label %75

55:                                               ; preds = %43
  %56 = load ptr, ptr %2, align 8
  %57 = load i64, ptr %3, align 8
  %58 = getelementptr inbounds %struct.circle_t, ptr %56, i64 %57
  %59 = getelementptr inbounds %struct.circle_t, ptr %58, i32 0, i32 2
  %60 = load i32, ptr %59, align 4
  %61 = sub nsw i32 0, %60
  %62 = load ptr, ptr %2, align 8
  %63 = load i64, ptr %3, align 8
  %64 = getelementptr inbounds %struct.circle_t, ptr %62, i64 %63
  %65 = getelementptr inbounds %struct.circle_t, ptr %64, i32 0, i32 2
  store i32 %61, ptr %65, align 4
  %66 = load ptr, ptr %2, align 8
  %67 = load i64, ptr %3, align 8
  %68 = getelementptr inbounds %struct.circle_t, ptr %66, i64 %67
  %69 = getelementptr inbounds %struct.circle_t, ptr %68, i32 0, i32 3
  %70 = load i32, ptr %69, align 4
  %71 = load ptr, ptr %2, align 8
  %72 = load i64, ptr %3, align 8
  %73 = getelementptr inbounds %struct.circle_t, ptr %71, i64 %72
  %74 = getelementptr inbounds %struct.circle_t, ptr %73, i32 0, i32 1
  store i32 %70, ptr %74, align 4
  br label %75

75:                                               ; preds = %55, %43
  br label %76

76:                                               ; preds = %75, %21
  %77 = load ptr, ptr %2, align 8
  %78 = load i64, ptr %3, align 8
  %79 = getelementptr inbounds %struct.circle_t, ptr %77, i64 %78
  %80 = getelementptr inbounds %struct.circle_t, ptr %79, i32 0, i32 2
  %81 = load i32, ptr %80, align 4
  %82 = load ptr, ptr %2, align 8
  %83 = load i64, ptr %3, align 8
  %84 = getelementptr inbounds %struct.circle_t, ptr %82, i64 %83
  %85 = getelementptr inbounds %struct.circle_t, ptr %84, i32 0, i32 1
  %86 = load i32, ptr %85, align 4
  %87 = add nsw i32 %86, %81
  store i32 %87, ptr %85, align 4
  br label %88

88:                                               ; preds = %76
  %89 = load i64, ptr %3, align 8
  %90 = add i64 %89, 1
  store i64 %90, ptr %3, align 8
  br label %4, !llvm.loop !8

91:                                               ; preds = %4
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
  %9 = load i32, ptr @WIN_WIDTH, align 4
  %10 = sdiv i32 %9, 16
  store i32 %10, ptr %2, align 4
  store i32 -16777216, ptr %3, align 4
  store i32 3, ptr %4, align 4
  store i32 0, ptr %5, align 4
  br label %11

11:                                               ; preds = %61, %0
  %12 = load i32, ptr %5, align 4
  %13 = icmp ult i32 %12, 8
  br i1 %13, label %14, label %64

14:                                               ; preds = %11
  %15 = load i32, ptr %2, align 4
  %16 = load i32, ptr %5, align 4
  %17 = load i32, ptr %2, align 4
  %18 = mul i32 %16, %17
  %19 = udiv i32 %18, 8
  %20 = sub i32 %15, %19
  %21 = load i32, ptr %5, align 4
  %22 = zext i32 %21 to i64
  %23 = getelementptr inbounds [8 x %struct.circle_t], ptr %1, i64 0, i64 %22
  %24 = getelementptr inbounds %struct.circle_t, ptr %23, i32 0, i32 3
  store i32 %20, ptr %24, align 4
  %25 = load i32, ptr %5, align 4
  %26 = mul i32 2, %25
  %27 = load i32, ptr %2, align 4
  %28 = mul i32 %26, %27
  %29 = load i32, ptr %5, align 4
  %30 = zext i32 %29 to i64
  %31 = getelementptr inbounds [8 x %struct.circle_t], ptr %1, i64 0, i64 %30
  %32 = getelementptr inbounds %struct.circle_t, ptr %31, i32 0, i32 3
  %33 = load i32, ptr %32, align 4
  %34 = add i32 %28, %33
  %35 = load i32, ptr %5, align 4
  %36 = zext i32 %35 to i64
  %37 = getelementptr inbounds [8 x %struct.circle_t], ptr %1, i64 0, i64 %36
  %38 = getelementptr inbounds %struct.circle_t, ptr %37, i32 0, i32 0
  store i32 %34, ptr %38, align 4
  %39 = load i32, ptr @WIN_HIGHT, align 4
  %40 = sdiv i32 %39, 2
  %41 = load i32, ptr %5, align 4
  %42 = zext i32 %41 to i64
  %43 = getelementptr inbounds [8 x %struct.circle_t], ptr %1, i64 0, i64 %42
  %44 = getelementptr inbounds %struct.circle_t, ptr %43, i32 0, i32 1
  store i32 %40, ptr %44, align 4
  %45 = load i32, ptr %5, align 4
  %46 = add i32 1, %45
  %47 = mul i32 1, %46
  %48 = load i32, ptr %5, align 4
  %49 = zext i32 %48 to i64
  %50 = getelementptr inbounds [8 x %struct.circle_t], ptr %1, i64 0, i64 %49
  %51 = getelementptr inbounds %struct.circle_t, ptr %50, i32 0, i32 2
  store i32 %47, ptr %51, align 4
  %52 = load i32, ptr %3, align 4
  %53 = load i32, ptr %4, align 4
  %54 = load i32, ptr %5, align 4
  %55 = mul i32 %53, %54
  %56 = lshr i32 %52, %55
  %57 = load i32, ptr %5, align 4
  %58 = zext i32 %57 to i64
  %59 = getelementptr inbounds [8 x %struct.circle_t], ptr %1, i64 0, i64 %58
  %60 = getelementptr inbounds %struct.circle_t, ptr %59, i32 0, i32 4
  store i32 %56, ptr %60, align 4
  br label %61

61:                                               ; preds = %14
  %62 = load i32, ptr %5, align 4
  %63 = add i32 %62, 1
  store i32 %63, ptr %5, align 4
  br label %11, !llvm.loop !9

64:                                               ; preds = %11
  br label %65

65:                                               ; preds = %64, %90
  store i32 0, ptr %6, align 4
  br label %66

66:                                               ; preds = %87, %65
  %67 = load i32, ptr %6, align 4
  %68 = load i32, ptr @WIN_HIGHT, align 4
  %69 = icmp slt i32 %67, %68
  br i1 %69, label %70, label %90

70:                                               ; preds = %66
  store i32 0, ptr %7, align 4
  br label %71

71:                                               ; preds = %83, %70
  %72 = load i32, ptr %7, align 4
  %73 = load i32, ptr @WIN_WIDTH, align 4
  %74 = icmp slt i32 %72, %73
  br i1 %74, label %75, label %86

75:                                               ; preds = %71
  %76 = load i32, ptr %7, align 4
  %77 = load i32, ptr %6, align 4
  %78 = getelementptr inbounds [8 x %struct.circle_t], ptr %1, i64 0, i64 0
  %79 = call i32 @get_pixel_color(i32 noundef %76, i32 noundef %77, ptr noundef %78)
  store i32 %79, ptr %8, align 4
  %80 = load i32, ptr %7, align 4
  %81 = load i32, ptr %6, align 4
  %82 = load i32, ptr %8, align 4
  call void @paint_pixel(i32 noundef %80, i32 noundef %81, i32 noundef %82)
  br label %83

83:                                               ; preds = %75
  %84 = load i32, ptr %7, align 4
  %85 = add nsw i32 %84, 1
  store i32 %85, ptr %7, align 4
  br label %71, !llvm.loop !10

86:                                               ; preds = %71
  br label %87

87:                                               ; preds = %86
  %88 = load i32, ptr %6, align 4
  %89 = add nsw i32 %88, 1
  store i32 %89, ptr %6, align 4
  br label %66, !llvm.loop !11

90:                                               ; preds = %66
  call void @flush_window()
  %91 = getelementptr inbounds [8 x %struct.circle_t], ptr %1, i64 0, i64 0
  call void @update_circles(ptr noundef %91)
  br label %65
}

declare void @paint_pixel(i32 noundef, i32 noundef, i32 noundef) #3

declare void @flush_window(...) #3

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #1 = { cold noreturn "disable-tail-calls"="true" "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #2 = { nocallback nofree nosync nounwind readnone speculatable willreturn }
attributes #3 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+sm4,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #4 = { cold noreturn }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 14, i32 4]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Apple clang version 15.0.0 (clang-1500.3.9.4)"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7}
!11 = distinct !{!11, !7}
