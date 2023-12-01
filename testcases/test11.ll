; ModuleID = 'testcases/test11.bc'
source_filename = "testcases/test11.bc"
target triple = "x86_64-unknown-linux-gnu"

define void @abc(i32 %x) {
entry:
  %x1 = alloca i32, align 4
  store i32 %x, ptr %x1, align 4
  %y = alloca [66 x i1], align 1
  %z = alloca [666 x i32], align 4
  %0 = getelementptr [66 x i1], ptr %y, i32 0, i32 23
  store i1 true, ptr %0, align 1
  %1 = getelementptr [666 x i32], ptr %z, i32 0, i32 233
  store i32 6666, ptr %1, align 4
  ret void
}
