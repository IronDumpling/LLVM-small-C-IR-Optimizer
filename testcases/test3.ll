; ModuleID = 'testcases/test3.bc'
source_filename = "testcases/test3.bc"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  %t = alloca i1, align 1
  %t2 = alloca i1, align 1
  %t3 = alloca i1, align 1
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %z = alloca i32, align 4
  store i32 5, ptr %y, align 4
  store i1 false, ptr %t, align 1
  store i1 false, ptr %t2, align 1
  store i1 true, ptr %t3, align 1
  %0 = load i1, ptr %t2, align 1
  %1 = load i1, ptr %t3, align 1
  %2 = and i1 %0, %1
  %3 = load i1, ptr %t2, align 1
  %4 = or i1 %2, %3
  %5 = load i1, ptr %t, align 1
  %6 = or i1 %4, %5
  br i1 %6, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %7 = load i32, ptr %y, align 4
  call void @writeInt(i32 %7)
  br label %if.merge

if.merge:                                         ; preds = %if.else, %if.then
  call void @newLine()
  ret i32 0

if.else:                                          ; preds = %entry
  call void @writeInt(i32 0)
  br label %if.merge
}

declare void @newLine()

declare i1 @readBool()

declare i32 @readInt()

declare void @writeBool(i1 zeroext)

declare void @writeInt(i32)
