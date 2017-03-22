%struct.gameboard = type { i8*, [2 x i32], [3 x i32], %struct.entity*, void (%struct.gameboard*)*, %struct.UT_hash_handle }
%struct.entity = type { i8*, [2 x i32], [2 x i32], [3 x i32], void (%struct.entity*)*, %struct.entity*, %struct.UT_hash_handle }
%struct.UT_hash_handle = type { %struct.UT_hash_table*, i8*, i8*, %struct.UT_hash_handle*, %struct.UT_hash_handle*, i8*, i32, i32 }
%struct.UT_hash_table = type { %struct.UT_hash_bucket*, i32, i32, i32, %struct.UT_hash_handle*, i64, i32, i32, i32, i32, i32 }
%struct.UT_hash_bucket = type { %struct.UT_hash_handle*, i32, i32 }

define void @gb_init(%struct.gameboard*, i8*, i32* nocapture readonly, i32* nocapture readonly, void (%struct.gameboard*)*)

define void game1_init(%struct.gameboard*) {
    %2 = call i8* malloc(i64 112)
    %3 = bitcast i8* %2 to %struct.entity*
    %4 = getelementptr inbounds %struct.entity, %struct.entity* %3, i64 0, i32 0
}

define void @main() {
    %1 = call i8* malloc(i64 104)
    %2 = bitcast i8* %1 to %struct.gameboard*
    
    call void @gb_init
}
