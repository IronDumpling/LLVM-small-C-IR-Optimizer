; ModuleID = 'testcases/test6.bc'
source_filename = "testcases/test6.bc"
target triple = "x86_64-unknown-linux-gnu"

define i32 @function1() {
entry:
  ret i32 -1
}

define i1 @function2() {
entry:
  ret i1 false
}

define void @main() {
entry:
  %x = alloca [10 x i1], align 1
  %y = alloca i1, align 1
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca [1000 x i32], align 4
  %i = alloca i32, align 4
  store i32 0, ptr %i, align 4
  br label %while.condition

while.condition:                                  ; preds = %while.body, %entry
  %0 = load i32, ptr %i, align 4
  %1 = icmp slt i32 %0, 100
  br i1 %1, label %while.body, label %while.exit

while.body:                                       ; preds = %while.condition
  %2 = load i32, ptr %i, align 4
  %3 = load i32, ptr %i, align 4
  %4 = getelementptr [1000 x i32], ptr %c, i32 0, i32 %3
  store i32 %2, ptr %4, align 4
  %5 = load i32, ptr %i, align 4
  %6 = add i32 %5, 1
  store i32 %6, ptr %i, align 4
  br label %while.condition

while.exit:                                       ; preds = %while.condition
  %7 = load i1, ptr %y, align 1
  %8 = getelementptr [10 x i1], ptr %x, i32 0, i32 3
  store i1 %7, ptr %8, align 1
  %9 = getelementptr [10 x i1], ptr %x, i32 0, i32 4
  %10 = load i1, ptr %9, align 1
  store i1 %10, ptr %y, align 1
  %11 = getelementptr [1000 x i32], ptr %c, i32 0, i32 3
  %12 = load i32, ptr %11, align 4
  %13 = sdiv i32 6, %12
  store i32 %13, ptr %b, align 4
  %14 = load i32, ptr %b, align 4
  store i32 %14, ptr %a, align 4
  %15 = load i32, ptr %a, align 4
  %16 = add i32 20, %15
  %17 = getelementptr [1000 x i32], ptr %c, i32 0, i32 %16
  %18 = load i32, ptr %17, align 4
  store i32 %18, ptr %b, align 4
  %19 = call i32 @function1()
  store i32 %19, ptr %a, align 4
  %20 = call i1 @function2()
  store i1 %20, ptr %y, align 1
  %21 = load i32, ptr %a, align 4
  %22 = icmp eq i32 %21, -1
  br i1 %22, label %if.then, label %if.merge

if.then:                                          ; preds = %while.exit
  %23 = load i32, ptr %b, align 4
  store i32 %23, ptr %a, align 4
  br label %if.merge

if.merge:                                         ; preds = %if.then, %while.exit
  %24 = load i32, ptr %a, align 4
  call void @writeInt(i32 %24)
  %25 = load i1, ptr %y, align 1
  call void @writeBool(i1 %25)
  call void @newLine()
  ret void
}

declare void @newLine()

declare i1 @readBool()

declare i32 @readInt()

declare void @writeBool(i1 zeroext)

declare void @writeInt(i32)
