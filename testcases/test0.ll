; ModuleID = 'testcases/test0.bc'
source_filename = "testcases/test0.bc"
target triple = "x86_64-unknown-linux-gnu"

define i1 @barArray(ptr %y) {
entry:
  %y1 = alloca ptr, align 8
  store ptr %y, ptr %y1, align 8
  %x = alloca [2 x i32], align 4
  %n = alloca [5 x i32], align 4
  %f = alloca i32, align 4
  %d = alloca i32, align 4
  %0 = getelementptr [5 x i32], ptr %n, i32 0, i32 7
  %1 = load i32, ptr %0, align 4
  %2 = load ptr, ptr %y1, align 8
  %3 = getelementptr i32, ptr %2, i32 3
  %4 = load i32, ptr %3, align 4
  %5 = add i32 %1, %4
  %6 = getelementptr [2 x i32], ptr %x, i32 0, i32 2
  store i32 %5, ptr %6, align 4
  %7 = load i32, ptr %d, align 4
  %8 = load i32, ptr %f, align 4
  %9 = add i32 %7, %8
  %10 = load ptr, ptr %y1, align 8
  %11 = getelementptr i32, ptr %10, i32 %9
  %12 = load i32, ptr %11, align 4
  %13 = getelementptr [5 x i32], ptr %n, i32 0, i32 1
  %14 = load i32, ptr %13, align 4
  %15 = icmp slt i32 8, %14
  ret i1 %15
}