; ModuleID = 'testcases/test17.bc'
source_filename = "testcases/test17.bc"
target triple = "x86_64-unknown-linux-gnu"

@gloablBool = common global i1 false
@a = common global i32 0
@array = common global [4 x i32] zeroinitializer

define i32 @main() {
entry:
  %z = alloca i1, align 1
  store i1 false, ptr %z, align 1
  %0 = load i1, ptr %z, align 1
  call void @writeBool(i1 %0)
  call void @newLine()
  %1 = load i1, ptr %z, align 1
  %2 = icmp eq i1 %1, false
  call void @writeBool(i1 %2)
  %3 = load i1, ptr @gloablBool, align 1
  %4 = icmp eq i1 %3, false
  call void @writeBool(i1 %4)
  %5 = load i32, ptr @a, align 4
  %6 = sub i32 0, %5
  call void @writeInt(i32 %6)
  %7 = load i32, ptr @a, align 4
  %8 = load i32, ptr @a, align 4
  %9 = sub i32 %7, %8
  %10 = sub i32 0, %9
  call void @writeInt(i32 %10)
  %11 = load i32, ptr @array, align 4
  %12 = sub i32 0, %11
  call void @writeInt(i32 %12)
  ret i32 0
}

declare void @newLine()

declare i1 @readBool()

declare i32 @readInt()

declare void @writeBool(i1 zeroext)

declare void @writeInt(i32)
