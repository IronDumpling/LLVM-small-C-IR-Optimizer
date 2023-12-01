; ModuleID = 'testcases/test8.bc'
source_filename = "testcases/test8.bc"
target triple = "x86_64-unknown-linux-gnu"

@global = common global [10 x i32] zeroinitializer

define void @arrayInit(ptr %arr) {
entry:
  %arr1 = alloca ptr, align 8
  store ptr %arr, ptr %arr1, align 8
  %i = alloca i32, align 4
  %0 = load ptr, ptr %arr1, align 8
  %1 = getelementptr i32, ptr %0, i32 0
  %2 = load i32, ptr %1, align 4
  %3 = icmp eq i32 %2, 2
  br i1 %3, label %if.then, label %if.merge

if.then:                                          ; preds = %entry
  ret void

if.merge:                                         ; preds = %entry
  store i32 0, ptr %i, align 4
  br label %while.condition

while.condition:                                  ; preds = %while.body, %if.merge
  %4 = load i32, ptr %i, align 4
  %5 = icmp slt i32 %4, 10
  br i1 %5, label %while.body, label %while.exit

while.body:                                       ; preds = %while.condition
  %6 = load i32, ptr %i, align 4
  %7 = load ptr, ptr %arr1, align 8
  %8 = getelementptr i32, ptr %7, i32 %6
  %9 = load i32, ptr %8, align 4
  %10 = add i32 %9, 1
  %11 = load i32, ptr %i, align 4
  %12 = add i32 %10, %11
  %13 = load i32, ptr %i, align 4
  %14 = load ptr, ptr %arr1, align 8
  %15 = getelementptr i32, ptr %14, i32 %13
  store i32 %12, ptr %15, align 4
  %16 = load i32, ptr %i, align 4
  %17 = add i32 %16, 1
  store i32 %17, ptr %i, align 4
  br label %while.condition

while.exit:                                       ; preds = %while.condition
  %18 = load ptr, ptr %arr1, align 8
  call void @arrayInit(ptr %18)
  ret void
}

define i32 @arrayPass(i32 %a, ptr %b) {
entry:
  %a1 = alloca i32, align 4
  store i32 %a, ptr %a1, align 4
  %b2 = alloca ptr, align 8
  store ptr %b, ptr %b2, align 8
  %i = alloca i32, align 4
  store i32 1, ptr %i, align 4
  br label %while.condition

while.condition:                                  ; preds = %while.body, %entry
  %0 = load i32, ptr %i, align 4
  %1 = icmp slt i32 %0, 10
  br i1 %1, label %while.body, label %while.exit

while.body:                                       ; preds = %while.condition
  %2 = load i32, ptr %a1, align 4
  %3 = load i32, ptr %i, align 4
  %4 = add i32 %2, %3
  %5 = load i32, ptr %i, align 4
  %6 = sub i32 %5, 1
  %7 = load ptr, ptr %b2, align 8
  %8 = getelementptr i32, ptr %7, i32 %6
  %9 = load i32, ptr %8, align 4
  %10 = add i32 %4, %9
  %11 = load i32, ptr %i, align 4
  %12 = load ptr, ptr %b2, align 8
  %13 = getelementptr i32, ptr %12, i32 %11
  store i32 %10, ptr %13, align 4
  %14 = load i32, ptr %i, align 4
  %15 = add i32 %14, 1
  store i32 %15, ptr %i, align 4
  br label %while.condition

while.exit:                                       ; preds = %while.condition
  %16 = load i32, ptr %a1, align 4
  %17 = load ptr, ptr %b2, align 8
  %18 = getelementptr i32, ptr %17, i32 9
  %19 = load i32, ptr %18, align 4
  %20 = add i32 %16, %19
  ret i32 %20
}

define i32 @main() {
entry:
  %test = alloca [10 x i32], align 4
  %i = alloca i32, align 4
  store i32 0, ptr %i, align 4
  br label %while.condition

while.condition:                                  ; preds = %while.body, %entry
  %0 = load i32, ptr %i, align 4
  %1 = icmp slt i32 %0, 10
  br i1 %1, label %while.body, label %while.exit

while.body:                                       ; preds = %while.condition
  %2 = load i32, ptr %i, align 4
  %3 = getelementptr [10 x i32], ptr %test, i32 0, i32 %2
  store i32 0, ptr %3, align 4
  %4 = load i32, ptr %i, align 4
  %5 = add i32 %4, 1
  store i32 %5, ptr %i, align 4
  br label %while.condition

while.exit:                                       ; preds = %while.condition
  %6 = getelementptr [10 x i32], ptr %test, i32 0, i32 0
  call void @arrayInit(ptr %6)
  call void @arrayInit(ptr @global)
  %7 = load i32, ptr getelementptr inbounds ([10 x i32], ptr @global, i32 0, i32 5), align 4
  call void @writeInt(i32 %7)
  %8 = getelementptr [10 x i32], ptr %test, i32 0, i32 0
  %9 = call i32 @arrayPass(i32 5, ptr %8)
  call void @writeInt(i32 %9)
  %10 = getelementptr [10 x i32], ptr %test, i32 0, i32 0
  %11 = call i32 @writeTest(i32 0, ptr %10)
  ret i32 0
}

declare void @newLine()

declare i1 @readBool()

declare i32 @readInt()

declare void @writeBool(i1 zeroext)

declare void @writeInt(i32)

define i32 @writeTest(i32 %a, ptr %b) {
entry:
  %a1 = alloca i32, align 4
  store i32 %a, ptr %a1, align 4
  %b2 = alloca ptr, align 8
  store ptr %b, ptr %b2, align 8
  %i = alloca i32, align 4
  store i32 0, ptr %i, align 4
  br label %while.condition

while.condition:                                  ; preds = %while.body, %entry
  %0 = load i32, ptr %i, align 4
  %1 = icmp slt i32 %0, 10
  br i1 %1, label %while.body, label %while.exit

while.body:                                       ; preds = %while.condition
  %2 = load i32, ptr %i, align 4
  %3 = load ptr, ptr %b2, align 8
  %4 = getelementptr i32, ptr %3, i32 %2
  %5 = load i32, ptr %4, align 4
  call void @writeInt(i32 %5)
  %6 = load i32, ptr %i, align 4
  %7 = add i32 %6, 1
  store i32 %7, ptr %i, align 4
  br label %while.condition

while.exit:                                       ; preds = %while.condition
  ret i32 0
}
