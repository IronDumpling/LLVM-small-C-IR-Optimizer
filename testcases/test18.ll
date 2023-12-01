; ModuleID = 'testcases/test18.bc'
source_filename = "testcases/test18.bc"
target triple = "x86_64-unknown-linux-gnu"

define void @foo(i32 %a, ptr %b, ptr %c) {
entry:
  %a1 = alloca i32, align 4
  store i32 %a, ptr %a1, align 4
  %b2 = alloca ptr, align 8
  store ptr %b, ptr %b2, align 8
  %c3 = alloca ptr, align 8
  store ptr %c, ptr %c3, align 8
  %i = alloca i32, align 4
  store i32 0, ptr %i, align 4
  store i32 1, ptr %a1, align 4
  br label %while.condition

while.condition:                                  ; preds = %if.merge, %entry
  %0 = load i32, ptr %i, align 4
  %1 = icmp slt i32 %0, 10
  br i1 %1, label %while.body, label %while.exit

while.body:                                       ; preds = %while.condition
  %2 = load i32, ptr %i, align 4
  %3 = load ptr, ptr %b2, align 8
  %4 = getelementptr i1, ptr %3, i32 %2
  store i1 false, ptr %4, align 1
  %5 = load i32, ptr %i, align 4
  %6 = load ptr, ptr %c3, align 8
  %7 = getelementptr i32, ptr %6, i32 %5
  %8 = load i32, ptr %7, align 4
  call void @writeInt(i32 %8)
  %9 = load i32, ptr %i, align 4
  %10 = load ptr, ptr %b2, align 8
  %11 = getelementptr i1, ptr %10, i32 %9
  %12 = load i1, ptr %11, align 1
  %13 = icmp eq i1 %12, false
  br i1 %13, label %if.then, label %if.merge

while.exit:                                       ; preds = %while.condition
  ret void

if.then:                                          ; preds = %while.body
  %14 = load i32, ptr %i, align 4
  %15 = load ptr, ptr %c3, align 8
  %16 = getelementptr i32, ptr %15, i32 %14
  %17 = load i32, ptr %16, align 4
  %18 = load i32, ptr %i, align 4
  %19 = add i32 %18, 3
  %20 = load ptr, ptr %c3, align 8
  %21 = getelementptr i32, ptr %20, i32 %19
  %22 = load i32, ptr %21, align 4
  %23 = add i32 %17, %22
  %24 = load ptr, ptr %c3, align 8
  %25 = getelementptr i32, ptr %24, i32 %23
  store i32 5, ptr %25, align 4
  %26 = load i32, ptr %i, align 4
  %27 = load ptr, ptr %c3, align 8
  %28 = getelementptr i32, ptr %27, i32 %26
  %29 = load i32, ptr %28, align 4
  call void @writeInt(i32 %29)
  ret void

if.merge:                                         ; preds = %while.body
  br label %while.condition
}

define i32 @main() {
entry:
  %a = alloca [10 x i1], align 1
  %d = alloca [10 x i32], align 4
  %q = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 -1, ptr %q, align 4
  store i32 0, ptr %i, align 4
  br label %while.condition

while.condition:                                  ; preds = %while.body, %entry
  %0 = load i32, ptr %i, align 4
  %1 = icmp slt i32 %0, 10
  br i1 %1, label %while.body, label %while.exit

while.body:                                       ; preds = %while.condition
  %2 = load i32, ptr %i, align 4
  %3 = getelementptr [10 x i1], ptr %a, i32 0, i32 %2
  store i1 true, ptr %3, align 1
  %4 = load i32, ptr %i, align 4
  %5 = getelementptr [10 x i32], ptr %d, i32 0, i32 %4
  store i32 1, ptr %5, align 4
  %6 = load i32, ptr %q, align 4
  %7 = load i32, ptr %i, align 4
  %8 = getelementptr [10 x i32], ptr %d, i32 0, i32 %7
  %9 = load i32, ptr %8, align 4
  %10 = add i32 %6, %9
  store i32 %10, ptr %q, align 4
  %11 = load i32, ptr %i, align 4
  %12 = add i32 %11, 1
  store i32 %12, ptr %i, align 4
  br label %while.condition

while.exit:                                       ; preds = %while.condition
  %13 = load i32, ptr %q, align 4
  %14 = load i32, ptr %q, align 4
  %15 = getelementptr [10 x i32], ptr %d, i32 0, i32 %14
  %16 = load i32, ptr %15, align 4
  %17 = mul i32 10, %16
  %18 = icmp sle i32 %13, %17
  br i1 %18, label %if.then, label %if.merge

if.then:                                          ; preds = %while.exit
  %19 = load i32, ptr %q, align 4
  %20 = getelementptr [10 x i32], ptr %d, i32 0, i32 %19
  %21 = load i32, ptr %20, align 4
  %22 = load i32, ptr %q, align 4
  %23 = add i32 %21, %22
  %24 = getelementptr [10 x i32], ptr %d, i32 0, i32 3
  %25 = load i32, ptr %24, align 4
  %26 = add i32 %25, 1
  %27 = getelementptr [10 x i32], ptr %d, i32 0, i32 %26
  store i32 %23, ptr %27, align 4
  %28 = load i32, ptr %q, align 4
  %29 = getelementptr [10 x i32], ptr %d, i32 0, i32 %28
  %30 = load i32, ptr %29, align 4
  %31 = getelementptr [10 x i32], ptr %d, i32 0, i32 %30
  %32 = load i32, ptr %31, align 4
  call void @writeInt(i32 %32)
  br label %if.merge

if.merge:                                         ; preds = %if.then, %while.exit
  %33 = load i32, ptr %q, align 4
  %34 = getelementptr [10 x i1], ptr %a, i32 0, i32 0
  %35 = getelementptr [10 x i32], ptr %d, i32 0, i32 0
  call void @foo(i32 %33, ptr %34, ptr %35)
  %36 = load i32, ptr %q, align 4
  ret i32 %36
}

declare void @newLine()

declare i1 @readBool()

declare i32 @readInt()

declare void @writeBool(i1 zeroext)

declare void @writeInt(i32)
