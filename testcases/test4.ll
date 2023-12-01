; ModuleID = 'testcases/test4.bc'
source_filename = "testcases/test4.bc"
target triple = "x86_64-unknown-linux-gnu"

@q = common global i32 0

define i32 @main() {
entry:
  store i32 13, ptr @q, align 4
  %0 = load i32, ptr @q, align 4
  call void @writeInt(i32 %0)
  call void @newLine()
  %1 = load i32, ptr @q, align 4
  ret i32 %1
}

declare void @newLine()

declare i1 @readBool()

declare i32 @readInt()

declare void @writeBool(i1 zeroext)

declare void @writeInt(i32)
