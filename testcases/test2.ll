; ModuleID = 'tests/3.c'
source_filename = "tests/3.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %z = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  store i32 1, ptr %x, align 4
  store i32 3, ptr %y, align 4
  store i32 11, ptr %z, align 4
  br label %while.cond

while.cond:                                       ; preds = %if.end, %entry
  %0 = load i32, ptr %x, align 4
  %cmp = icmp slt i32 %0, 5
  br i1 %cmp, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %while.cond
  %1 = load i32, ptr %z, align 4
  %cmp1 = icmp ne i32 %1, 1
  br label %land.end

land.end:                                         ; preds = %land.rhs, %while.cond
  %2 = phi i1 [ false, %while.cond ], [ %cmp1, %land.rhs ]
  br i1 %2, label %while.body, label %while.end

while.body:                                       ; preds = %land.end
  %3 = load i32, ptr %y, align 4
  %cmp2 = icmp slt i32 %3, 5
  br i1 %cmp2, label %if.then, label %if.else

if.then:                                          ; preds = %while.body
  %4 = load i32, ptr %y, align 4
  %add = add nsw i32 %4, 1
  store i32 %add, ptr %y, align 4
  br label %if.end

if.else:                                          ; preds = %while.body
  %5 = load i32, ptr %y, align 4
  %sub = sub nsw i32 %5, 1
  store i32 %sub, ptr %y, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %6 = load i32, ptr %x, align 4
  %add3 = add nsw i32 %6, 1
  store i32 %add3, ptr %x, align 4
  br label %while.cond, !llvm.loop !6

while.end:                                        ; preds = %land.end
  ret i32 0
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"clang version 18.0.0 (https://github.com/llvm/llvm-project.git bf87638a9d2771a75f59aa40296368cdec3e7353)"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
