; ModuleID = 'testcases/test16.bc'
source_filename = "testcases/test16.bc"
target triple = "x86_64-unknown-linux-gnu"

define void @main() {
entry:
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %z = alloca i32, align 4
  br label %while.condition

while.condition:                                  ; preds = %entry
  %0 = load i32, ptr %x, align 4
  %1 = icmp slt i32 %0, 5
  br i1 %1, label %while.body, label %while.exit

while.body:                                       ; preds = %while.condition
  ret void

while.exit:                                       ; preds = %while.condition
  %2 = load i32, ptr %x, align 4
  %3 = icmp sgt i32 %2, 6
  br i1 %3, label %if.then, label %if.else

if.then:                                          ; preds = %while.exit
  ret void

if.merge:                                         ; No predecessors!
  %4 = load i32, ptr %y, align 4
  %5 = load i32, ptr %z, align 4
  %6 = icmp eq i32 %4, %5
  br i1 %6, label %if.then1, label %if.else3

if.else:                                          ; preds = %while.exit
  ret void

if.then1:                                         ; preds = %if.merge
  store i32 2, ptr %y, align 4
  br label %if.merge2

if.merge2:                                        ; preds = %if.else3, %if.then1
  ret void

if.else3:                                         ; preds = %if.merge
  store i32 1, ptr %z, align 4
  br label %if.merge2
}

declare void @newLine()

declare i1 @readBool()

declare i32 @readInt()

declare void @writeBool(i1 zeroext)

declare void @writeInt(i32)
