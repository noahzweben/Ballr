; ModuleID = 'gamec.c'
source_filename = "gamec.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

%struct.blr_size = type { i32, i32 }
%struct.blr_color = type { i32, i32, i32 }
%struct.gameboard = type { i8*, %struct.blr_size, %struct.blr_color, %struct.entity*, {}*, %struct.UT_hash_handle }
%struct.entity = type { i8*, %struct.blr_size, %struct.blr_pos, %struct.blr_color, %struct.entity*, %struct.UT_hash_handle }
%struct.blr_pos = type { i32, i32 }
%struct.UT_hash_handle = type { %struct.UT_hash_table*, i8*, i8*, %struct.UT_hash_handle*, %struct.UT_hash_handle*, i8*, i32, i32 }
%struct.UT_hash_table = type { %struct.UT_hash_bucket*, i32, i32, i32, %struct.UT_hash_handle*, i64, i32, i32, i32, i32, i32 }
%struct.UT_hash_bucket = type { %struct.UT_hash_handle*, i32, i32 }

@x = global i32 5, align 4
@main.main_size = private unnamed_addr constant %struct.blr_size { i32 500, i32 500 }, align 4
@main.main_clr = private unnamed_addr constant %struct.blr_color { i32 0, i32 255, i32 255 }, align 4
@.str = private unnamed_addr constant [5 x i8] c"main\00", align 1

; Function Attrs: nounwind ssp uwtable
define void @game1_init(%struct.gameboard*) #0 {
  %2 = alloca %struct.gameboard*, align 8
  store %struct.gameboard* %0, %struct.gameboard** %2, align 8
  ret void
}

; Function Attrs: nounwind ssp uwtable
define i32 @main() #0 {
  %1 = alloca %struct.gameboard*, align 8
  %2 = alloca %struct.blr_size, align 4
  %3 = alloca %struct.blr_color, align 4
  %4 = alloca { i64, i32 }, align 4
  %5 = call i8* @malloc(i64 104)
  %6 = bitcast i8* %5 to %struct.gameboard*
  store %struct.gameboard* %6, %struct.gameboard** %1, align 8
  %7 = bitcast %struct.blr_size* %2 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %7, i8* bitcast (%struct.blr_size* @main.main_size to i8*), i64 8, i32 4, i1 false)
  %8 = bitcast %struct.blr_color* %3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %8, i8* bitcast (%struct.blr_color* @main.main_clr to i8*), i64 12, i32 4, i1 false)
  %9 = load %struct.gameboard*, %struct.gameboard** %1, align 8
  %10 = bitcast %struct.blr_size* %2 to i64*
  %11 = load i64, i64* %10, align 4
  %12 = bitcast { i64, i32 }* %4 to i8*
  %13 = bitcast %struct.blr_color* %3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %12, i8* %13, i64 12, i32 4, i1 false)
  %14 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %4, i32 0, i32 0
  %15 = load i64, i64* %14, align 4
  %16 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %4, i32 0, i32 1
  %17 = load i32, i32* %16, align 4
  call void @gb_init(%struct.gameboard* %9, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0), i64 %11, i64 %15, i32 %17, void (%struct.gameboard*)* @game1_init)
  %18 = call i32 (...) @run_loop()
  ret i32 0
}

declare i8* @malloc(i64) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #2

declare void @gb_init(%struct.gameboard*, i8*, i64, i64, i32, void (%struct.gameboard*)*) #1

declare i32 @run_loop(...) #1

attributes #0 = { nounwind ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+sse4.1,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+sse4.1,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { argmemonly nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"Apple LLVM version 8.0.0 (clang-800.0.42.1)"}
