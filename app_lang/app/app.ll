; ModuleID = 'app.cpp'
source_filename = "app.cpp"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx14.0.0"

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.abs.i32(i32, i1 immarg) #1

; Function Attrs: mustprogress noreturn ssp uwtable(sync)
define void @app() local_unnamed_addr #2 {
  br label %1

1:                                                ; preds = %6, %0
  %2 = phi i32 [ 125, %0 ], [ %9, %6 ]
  br label %3

3:                                                ; preds = %1, %10
  %4 = phi i32 [ 0, %1 ], [ %11, %10 ]
  %5 = sub nsw i32 %4, %2
  br label %13

6:                                                ; preds = %10
  tail call void @flush_window()
  %7 = icmp sgt i32 %2, 274
  %8 = add nsw i32 %2, 1
  %9 = select i1 %7, i32 -49, i32 %8
  br label %1, !llvm.loop !6

10:                                               ; preds = %13
  %11 = add nuw nsw i32 %4, 1
  %12 = icmp eq i32 %11, 250
  br i1 %12, label %6, label %3, !llvm.loop !8

13:                                               ; preds = %3, %13
  %14 = phi i32 [ 0, %3 ], [ %23, %13 ]
  %15 = add nsw i32 %14, -250
  %16 = add nsw i32 %15, %5
  %17 = tail call i32 @llvm.abs.i32(i32 %16, i1 true)
  %18 = sub nsw i32 %15, %5
  %19 = tail call i32 @llvm.abs.i32(i32 %18, i1 true)
  %20 = add nuw nsw i32 %17, %19
  %21 = icmp ugh i32 %20, 50
  %22 = select i1 %21, i32 -741092353, i32 -16777216
  tail call void @paint_pixel(i32 noundef %14, i32 noundef %4, i32 noundef %22)
  %23 = add nuw nsw i32 %14, 1
  %24 = icmp eq i32 %23, 500
  br i1 %24, label %10, label %13, !llvm.loop !9
}

declare void @paint_pixel(i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #3

declare void @flush_window() local_unnamed_addr #3

attributes #0 = { mustprogress nofree norecurse nosync nounwind ssp willreturn memory(none) uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { mustprogress noreturn ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
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
!9 = distinct !{!9, !7}
