; ModuleID = 'testcases/test10.bc'
source_filename = "testcases/test10.bc"
target triple = "x86_64-unknown-linux-gnu"

define void @abc(ptr %a, ptr %b) {
entry:
  %a1 = alloca ptr, align 8
  store ptr %a, ptr %a1, align 8
  %b2 = alloca ptr, align 8
  store ptr %b, ptr %b2, align 8
  ret void
}

define void @def(i32 %a, i1 zeroext %b) {
entry:
  %a1 = alloca i32, align 4
  store i32 %a, ptr %a1, align 4
  %b2 = alloca i1, align 1
  store i1 %b, ptr %b2, align 1
  ret void
}

define i32 @main(i32 %a, i1 zeroext %b, ptr %c, i1 zeroext %d, ptr %e) {
entry:
  %a1 = alloca i32, align 4
  store i32 %a, ptr %a1, align 4
  %b2 = alloca i1, align 1
  store i1 %b, ptr %b2, align 1
  %c3 = alloca ptr, align 8
  store ptr %c, ptr %c3, align 8
  %d4 = alloca i1, align 1
  store i1 %d, ptr %d4, align 1
  %e5 = alloca ptr, align 8
  store ptr %e, ptr %e5, align 8
  %z = alloca [2 x i32], align 4
  %y = alloca [3 x i1], align 1
  store i32 1, ptr %a1, align 4
  store i1 true, ptr %b2, align 1
  %0 = getelementptr [2 x i32], ptr %z, i32 0, i32 666
  store i32 1, ptr %0, align 4
  %1 = getelementptr [3 x i1], ptr %y, i32 0, i32 777
  store i1 true, ptr %1, align 1
  %2 = load ptr, ptr %c3, align 8
  %3 = getelementptr i32, ptr %2, i32 100
  store i32 2, ptr %3, align 4
  %4 = load ptr, ptr %c3, align 8
  %5 = getelementptr i32, ptr %4, i32 666
  %6 = load i32, ptr %5, align 4
  store i32 %6, ptr %a1, align 4
  %7 = getelementptr [2 x i32], ptr %z, i32 0, i32 0
  %8 = load ptr, ptr %e5, align 8
  call void @abc(ptr %7, ptr %8)
  %9 = load ptr, ptr %c3, align 8
  %10 = getelementptr [3 x i1], ptr %y, i32 0, i32 0
  call void @abc(ptr %9, ptr %10)
  %11 = load i32, ptr %a1, align 4
  %12 = sdiv i32 %11, 2
  %13 = add i32 %12, 5
  %14 = getelementptr [2 x i32], ptr %z, i32 0, i32 %13
  %15 = load i32, ptr %14, align 4
  %16 = load i32, ptr %a1, align 4
  %17 = mul i32 %16, 3
  %18 = load ptr, ptr %e5, align 8
  %19 = getelementptr i1, ptr %18, i32 %17
  %20 = load i1, ptr %19, align 1
  call void @def(i32 %15, i1 %20)
  %21 = load i1, ptr %b2, align 1
  %22 = getelementptr [2 x i32], ptr %z, i32 0, i1 %21
  %23 = load i32, ptr %22, align 4
  %24 = load ptr, ptr %c3, align 8
  %25 = getelementptr i32, ptr %24, i32 %23
  %26 = load i32, ptr %25, align 4
  %27 = getelementptr [2 x i32], ptr %z, i32 0, i32 %26
  %28 = load i32, ptr %27, align 4
  %29 = load ptr, ptr %c3, align 8
  %30 = getelementptr i32, ptr %29, i32 %28
  %31 = load i32, ptr %30, align 4
  %32 = getelementptr [2 x i32], ptr %z, i32 0, i32 %31
  %33 = load i32, ptr %32, align 4
  %34 = load i32, ptr %a1, align 4
  %35 = getelementptr [2 x i32], ptr %z, i32 0, i32 %34
  %36 = load i32, ptr %35, align 4
  %37 = load ptr, ptr %c3, align 8
  %38 = getelementptr i32, ptr %37, i32 %36
  %39 = load i32, ptr %38, align 4
  %40 = getelementptr [2 x i32], ptr %z, i32 0, i32 %39
  %41 = load i32, ptr %40, align 4
  %42 = load ptr, ptr %c3, align 8
  %43 = getelementptr i32, ptr %42, i32 %41
  %44 = load i32, ptr %43, align 4
  %45 = mul i32 %33, %44
  %46 = load i32, ptr %a1, align 4
  %47 = mul i32 %46, 3
  %48 = load ptr, ptr %e5, align 8
  %49 = getelementptr i1, ptr %48, i32 %47
  %50 = load i1, ptr %49, align 1
  %51 = load ptr, ptr %c3, align 8
  %52 = getelementptr i32, ptr %51, i32 2
  %53 = load i32, ptr %52, align 4
  %54 = getelementptr [2 x i32], ptr %z, i32 0, i32 %53
  %55 = load i32, ptr %54, align 4
  %56 = load ptr, ptr %e5, align 8
  %57 = getelementptr i1, ptr %56, i32 %55
  %58 = load i1, ptr %57, align 1
  %59 = and i1 %50, %58
  call void @def(i32 %45, i1 %59)
  %60 = load i32, ptr %a1, align 4
  %61 = load i32, ptr %a1, align 4
  %62 = getelementptr [2 x i32], ptr %z, i32 0, i32 %61
  %63 = load i32, ptr %62, align 4
  %64 = load ptr, ptr %c3, align 8
  %65 = getelementptr i32, ptr %64, i32 %63
  %66 = load i32, ptr %65, align 4
  %67 = getelementptr [2 x i32], ptr %z, i32 0, i32 %66
  %68 = load i32, ptr %67, align 4
  %69 = icmp sgt i32 %60, %68
  br i1 %69, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %70 = load i32, ptr %a1, align 4
  %71 = getelementptr [2 x i32], ptr %z, i32 0, i32 %70
  %72 = load i32, ptr %71, align 4
  %73 = load ptr, ptr %c3, align 8
  %74 = getelementptr i32, ptr %73, i32 %72
  %75 = load i32, ptr %74, align 4
  %76 = getelementptr [2 x i32], ptr %z, i32 0, i32 %75
  %77 = load i32, ptr %76, align 4
  ret i32 %77

if.merge:                                         ; preds = %if.else
  %78 = load i32, ptr %a1, align 4
  %79 = getelementptr [2 x i32], ptr %z, i32 0, i32 %78
  %80 = load i32, ptr %79, align 4
  %81 = load ptr, ptr %c3, align 8
  %82 = getelementptr i32, ptr %81, i32 %80
  %83 = load i32, ptr %82, align 4
  %84 = getelementptr [2 x i32], ptr %z, i32 0, i32 %83
  %85 = load i32, ptr %84, align 4
  store i32 %85, ptr %a1, align 4
  %86 = load i32, ptr %a1, align 4
  ret i32 %86

if.else:                                          ; preds = %entry
  br label %if.merge
}
