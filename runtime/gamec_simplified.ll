%struct.blr_size = type { i32, i32 }
%struct.blr_color = type { i32, i32, i32 }
%struct.gameboard = type { i8*, %struct.blr_size, %struct.blr_color, %struct.entity*, void(%struct.gameboard*)*, %struct.UT_hash_handle }
%struct.entity = type { i8*, %struct.blr_size, %struct.blr_pos, %struct.blr_color, void (%struct.entity*)*, %struct.entity*, %struct.UT_hash_handle }
%struct.blr_pos = type { i32, i32 }
%struct.UT_hash_handle = type { %struct.UT_hash_table*, i8*, i8*, %struct.UT_hash_handle*, %struct.UT_hash_handle*, i8*, i32, i32 }
%struct.UT_hash_table = type { %struct.UT_hash_bucket*, i32, i32, i32, %struct.UT_hash_handle*, i64, i32, i32, i32, i32, i32 }
%struct.UT_hash_bucket = type { %struct.UT_hash_handle*, i32, i32 }

@.str = private unnamed_addr constant [5 x i8] c"main\00", align 1

define void @main_init(%struct.gameboard*) {
  %2 = alloca %struct.gameboard*, align 8
  store %struct.gameboard* %0, %struct.gameboard** %2, align 8
  ret void
}

define %struct.gameboard* @main_create() {
  %1 = alloca %struct.gameboard*
  %2 = call i8* @malloc(i64 104)
  %3 = bitcast i8* %2 to %struct.gameboard*
  store %struct.gameboard* %3, %struct.gameboard** %1
  %4 = load %struct.gameboard*, %struct.gameboard** %1
  %5 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %4, i32 0, i32 0
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i32 0, i32 0), i8** %5
  %6 = load %struct.gameboard*, %struct.gameboard** %1
  %7 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %6, i32 0, i32 1
  store %struct.blr_size { i32 500, i32 500 }, %struct.blr_size* %7
  %8 = load %struct.gameboard*, %struct.gameboard** %1
  %9 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %8, i32 0, i32 2
  store %struct.blr_color { i32 0, i32 255, i32 255 }, %struct.blr_color* %9
  %10 = load %struct.gameboard*, %struct.gameboard** %1
  %11 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %10, i32 0, i32 3
  store %struct.entity* null, %struct.entity** %11
  %12 = load %struct.gameboard*, %struct.gameboard** %1
  %13 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %12, i32 0, i32 4
  store void (%struct.gameboard*)* @main_init, void (%struct.gameboard*)** %13
  %14 = load %struct.gameboard*, %struct.gameboard** %1
  call void @register_gb(%struct.gameboard* %14)
  %15 = load %struct.gameboard*, %struct.gameboard** %1
  ret %struct.gameboard* %15
}

declare i8* @malloc(i64)
declare void @register_gb(%struct.gameboard*)

define i32 @main() {
  %1 = call %struct.gameboard* @main_create()
  %2 = call i32 (...) @run_loop()
  ret i32 0
}

declare i32 @run_loop(...)
