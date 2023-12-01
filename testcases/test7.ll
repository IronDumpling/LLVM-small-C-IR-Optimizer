; ModuleID = 'testcases/test7.bc'
source_filename = "testcases/test7.bc"
target triple = "x86_64-unknown-linux-gnu"

define void @main() {
entry:
  %x = alloca [10 x i32], align 4
  %y = alloca [10 x i32], align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store i32 0, ptr %i, align 4
  store i32 1, ptr %j, align 4
  br label %while.condition

while.condition:                                  ; preds = %while.body, %entry
  %0 = load i32, ptr %i, align 4
  %1 = icmp slt i32 %0, 10
  br i1 %1, label %while.body, label %while.exit

while.body:                                       ; preds = %while.condition
  %2 = load i32, ptr %i, align 4
  %3 = load i32, ptr %i, align 4
  %4 = getelementptr [10 x i32], ptr %x, i32 0, i32 %3
  store i32 %2, ptr %4, align 4
  %5 = load i32, ptr %i, align 4
  %6 = add i32 %5, 1
  store i32 %6, ptr %i, align 4
  br label %while.condition

while.exit:                                       ; preds = %while.condition
  br label %while.condition1

while.condition1:                                 ; preds = %while.body2, %while.exit
  %7 = load i32, ptr %j, align 4
  %8 = icmp slt i32 %7, 10
  br i1 %8, label %while.body2, label %while.exit3

while.body2:                                      ; preds = %while.condition1
  %9 = load i32, ptr %j, align 4
  %10 = load i32, ptr %j, align 4
  %11 = mul i32 %9, %10
  %12 = load i32, ptr %j, align 4
  %13 = getelementptr [10 x i32], ptr %y, i32 0, i32 %12
  store i32 %11, ptr %13, align 4
  %14 = load i32, ptr %j, align 4
  %15 = add i32 %14, 1
  store i32 %15, ptr %j, align 4
  br label %while.condition1

while.exit3:                                      ; preds = %while.condition1
  %16 = getelementptr [10 x i32], ptr %x, i32 0, i32 5
  %17 = load i32, ptr %16, align 4
  %18 = getelementptr [10 x i32], ptr %y, i32 0, i32 %17
  %19 = load i32, ptr %18, align 4
  call void @writeInt(i32 %19)
  ret void
}

declare void @newLine()

declare i1 @readBool()

declare i32 @readInt()

declare void @writeBool(i1 zeroext)

declare void @writeInt(i32)
