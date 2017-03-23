%struct.blr_size = type { i32, i32 }
%struct.blr_color = type { i32, i32, i32 }
%struct.gameboard = type { i8*, %struct.blr_size, %struct.blr_color, %struct.entity*, {}*, %struct.UT_hash_handle }
%struct.entity = type { i8*, %struct.blr_size, %struct.blr_pos, %struct.blr_color, void (%struct.entity*)*, %struct.entity*, %struct.UT_hash_handle }
%struct.blr_pos = type { i32, i32 }

%struct.UT_hash_handle = type { %struct.UT_hash_table*, i8*, i8*, %struct.UT_hash_handle*, %struct.UT_hash_handle*, i8*, i32, i32 }
%struct.UT_hash_table = type { %struct.UT_hash_bucket*, i32, i32, i32, %struct.UT_hash_handle*, i64, i32, i32, i32, i32, i32 }
%struct.UT_hash_bucket = type { %struct.UT_hash_handle*, i32, i32 }

@.str = private unnamed_addr constant [5 x i8] c"main\00", align 1

define void @game1_init(%struct.gameboard*) {
  %2 = alloca %struct.gameboard*
  store %struct.gameboard* %0, %struct.gameboard** %2
  ret void
}

define i32 @main() {
  %1 = alloca %struct.gameboard*
  %2 = alloca %struct.blr_size
  store %struct.blr_size { i32 500, i32 500 }, %struct.blr_size* %2
  %3 = alloca %struct.blr_color
  store %struct.blr_color { i32 0, i32 255, i32 255 }, %struct.blr_color* %3
  %4 = call i8* @malloc(i64 104)
  %5 = bitcast i8* %4 to %struct.gameboard*
  store %struct.gameboard* %5, %struct.gameboard** %1
  %6 = load %struct.gameboard*, %struct.gameboard** %1
  %7 = getelementptr inbounds [5 x i8], [5 x i8]* @.str, i32 0, i32 0
  %8 = getelementptr %struct.blr_size, %struct.blr_size* %2, i32 0
  %9 = getelementptr %struct.blr_color, %struct.blr_color * %3, i32 0
  call void @gb_init(%struct.gameboard* %6, i8* %7, %struct.blr_size* %2, %struct.blr_color* %3, void (%struct.gameboard*)* @game1_init)
  %10 = call i32 (...) @run_loop()
  ret i32 0
}

declare i8* @malloc(i64) #1
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1)
declare void @gb_init(%struct.gameboard*, i8*, %struct.blr_size*, %struct.blr_color*, void (%struct.gameboard*)*)
declare i32 @run_loop(...)
