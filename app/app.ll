; ModuleID = 'app.c'
source_filename = "app.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx14.0.0"

%struct.square_t = type { i32, i32 }

@SPEED = constant i32 1, align 4
@COLOR = constant i32 -16777216, align 4
@CENTER_X = constant i32 250, align 4

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @get_pixel_color(i32 noundef %0, i32 noundef %1, i64 %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca %struct.square_t, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store i64 %2, ptr %5, align 4
  store i32 %0, ptr %6, align 4
  store i32 %1, ptr %7, align 4
  %8 = load i32, ptr %6, align 4
  %9 = sub nsw i32 %8, 250
  %10 = load i32, ptr %7, align 4
  %11 = getelementptr inbounds %struct.square_t, ptr %5, i32 0, i32 0
  %12 = load i32, ptr %11, align 4
  %13 = sub nsw i32 %10, %12
  %14 = add nsw i32 %9, %13
  %15 = call i32 @llvm.abs.i32(i32 %14, i1 true)
  %16 = load i32, ptr %6, align 4
  %17 = sub nsw i32 %16, 250
  %18 = load i32, ptr %7, align 4
  %19 = getelementptr inbounds %struct.square_t, ptr %5, i32 0, i32 0
  %20 = load i32, ptr %19, align 4
  %21 = sub nsw i32 %18, %20
  %22 = sub nsw i32 %17, %21
  %23 = call i32 @llvm.abs.i32(i32 %22, i1 true)
  %24 = add nsw i32 %15, %23
  %25 = getelementptr inbounds %struct.square_t, ptr %5, i32 0, i32 1
  %26 = load i32, ptr %25, align 4
  %27 = icmp sle i32 %24, %26
  br i1 %27, label %28, label %29

28:                                               ; preds = %3
  store i32 -16777216, ptr %4, align 4
  br label %30

29:                                               ; preds = %3
  store i32 -741092353, ptr %4, align 4
  br label %30

30:                                               ; preds = %29, %28
  %31 = load i32, ptr %4, align 4
  ret i32 %31
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.abs.i32(i32, i1 immarg) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @app() #0 {
  %1 = alloca %struct.square_t, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  call void @llvm.memset.p0.i64(ptr align 4 %1, i8 0, i64 8, i1 false)
  %5 = getelementptr inbounds %struct.square_t, ptr %1, i32 0, i32 0
  store i32 125, ptr %5, align 4
  %6 = getelementptr inbounds %struct.square_t, ptr %1, i32 0, i32 1
  store i32 50, ptr %6, align 4
  br label %7

7:                                                ; preds = %0, %43
  store i32 0, ptr %2, align 4
  br label %8

8:                                                ; preds = %27, %7
  %9 = load i32, ptr %2, align 4
  %10 = icmp slt i32 %9, 250
  br i1 %10, label %11, label %30

11:                                               ; preds = %8
  store i32 0, ptr %3, align 4
  br label %12

12:                                               ; preds = %23, %11
  %13 = load i32, ptr %3, align 4
  %14 = icmp slt i32 %13, 500
  br i1 %14, label %15, label %26

15:                                               ; preds = %12
  %16 = load i32, ptr %3, align 4
  %17 = load i32, ptr %2, align 4
  %18 = load i64, ptr %1, align 4
  %19 = call i32 @get_pixel_color(i32 noundef %16, i32 noundef %17, i64 %18)
  store i32 %19, ptr %4, align 4
  %20 = load i32, ptr %3, align 4
  %21 = load i32, ptr %2, align 4
  %22 = load i32, ptr %4, align 4
  call void @paint_pixel(i32 noundef %20, i32 noundef %21, i32 noundef %22)
  br label %23

23:                                               ; preds = %15
  %24 = load i32, ptr %3, align 4
  %25 = add nsw i32 %24, 1
  store i32 %25, ptr %3, align 4
  br label %12, !llvm.loop !6

26:                                               ; preds = %12
  br label %27

27:                                               ; preds = %26
  %28 = load i32, ptr %2, align 4
  %29 = add nsw i32 %28, 1
  store i32 %29, ptr %2, align 4
  br label %8, !llvm.loop !8

30:                                               ; preds = %8
  call void @flush_window()
  %31 = getelementptr inbounds %struct.square_t, ptr %1, i32 0, i32 0
  %32 = load i32, ptr %31, align 4
  %33 = getelementptr inbounds %struct.square_t, ptr %1, i32 0, i32 1
  %34 = load i32, ptr %33, align 4
  %35 = sdiv i32 %34, 2
  %36 = add nsw i32 250, %35
  %37 = icmp sge i32 %32, %36
  br i1 %37, label %38, label %43

38:                                               ; preds = %30
  %39 = getelementptr inbounds %struct.square_t, ptr %1, i32 0, i32 1
  %40 = load i32, ptr %39, align 4
  %41 = sub nsw i32 0, %40
  %42 = getelementptr inbounds %struct.square_t, ptr %1, i32 0, i32 0
  store i32 %41, ptr %42, align 4
  br label %43

43:                                               ; preds = %38, %30
  %44 = getelementptr inbounds %struct.square_t, ptr %1, i32 0, i32 0
  %45 = load i32, ptr %44, align 4
  %46 = add nsw i32 %45, 1
  store i32 %46, ptr %44, align 4
  br label %7
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #2

declare void @paint_pixel(i32 noundef, i32 noundef, i32 noundef) #3

declare void @flush_window(...) #3

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #3 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }

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
