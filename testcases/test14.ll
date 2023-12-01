; ModuleID = 'testcases/test14.bc'
source_filename = "testcases/test14.bc"
target triple = "x86_64-unknown-linux-gnu"

define void @abc() {
entry:
  %x = alloca i32, align 4
  store i32 2, ptr %x, align 4
  ret void
}

declare void @def()

define i32 @main() {
entry:
  %a = alloca [3 x i32], align 4
  %b = alloca i32, align 4
  %c = alloca i1, align 1
  store i1 false, ptr %c, align 1
  store i32 8, ptr %b, align 4
  %0 = getelementptr [3 x i32], ptr %a, i32 0, i32 0
  store i32 5, ptr %0, align 4
  %1 = getelementptr [3 x i32], ptr %a, i32 0, i32 1
  store i32 3, ptr %1, align 4
  %2 = getelementptr [3 x i32], ptr %a, i32 0, i32 2
  store i32 4, ptr %2, align 4
  %3 = getelementptr [3 x i32], ptr %a, i32 0, i32 0
  %4 = load i32, ptr %3, align 4
  store i32 %4, ptr %b, align 4
  %5 = getelementptr [3 x i32], ptr %a, i32 0, i32 2
  %6 = load i32, ptr %5, align 4
  %7 = getelementptr [3 x i32], ptr %a, i32 0, i32 1
  store i32 %6, ptr %7, align 4
  call void @abc()
  %8 = load i32, ptr %b, align 4
  call void @writeInt(i32 %8)
  call void @newLine()
  %9 = getelementptr [3 x i32], ptr %a, i32 0, i32 0
  %10 = load i32, ptr %9, align 4
  call void @writeInt(i32 %10)
  call void @newLine()
  %11 = getelementptr [3 x i32], ptr %a, i32 0, i32 1
  %12 = load i32, ptr %11, align 4
  call void @writeInt(i32 %12)
  call void @newLine()
  %13 = getelementptr [3 x i32], ptr %a, i32 0, i32 2
  %14 = load i32, ptr %13, align 4
  call void @writeInt(i32 %14)
  call void @newLine()
  %15 = call i1 @readBool()
  %16 = or i1 true, %15
  store i1 %16, ptr %c, align 1
  %17 = call i32 @readInt()
  %18 = getelementptr [3 x i32], ptr %a, i32 0, i32 0
  store i32 %17, ptr %18, align 4
  %19 = load i1, ptr %c, align 1
  call void @writeBool(i1 %19)
  %20 = load i32, ptr %b, align 4
  call void @writeInt(i32 %20)
  call void @newLine()
  ret i32 0
}

declare void @newLine()

declare i1 @readBool()

declare i32 @readInt()

declare void @writeBool(i1 zeroext)

declare void @writeInt(i32)
