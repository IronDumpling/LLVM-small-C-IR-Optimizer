; ModuleID = 'testcases/test13.bc'
source_filename = "testcases/test13.bc"
target triple = "x86_64-unknown-linux-gnu"

define void @abc() {
entry:
  %x = alloca i1, align 1
  %y = alloca i1, align 1
  %z = alloca i32, align 4
  %w = alloca i32, align 4
  %0 = load i1, ptr %x, align 1
  %1 = load i1, ptr %y, align 1
  %2 = and i1 %0, %1
  br i1 %2, label %if.then, label %if.merge

if.then:                                          ; preds = %entry
  store i32 777, ptr %z, align 4
  br label %if.merge

if.merge:                                         ; preds = %if.then, %entry
  %3 = load i1, ptr %x, align 1
  %4 = load i1, ptr %y, align 1
  %5 = and i1 %3, %4
  br i1 %5, label %if.then1, label %if.else

if.then1:                                         ; preds = %if.merge
  store i32 777, ptr %z, align 4
  br label %if.merge2

if.merge2:                                        ; preds = %if.else, %if.then1
  br label %while.condition

if.else:                                          ; preds = %if.merge
  store i32 1234, ptr %w, align 4
  br label %if.merge2

while.condition:                                  ; preds = %while.body, %if.merge2
  %6 = load i32, ptr %z, align 4
  %7 = load i32, ptr %w, align 4
  %8 = icmp eq i32 %6, %7
  br i1 %8, label %while.body, label %while.exit

while.body:                                       ; preds = %while.condition
  store i1 false, ptr %x, align 1
  br label %while.condition

while.exit:                                       ; preds = %while.condition
  ret void
}
