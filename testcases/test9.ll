; ModuleID = 'testcases/test9.bc'
source_filename = "testcases/test9.bc"
target triple = "x86_64-unknown-linux-gnu"

define i32 @func0() {
entry:
  %i = alloca i32, align 4
  store i32 3, ptr %i, align 4
  br label %while.condition

while.condition:                                  ; preds = %entry
  %0 = load i32, ptr %i, align 4
  %1 = icmp slt i32 %0, 4
  br i1 %1, label %while.body, label %while.exit

while.body:                                       ; preds = %while.condition
  %2 = load i32, ptr %i, align 4
  %3 = add i32 %2, 1
  store i32 %3, ptr %i, align 4
  %4 = load i32, ptr %i, align 4
  %5 = icmp sgt i32 %4, 1000
  br i1 %5, label %if.then, label %if.else

while.exit:                                       ; preds = %while.condition
  %6 = load i32, ptr %i, align 4
  %7 = icmp ne i32 %6, 0
  br i1 %7, label %if.then13, label %if.else15

if.then:                                          ; preds = %while.body
  ret i32 0

if.merge:                                         ; preds = %if.else
  %8 = load i32, ptr %i, align 4
  %9 = icmp sgt i32 %8, 1
  br i1 %9, label %if.then1, label %if.else3

if.else:                                          ; preds = %while.body
  %10 = load i32, ptr %i, align 4
  %11 = add i32 %10, 2
  br label %if.merge

if.then1:                                         ; preds = %if.merge
  %12 = load i32, ptr %i, align 4
  %13 = icmp sgt i32 %12, 1
  br i1 %13, label %if.then4, label %if.else6

if.merge2:                                        ; preds = %if.merge5
  ret i32 -1

if.else3:                                         ; preds = %if.merge
  %14 = load i32, ptr %i, align 4
  %15 = load i32, ptr %i, align 4
  %16 = mul i32 %14, %15
  %17 = load i32, ptr %i, align 4
  %18 = add i32 %16, %17
  ret i32 %18

if.then4:                                         ; preds = %if.then1
  %19 = load i32, ptr %i, align 4
  %20 = add i32 %19, 1
  store i32 %20, ptr %i, align 4
  %21 = load i32, ptr %i, align 4
  %22 = icmp sgt i32 %21, 2
  br i1 %22, label %if.then7, label %if.else9

if.merge5:                                        ; preds = %if.merge8, %if.else6
  br label %if.merge2

if.else6:                                         ; preds = %if.then1
  store i32 2, ptr %i, align 4
  store i32 1, ptr %i, align 4
  store i32 -4, ptr %i, align 4
  br label %if.merge5

if.then7:                                         ; preds = %if.then4
  %23 = load i32, ptr %i, align 4
  %24 = add i32 %23, 2
  store i32 %24, ptr %i, align 4
  %25 = load i32, ptr %i, align 4
  %26 = mul i32 %25, 2
  store i32 %26, ptr %i, align 4
  %27 = load i32, ptr %i, align 4
  %28 = icmp slt i32 %27, 0
  br i1 %28, label %if.then10, label %if.else12

if.merge8:                                        ; preds = %if.merge11, %if.else9
  br label %if.merge5

if.else9:                                         ; preds = %if.then4
  %29 = load i32, ptr %i, align 4
  %30 = add i32 %29, 1
  store i32 %30, ptr %i, align 4
  br label %if.merge8

if.then10:                                        ; preds = %if.then7
  store i32 0, ptr %i, align 4
  br label %if.merge11

if.merge11:                                       ; preds = %if.else12, %if.then10
  br label %if.merge8

if.else12:                                        ; preds = %if.then7
  %31 = load i32, ptr %i, align 4
  call void @writeInt(i32 %31)
  br label %if.merge11

if.then13:                                        ; preds = %while.exit
  %32 = load i32, ptr %i, align 4
  %33 = add i32 %32, 1
  store i32 %33, ptr %i, align 4
  br label %if.merge14

if.merge14:                                       ; preds = %if.then13
  ret i32 -3

if.else15:                                        ; preds = %while.exit
  ret i32 -4
}

define void @func1() {
entry:
  br label %while.condition

while.condition:                                  ; preds = %entry
  br i1 true, label %while.body, label %while.exit

while.body:                                       ; preds = %while.condition
  ret void

while.exit:                                       ; preds = %while.condition
  ret void
}

define void @func2() {
entry:
  br label %while.condition

while.condition:                                  ; preds = %entry
  br i1 true, label %while.body, label %while.exit

while.body:                                       ; preds = %while.condition
  ret void

while.exit:                                       ; preds = %while.condition
  ret void
}

define void @func3() {
entry:
  br i1 false, label %if.then, label %if.merge

if.then:                                          ; preds = %entry
  ret void

if.merge:                                         ; preds = %entry
  ret void
}

define void @main() {
entry:
  %a = alloca i32, align 4
  %0 = call i32 @func0()
  store i32 %0, ptr %a, align 4
  call void @func1()
  call void @func2()
  %1 = load i32, ptr %a, align 4
  %2 = icmp sgt i32 %1, 3
  br i1 %2, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  br label %if.merge

if.merge:                                         ; preds = %if.else, %if.then
  br label %while.condition

if.else:                                          ; preds = %entry
  br label %if.merge

while.condition:                                  ; preds = %while.body, %if.merge
  br i1 false, label %while.body, label %while.exit

while.body:                                       ; preds = %while.condition
  br label %while.condition

while.exit:                                       ; preds = %while.condition
  br label %while.condition1

while.condition1:                                 ; preds = %while.exit
  br i1 true, label %while.body2, label %while.exit3

while.body2:                                      ; preds = %while.condition1
  ret void

while.exit3:                                      ; preds = %while.condition1
  ret void
}

declare void @newLine()

declare i1 @readBool()

declare i32 @readInt()

declare void @writeBool(i1 zeroext)

declare void @writeInt(i32)
