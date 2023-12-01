; ModuleID = 'testcases/test12.bc'
source_filename = "testcases/test12.bc"
target triple = "x86_64-unknown-linux-gnu"

define void @abc() {
entry:
  %x = alloca i1, align 1
  %y = alloca i1, align 1
  %z = alloca i32, align 4
  store i1 true, ptr %x, align 1
  store i1 true, ptr %y, align 1
  br i1 false, label %if.then, label %if.merge

if.then:                                          ; preds = %entry
  store i32 777, ptr %z, align 4
  br label %if.merge

if.merge:                                         ; preds = %if.then, %entry
  ret void
}
