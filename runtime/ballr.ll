; ModuleID = 'ballr.c'
source_filename = "ballr.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

%struct.gameboard = type { i8*, %struct.blr_size, %struct.blr_color, %struct.entity*, void (%struct.gameboard*)*, %struct.UT_hash_handle }
%struct.blr_size = type { i32, i32 }
%struct.blr_color = type { i32, i32, i32 }
%struct.entity = type { i8*, %struct.blr_size, %struct.blr_pos, %struct.blr_color, void (%struct.entity*)*, %struct.entity*, %struct.UT_hash_handle }
%struct.blr_pos = type { i32, i32 }
%struct.UT_hash_handle = type { %struct.UT_hash_table*, i8*, i8*, %struct.UT_hash_handle*, %struct.UT_hash_handle*, i8*, i32, i32 }
%struct.UT_hash_table = type { %struct.UT_hash_bucket*, i32, i32, i32, %struct.UT_hash_handle*, i64, i32, i32, i32, i32, i32 }
%struct.UT_hash_bucket = type { %struct.UT_hash_handle*, i32, i32 }

@current_board = external global %struct.gameboard*, align 8

; Function Attrs: nounwind ssp uwtable
define void @gb_init(%struct.gameboard*, i8*, i64, i64, i32, void (%struct.gameboard*)*) #0 {
  %7 = alloca %struct.blr_size, align 1
  %8 = alloca %struct.blr_color, align 1
  %9 = alloca { i64, i32 }, align 1
  %10 = alloca %struct.gameboard*, align 8
  %11 = alloca i8*, align 8
  %12 = alloca void (%struct.gameboard*)*, align 8
  %13 = bitcast %struct.blr_size* %7 to i64*
  store i64 %2, i64* %13, align 1
  %14 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %9, i32 0, i32 0
  store i64 %3, i64* %14, align 1
  %15 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %9, i32 0, i32 1
  store i32 %4, i32* %15, align 1
  %16 = bitcast %struct.blr_color* %8 to i8*
  %17 = bitcast { i64, i32 }* %9 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %16, i8* %17, i64 12, i32 1, i1 false)
  store %struct.gameboard* %0, %struct.gameboard** %10, align 8
  store i8* %1, i8** %11, align 8
  store void (%struct.gameboard*)* %5, void (%struct.gameboard*)** %12, align 8
  %18 = load i8*, i8** %11, align 8
  %19 = load %struct.gameboard*, %struct.gameboard** %10, align 8
  %20 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %19, i32 0, i32 0
  store i8* %18, i8** %20, align 8
  %21 = load %struct.gameboard*, %struct.gameboard** %10, align 8
  %22 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %21, i32 0, i32 1
  %23 = bitcast %struct.blr_size* %22 to i8*
  %24 = bitcast %struct.blr_size* %7 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %23, i8* %24, i64 8, i32 1, i1 false)
  %25 = load %struct.gameboard*, %struct.gameboard** %10, align 8
  %26 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %25, i32 0, i32 2
  %27 = bitcast %struct.blr_color* %26 to i8*
  %28 = bitcast %struct.blr_color* %8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %27, i8* %28, i64 12, i32 1, i1 false)
  %29 = load %struct.gameboard*, %struct.gameboard** %10, align 8
  %30 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %29, i32 0, i32 3
  store %struct.entity* null, %struct.entity** %30, align 8
  %31 = load void (%struct.gameboard*)*, void (%struct.gameboard*)** %12, align 8
  %32 = load %struct.gameboard*, %struct.gameboard** %10, align 8
  %33 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %32, i32 0, i32 4
  store void (%struct.gameboard*)* %31, void (%struct.gameboard*)** %33, align 8
  %34 = load %struct.gameboard*, %struct.gameboard** %10, align 8
  call void @register_gb(%struct.gameboard* %34)
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #1

declare void @register_gb(%struct.gameboard*) #2

; Function Attrs: nounwind ssp uwtable
define void @ent_add(%struct.gameboard*, %struct.entity*) #0 {
  %3 = alloca %struct.gameboard*, align 8
  %4 = alloca %struct.entity*, align 8
  %5 = alloca %struct.entity*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i8*, align 8
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i8*, align 8
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca %struct.UT_hash_handle*, align 8
  %21 = alloca %struct.UT_hash_handle*, align 8
  %22 = alloca %struct.UT_hash_bucket*, align 8
  %23 = alloca %struct.UT_hash_bucket*, align 8
  %24 = alloca %struct.entity*, align 8
  store %struct.gameboard* %0, %struct.gameboard** %3, align 8
  store %struct.entity* %1, %struct.entity** %4, align 8
  br label %25

; <label>:25                                      ; preds = %2
  br label %26

; <label>:26                                      ; preds = %25
  br label %27

; <label>:27                                      ; preds = %26
  %28 = load %struct.entity*, %struct.entity** %4, align 8
  %29 = getelementptr inbounds %struct.entity, %struct.entity* %28, i32 0, i32 0
  %30 = load i8*, i8** %29, align 8
  store i8* %30, i8** %10, align 8
  store i32 -17973521, i32* %6, align 4
  store i32 -1640531527, i32* %8, align 4
  store i32 -1640531527, i32* %7, align 4
  %31 = load %struct.entity*, %struct.entity** %4, align 8
  %32 = getelementptr inbounds %struct.entity, %struct.entity* %31, i32 0, i32 0
  %33 = load i8*, i8** %32, align 8
  %34 = call i64 @strlen(i8* %33)
  %35 = trunc i64 %34 to i32
  store i32 %35, i32* %9, align 4
  br label %36

; <label>:36                                      ; preds = %203, %27
  %37 = load i32, i32* %9, align 4
  %38 = icmp uge i32 %37, 12
  br i1 %38, label %39, label %208

; <label>:39                                      ; preds = %36
  %40 = load i8*, i8** %10, align 8
  %41 = getelementptr inbounds i8, i8* %40, i64 0
  %42 = load i8, i8* %41, align 1
  %43 = zext i8 %42 to i32
  %44 = load i8*, i8** %10, align 8
  %45 = getelementptr inbounds i8, i8* %44, i64 1
  %46 = load i8, i8* %45, align 1
  %47 = zext i8 %46 to i32
  %48 = shl i32 %47, 8
  %49 = add i32 %43, %48
  %50 = load i8*, i8** %10, align 8
  %51 = getelementptr inbounds i8, i8* %50, i64 2
  %52 = load i8, i8* %51, align 1
  %53 = zext i8 %52 to i32
  %54 = shl i32 %53, 16
  %55 = add i32 %49, %54
  %56 = load i8*, i8** %10, align 8
  %57 = getelementptr inbounds i8, i8* %56, i64 3
  %58 = load i8, i8* %57, align 1
  %59 = zext i8 %58 to i32
  %60 = shl i32 %59, 24
  %61 = add i32 %55, %60
  %62 = load i32, i32* %7, align 4
  %63 = add i32 %62, %61
  store i32 %63, i32* %7, align 4
  %64 = load i8*, i8** %10, align 8
  %65 = getelementptr inbounds i8, i8* %64, i64 4
  %66 = load i8, i8* %65, align 1
  %67 = zext i8 %66 to i32
  %68 = load i8*, i8** %10, align 8
  %69 = getelementptr inbounds i8, i8* %68, i64 5
  %70 = load i8, i8* %69, align 1
  %71 = zext i8 %70 to i32
  %72 = shl i32 %71, 8
  %73 = add i32 %67, %72
  %74 = load i8*, i8** %10, align 8
  %75 = getelementptr inbounds i8, i8* %74, i64 6
  %76 = load i8, i8* %75, align 1
  %77 = zext i8 %76 to i32
  %78 = shl i32 %77, 16
  %79 = add i32 %73, %78
  %80 = load i8*, i8** %10, align 8
  %81 = getelementptr inbounds i8, i8* %80, i64 7
  %82 = load i8, i8* %81, align 1
  %83 = zext i8 %82 to i32
  %84 = shl i32 %83, 24
  %85 = add i32 %79, %84
  %86 = load i32, i32* %8, align 4
  %87 = add i32 %86, %85
  store i32 %87, i32* %8, align 4
  %88 = load i8*, i8** %10, align 8
  %89 = getelementptr inbounds i8, i8* %88, i64 8
  %90 = load i8, i8* %89, align 1
  %91 = zext i8 %90 to i32
  %92 = load i8*, i8** %10, align 8
  %93 = getelementptr inbounds i8, i8* %92, i64 9
  %94 = load i8, i8* %93, align 1
  %95 = zext i8 %94 to i32
  %96 = shl i32 %95, 8
  %97 = add i32 %91, %96
  %98 = load i8*, i8** %10, align 8
  %99 = getelementptr inbounds i8, i8* %98, i64 10
  %100 = load i8, i8* %99, align 1
  %101 = zext i8 %100 to i32
  %102 = shl i32 %101, 16
  %103 = add i32 %97, %102
  %104 = load i8*, i8** %10, align 8
  %105 = getelementptr inbounds i8, i8* %104, i64 11
  %106 = load i8, i8* %105, align 1
  %107 = zext i8 %106 to i32
  %108 = shl i32 %107, 24
  %109 = add i32 %103, %108
  %110 = load i32, i32* %6, align 4
  %111 = add i32 %110, %109
  store i32 %111, i32* %6, align 4
  br label %112

; <label>:112                                     ; preds = %39
  %113 = load i32, i32* %8, align 4
  %114 = load i32, i32* %7, align 4
  %115 = sub i32 %114, %113
  store i32 %115, i32* %7, align 4
  %116 = load i32, i32* %6, align 4
  %117 = load i32, i32* %7, align 4
  %118 = sub i32 %117, %116
  store i32 %118, i32* %7, align 4
  %119 = load i32, i32* %6, align 4
  %120 = lshr i32 %119, 13
  %121 = load i32, i32* %7, align 4
  %122 = xor i32 %121, %120
  store i32 %122, i32* %7, align 4
  %123 = load i32, i32* %6, align 4
  %124 = load i32, i32* %8, align 4
  %125 = sub i32 %124, %123
  store i32 %125, i32* %8, align 4
  %126 = load i32, i32* %7, align 4
  %127 = load i32, i32* %8, align 4
  %128 = sub i32 %127, %126
  store i32 %128, i32* %8, align 4
  %129 = load i32, i32* %7, align 4
  %130 = shl i32 %129, 8
  %131 = load i32, i32* %8, align 4
  %132 = xor i32 %131, %130
  store i32 %132, i32* %8, align 4
  %133 = load i32, i32* %7, align 4
  %134 = load i32, i32* %6, align 4
  %135 = sub i32 %134, %133
  store i32 %135, i32* %6, align 4
  %136 = load i32, i32* %8, align 4
  %137 = load i32, i32* %6, align 4
  %138 = sub i32 %137, %136
  store i32 %138, i32* %6, align 4
  %139 = load i32, i32* %8, align 4
  %140 = lshr i32 %139, 13
  %141 = load i32, i32* %6, align 4
  %142 = xor i32 %141, %140
  store i32 %142, i32* %6, align 4
  %143 = load i32, i32* %8, align 4
  %144 = load i32, i32* %7, align 4
  %145 = sub i32 %144, %143
  store i32 %145, i32* %7, align 4
  %146 = load i32, i32* %6, align 4
  %147 = load i32, i32* %7, align 4
  %148 = sub i32 %147, %146
  store i32 %148, i32* %7, align 4
  %149 = load i32, i32* %6, align 4
  %150 = lshr i32 %149, 12
  %151 = load i32, i32* %7, align 4
  %152 = xor i32 %151, %150
  store i32 %152, i32* %7, align 4
  %153 = load i32, i32* %6, align 4
  %154 = load i32, i32* %8, align 4
  %155 = sub i32 %154, %153
  store i32 %155, i32* %8, align 4
  %156 = load i32, i32* %7, align 4
  %157 = load i32, i32* %8, align 4
  %158 = sub i32 %157, %156
  store i32 %158, i32* %8, align 4
  %159 = load i32, i32* %7, align 4
  %160 = shl i32 %159, 16
  %161 = load i32, i32* %8, align 4
  %162 = xor i32 %161, %160
  store i32 %162, i32* %8, align 4
  %163 = load i32, i32* %7, align 4
  %164 = load i32, i32* %6, align 4
  %165 = sub i32 %164, %163
  store i32 %165, i32* %6, align 4
  %166 = load i32, i32* %8, align 4
  %167 = load i32, i32* %6, align 4
  %168 = sub i32 %167, %166
  store i32 %168, i32* %6, align 4
  %169 = load i32, i32* %8, align 4
  %170 = lshr i32 %169, 5
  %171 = load i32, i32* %6, align 4
  %172 = xor i32 %171, %170
  store i32 %172, i32* %6, align 4
  %173 = load i32, i32* %8, align 4
  %174 = load i32, i32* %7, align 4
  %175 = sub i32 %174, %173
  store i32 %175, i32* %7, align 4
  %176 = load i32, i32* %6, align 4
  %177 = load i32, i32* %7, align 4
  %178 = sub i32 %177, %176
  store i32 %178, i32* %7, align 4
  %179 = load i32, i32* %6, align 4
  %180 = lshr i32 %179, 3
  %181 = load i32, i32* %7, align 4
  %182 = xor i32 %181, %180
  store i32 %182, i32* %7, align 4
  %183 = load i32, i32* %6, align 4
  %184 = load i32, i32* %8, align 4
  %185 = sub i32 %184, %183
  store i32 %185, i32* %8, align 4
  %186 = load i32, i32* %7, align 4
  %187 = load i32, i32* %8, align 4
  %188 = sub i32 %187, %186
  store i32 %188, i32* %8, align 4
  %189 = load i32, i32* %7, align 4
  %190 = shl i32 %189, 10
  %191 = load i32, i32* %8, align 4
  %192 = xor i32 %191, %190
  store i32 %192, i32* %8, align 4
  %193 = load i32, i32* %7, align 4
  %194 = load i32, i32* %6, align 4
  %195 = sub i32 %194, %193
  store i32 %195, i32* %6, align 4
  %196 = load i32, i32* %8, align 4
  %197 = load i32, i32* %6, align 4
  %198 = sub i32 %197, %196
  store i32 %198, i32* %6, align 4
  %199 = load i32, i32* %8, align 4
  %200 = lshr i32 %199, 15
  %201 = load i32, i32* %6, align 4
  %202 = xor i32 %201, %200
  store i32 %202, i32* %6, align 4
  br label %203

; <label>:203                                     ; preds = %112
  %204 = load i8*, i8** %10, align 8
  %205 = getelementptr inbounds i8, i8* %204, i64 12
  store i8* %205, i8** %10, align 8
  %206 = load i32, i32* %9, align 4
  %207 = sub i32 %206, 12
  store i32 %207, i32* %9, align 4
  br label %36

; <label>:208                                     ; preds = %36
  %209 = load %struct.entity*, %struct.entity** %4, align 8
  %210 = getelementptr inbounds %struct.entity, %struct.entity* %209, i32 0, i32 0
  %211 = load i8*, i8** %210, align 8
  %212 = call i64 @strlen(i8* %211)
  %213 = trunc i64 %212 to i32
  %214 = load i32, i32* %6, align 4
  %215 = add i32 %214, %213
  store i32 %215, i32* %6, align 4
  %216 = load i32, i32* %9, align 4
  switch i32 %216, label %303 [
    i32 11, label %217
    i32 10, label %225
    i32 9, label %233
    i32 8, label %241
    i32 7, label %249
    i32 6, label %257
    i32 5, label %265
    i32 4, label %272
    i32 3, label %280
    i32 2, label %288
    i32 1, label %296
  ]

; <label>:217                                     ; preds = %208
  %218 = load i8*, i8** %10, align 8
  %219 = getelementptr inbounds i8, i8* %218, i64 10
  %220 = load i8, i8* %219, align 1
  %221 = zext i8 %220 to i32
  %222 = shl i32 %221, 24
  %223 = load i32, i32* %6, align 4
  %224 = add i32 %223, %222
  store i32 %224, i32* %6, align 4
  br label %225

; <label>:225                                     ; preds = %208, %217
  %226 = load i8*, i8** %10, align 8
  %227 = getelementptr inbounds i8, i8* %226, i64 9
  %228 = load i8, i8* %227, align 1
  %229 = zext i8 %228 to i32
  %230 = shl i32 %229, 16
  %231 = load i32, i32* %6, align 4
  %232 = add i32 %231, %230
  store i32 %232, i32* %6, align 4
  br label %233

; <label>:233                                     ; preds = %208, %225
  %234 = load i8*, i8** %10, align 8
  %235 = getelementptr inbounds i8, i8* %234, i64 8
  %236 = load i8, i8* %235, align 1
  %237 = zext i8 %236 to i32
  %238 = shl i32 %237, 8
  %239 = load i32, i32* %6, align 4
  %240 = add i32 %239, %238
  store i32 %240, i32* %6, align 4
  br label %241

; <label>:241                                     ; preds = %208, %233
  %242 = load i8*, i8** %10, align 8
  %243 = getelementptr inbounds i8, i8* %242, i64 7
  %244 = load i8, i8* %243, align 1
  %245 = zext i8 %244 to i32
  %246 = shl i32 %245, 24
  %247 = load i32, i32* %8, align 4
  %248 = add i32 %247, %246
  store i32 %248, i32* %8, align 4
  br label %249

; <label>:249                                     ; preds = %208, %241
  %250 = load i8*, i8** %10, align 8
  %251 = getelementptr inbounds i8, i8* %250, i64 6
  %252 = load i8, i8* %251, align 1
  %253 = zext i8 %252 to i32
  %254 = shl i32 %253, 16
  %255 = load i32, i32* %8, align 4
  %256 = add i32 %255, %254
  store i32 %256, i32* %8, align 4
  br label %257

; <label>:257                                     ; preds = %208, %249
  %258 = load i8*, i8** %10, align 8
  %259 = getelementptr inbounds i8, i8* %258, i64 5
  %260 = load i8, i8* %259, align 1
  %261 = zext i8 %260 to i32
  %262 = shl i32 %261, 8
  %263 = load i32, i32* %8, align 4
  %264 = add i32 %263, %262
  store i32 %264, i32* %8, align 4
  br label %265

; <label>:265                                     ; preds = %208, %257
  %266 = load i8*, i8** %10, align 8
  %267 = getelementptr inbounds i8, i8* %266, i64 4
  %268 = load i8, i8* %267, align 1
  %269 = zext i8 %268 to i32
  %270 = load i32, i32* %8, align 4
  %271 = add i32 %270, %269
  store i32 %271, i32* %8, align 4
  br label %272

; <label>:272                                     ; preds = %208, %265
  %273 = load i8*, i8** %10, align 8
  %274 = getelementptr inbounds i8, i8* %273, i64 3
  %275 = load i8, i8* %274, align 1
  %276 = zext i8 %275 to i32
  %277 = shl i32 %276, 24
  %278 = load i32, i32* %7, align 4
  %279 = add i32 %278, %277
  store i32 %279, i32* %7, align 4
  br label %280

; <label>:280                                     ; preds = %208, %272
  %281 = load i8*, i8** %10, align 8
  %282 = getelementptr inbounds i8, i8* %281, i64 2
  %283 = load i8, i8* %282, align 1
  %284 = zext i8 %283 to i32
  %285 = shl i32 %284, 16
  %286 = load i32, i32* %7, align 4
  %287 = add i32 %286, %285
  store i32 %287, i32* %7, align 4
  br label %288

; <label>:288                                     ; preds = %208, %280
  %289 = load i8*, i8** %10, align 8
  %290 = getelementptr inbounds i8, i8* %289, i64 1
  %291 = load i8, i8* %290, align 1
  %292 = zext i8 %291 to i32
  %293 = shl i32 %292, 8
  %294 = load i32, i32* %7, align 4
  %295 = add i32 %294, %293
  store i32 %295, i32* %7, align 4
  br label %296

; <label>:296                                     ; preds = %208, %288
  %297 = load i8*, i8** %10, align 8
  %298 = getelementptr inbounds i8, i8* %297, i64 0
  %299 = load i8, i8* %298, align 1
  %300 = zext i8 %299 to i32
  %301 = load i32, i32* %7, align 4
  %302 = add i32 %301, %300
  store i32 %302, i32* %7, align 4
  br label %303

; <label>:303                                     ; preds = %296, %208
  br label %304

; <label>:304                                     ; preds = %303
  %305 = load i32, i32* %8, align 4
  %306 = load i32, i32* %7, align 4
  %307 = sub i32 %306, %305
  store i32 %307, i32* %7, align 4
  %308 = load i32, i32* %6, align 4
  %309 = load i32, i32* %7, align 4
  %310 = sub i32 %309, %308
  store i32 %310, i32* %7, align 4
  %311 = load i32, i32* %6, align 4
  %312 = lshr i32 %311, 13
  %313 = load i32, i32* %7, align 4
  %314 = xor i32 %313, %312
  store i32 %314, i32* %7, align 4
  %315 = load i32, i32* %6, align 4
  %316 = load i32, i32* %8, align 4
  %317 = sub i32 %316, %315
  store i32 %317, i32* %8, align 4
  %318 = load i32, i32* %7, align 4
  %319 = load i32, i32* %8, align 4
  %320 = sub i32 %319, %318
  store i32 %320, i32* %8, align 4
  %321 = load i32, i32* %7, align 4
  %322 = shl i32 %321, 8
  %323 = load i32, i32* %8, align 4
  %324 = xor i32 %323, %322
  store i32 %324, i32* %8, align 4
  %325 = load i32, i32* %7, align 4
  %326 = load i32, i32* %6, align 4
  %327 = sub i32 %326, %325
  store i32 %327, i32* %6, align 4
  %328 = load i32, i32* %8, align 4
  %329 = load i32, i32* %6, align 4
  %330 = sub i32 %329, %328
  store i32 %330, i32* %6, align 4
  %331 = load i32, i32* %8, align 4
  %332 = lshr i32 %331, 13
  %333 = load i32, i32* %6, align 4
  %334 = xor i32 %333, %332
  store i32 %334, i32* %6, align 4
  %335 = load i32, i32* %8, align 4
  %336 = load i32, i32* %7, align 4
  %337 = sub i32 %336, %335
  store i32 %337, i32* %7, align 4
  %338 = load i32, i32* %6, align 4
  %339 = load i32, i32* %7, align 4
  %340 = sub i32 %339, %338
  store i32 %340, i32* %7, align 4
  %341 = load i32, i32* %6, align 4
  %342 = lshr i32 %341, 12
  %343 = load i32, i32* %7, align 4
  %344 = xor i32 %343, %342
  store i32 %344, i32* %7, align 4
  %345 = load i32, i32* %6, align 4
  %346 = load i32, i32* %8, align 4
  %347 = sub i32 %346, %345
  store i32 %347, i32* %8, align 4
  %348 = load i32, i32* %7, align 4
  %349 = load i32, i32* %8, align 4
  %350 = sub i32 %349, %348
  store i32 %350, i32* %8, align 4
  %351 = load i32, i32* %7, align 4
  %352 = shl i32 %351, 16
  %353 = load i32, i32* %8, align 4
  %354 = xor i32 %353, %352
  store i32 %354, i32* %8, align 4
  %355 = load i32, i32* %7, align 4
  %356 = load i32, i32* %6, align 4
  %357 = sub i32 %356, %355
  store i32 %357, i32* %6, align 4
  %358 = load i32, i32* %8, align 4
  %359 = load i32, i32* %6, align 4
  %360 = sub i32 %359, %358
  store i32 %360, i32* %6, align 4
  %361 = load i32, i32* %8, align 4
  %362 = lshr i32 %361, 5
  %363 = load i32, i32* %6, align 4
  %364 = xor i32 %363, %362
  store i32 %364, i32* %6, align 4
  %365 = load i32, i32* %8, align 4
  %366 = load i32, i32* %7, align 4
  %367 = sub i32 %366, %365
  store i32 %367, i32* %7, align 4
  %368 = load i32, i32* %6, align 4
  %369 = load i32, i32* %7, align 4
  %370 = sub i32 %369, %368
  store i32 %370, i32* %7, align 4
  %371 = load i32, i32* %6, align 4
  %372 = lshr i32 %371, 3
  %373 = load i32, i32* %7, align 4
  %374 = xor i32 %373, %372
  store i32 %374, i32* %7, align 4
  %375 = load i32, i32* %6, align 4
  %376 = load i32, i32* %8, align 4
  %377 = sub i32 %376, %375
  store i32 %377, i32* %8, align 4
  %378 = load i32, i32* %7, align 4
  %379 = load i32, i32* %8, align 4
  %380 = sub i32 %379, %378
  store i32 %380, i32* %8, align 4
  %381 = load i32, i32* %7, align 4
  %382 = shl i32 %381, 10
  %383 = load i32, i32* %8, align 4
  %384 = xor i32 %383, %382
  store i32 %384, i32* %8, align 4
  %385 = load i32, i32* %7, align 4
  %386 = load i32, i32* %6, align 4
  %387 = sub i32 %386, %385
  store i32 %387, i32* %6, align 4
  %388 = load i32, i32* %8, align 4
  %389 = load i32, i32* %6, align 4
  %390 = sub i32 %389, %388
  store i32 %390, i32* %6, align 4
  %391 = load i32, i32* %8, align 4
  %392 = lshr i32 %391, 15
  %393 = load i32, i32* %6, align 4
  %394 = xor i32 %393, %392
  store i32 %394, i32* %6, align 4
  br label %395

; <label>:395                                     ; preds = %304
  br label %396

; <label>:396                                     ; preds = %395
  br label %397

; <label>:397                                     ; preds = %396
  br label %398

; <label>:398                                     ; preds = %397
  store %struct.entity* null, %struct.entity** %5, align 8
  %399 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %400 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %399, i32 0, i32 3
  %401 = load %struct.entity*, %struct.entity** %400, align 8
  %402 = icmp ne %struct.entity* %401, null
  br i1 %402, label %403, label %530

; <label>:403                                     ; preds = %398
  br label %404

; <label>:404                                     ; preds = %403
  %405 = load i32, i32* %6, align 4
  %406 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %407 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %406, i32 0, i32 3
  %408 = load %struct.entity*, %struct.entity** %407, align 8
  %409 = getelementptr inbounds %struct.entity, %struct.entity* %408, i32 0, i32 6
  %410 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %409, i32 0, i32 0
  %411 = load %struct.UT_hash_table*, %struct.UT_hash_table** %410, align 8
  %412 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %411, i32 0, i32 1
  %413 = load i32, i32* %412, align 8
  %414 = sub i32 %413, 1
  %415 = and i32 %405, %414
  store i32 %415, i32* %11, align 4
  br label %416

; <label>:416                                     ; preds = %404
  br label %417

; <label>:417                                     ; preds = %416
  %418 = load i32, i32* %11, align 4
  %419 = zext i32 %418 to i64
  %420 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %421 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %420, i32 0, i32 3
  %422 = load %struct.entity*, %struct.entity** %421, align 8
  %423 = getelementptr inbounds %struct.entity, %struct.entity* %422, i32 0, i32 6
  %424 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %423, i32 0, i32 0
  %425 = load %struct.UT_hash_table*, %struct.UT_hash_table** %424, align 8
  %426 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %425, i32 0, i32 0
  %427 = load %struct.UT_hash_bucket*, %struct.UT_hash_bucket** %426, align 8
  %428 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %427, i64 %419
  %429 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %428, i32 0, i32 0
  %430 = load %struct.UT_hash_handle*, %struct.UT_hash_handle** %429, align 8
  %431 = icmp ne %struct.UT_hash_handle* %430, null
  br i1 %431, label %432, label %460

; <label>:432                                     ; preds = %417
  br label %433

; <label>:433                                     ; preds = %432
  %434 = load i32, i32* %11, align 4
  %435 = zext i32 %434 to i64
  %436 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %437 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %436, i32 0, i32 3
  %438 = load %struct.entity*, %struct.entity** %437, align 8
  %439 = getelementptr inbounds %struct.entity, %struct.entity* %438, i32 0, i32 6
  %440 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %439, i32 0, i32 0
  %441 = load %struct.UT_hash_table*, %struct.UT_hash_table** %440, align 8
  %442 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %441, i32 0, i32 0
  %443 = load %struct.UT_hash_bucket*, %struct.UT_hash_bucket** %442, align 8
  %444 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %443, i64 %435
  %445 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %444, i32 0, i32 0
  %446 = load %struct.UT_hash_handle*, %struct.UT_hash_handle** %445, align 8
  %447 = bitcast %struct.UT_hash_handle* %446 to i8*
  %448 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %449 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %448, i32 0, i32 3
  %450 = load %struct.entity*, %struct.entity** %449, align 8
  %451 = getelementptr inbounds %struct.entity, %struct.entity* %450, i32 0, i32 6
  %452 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %451, i32 0, i32 0
  %453 = load %struct.UT_hash_table*, %struct.UT_hash_table** %452, align 8
  %454 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %453, i32 0, i32 5
  %455 = load i64, i64* %454, align 8
  %456 = sub i64 0, %455
  %457 = getelementptr inbounds i8, i8* %447, i64 %456
  %458 = bitcast i8* %457 to %struct.entity*
  store %struct.entity* %458, %struct.entity** %5, align 8
  br label %459

; <label>:459                                     ; preds = %433
  br label %461

; <label>:460                                     ; preds = %417
  store %struct.entity* null, %struct.entity** %5, align 8
  br label %461

; <label>:461                                     ; preds = %460, %459
  br label %462

; <label>:462                                     ; preds = %527, %461
  %463 = load %struct.entity*, %struct.entity** %5, align 8
  %464 = icmp ne %struct.entity* %463, null
  br i1 %464, label %465, label %528

; <label>:465                                     ; preds = %462
  %466 = load %struct.entity*, %struct.entity** %5, align 8
  %467 = getelementptr inbounds %struct.entity, %struct.entity* %466, i32 0, i32 6
  %468 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %467, i32 0, i32 7
  %469 = load i32, i32* %468, align 4
  %470 = load i32, i32* %6, align 4
  %471 = icmp eq i32 %469, %470
  br i1 %471, label %472, label %501

; <label>:472                                     ; preds = %465
  %473 = load %struct.entity*, %struct.entity** %5, align 8
  %474 = getelementptr inbounds %struct.entity, %struct.entity* %473, i32 0, i32 6
  %475 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %474, i32 0, i32 6
  %476 = load i32, i32* %475, align 8
  %477 = load %struct.entity*, %struct.entity** %4, align 8
  %478 = getelementptr inbounds %struct.entity, %struct.entity* %477, i32 0, i32 0
  %479 = load i8*, i8** %478, align 8
  %480 = call i64 @strlen(i8* %479)
  %481 = trunc i64 %480 to i32
  %482 = icmp eq i32 %476, %481
  br i1 %482, label %483, label %501

; <label>:483                                     ; preds = %472
  %484 = load %struct.entity*, %struct.entity** %5, align 8
  %485 = getelementptr inbounds %struct.entity, %struct.entity* %484, i32 0, i32 6
  %486 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %485, i32 0, i32 5
  %487 = load i8*, i8** %486, align 8
  %488 = load %struct.entity*, %struct.entity** %4, align 8
  %489 = getelementptr inbounds %struct.entity, %struct.entity* %488, i32 0, i32 0
  %490 = load i8*, i8** %489, align 8
  %491 = load %struct.entity*, %struct.entity** %4, align 8
  %492 = getelementptr inbounds %struct.entity, %struct.entity* %491, i32 0, i32 0
  %493 = load i8*, i8** %492, align 8
  %494 = call i64 @strlen(i8* %493)
  %495 = trunc i64 %494 to i32
  %496 = zext i32 %495 to i64
  %497 = call i32 @memcmp(i8* %487, i8* %490, i64 %496)
  %498 = icmp eq i32 %497, 0
  br i1 %498, label %499, label %500

; <label>:499                                     ; preds = %483
  br label %528

; <label>:500                                     ; preds = %483
  br label %501

; <label>:501                                     ; preds = %500, %472, %465
  %502 = load %struct.entity*, %struct.entity** %5, align 8
  %503 = getelementptr inbounds %struct.entity, %struct.entity* %502, i32 0, i32 6
  %504 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %503, i32 0, i32 4
  %505 = load %struct.UT_hash_handle*, %struct.UT_hash_handle** %504, align 8
  %506 = icmp ne %struct.UT_hash_handle* %505, null
  br i1 %506, label %507, label %526

; <label>:507                                     ; preds = %501
  br label %508

; <label>:508                                     ; preds = %507
  %509 = load %struct.entity*, %struct.entity** %5, align 8
  %510 = getelementptr inbounds %struct.entity, %struct.entity* %509, i32 0, i32 6
  %511 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %510, i32 0, i32 4
  %512 = load %struct.UT_hash_handle*, %struct.UT_hash_handle** %511, align 8
  %513 = bitcast %struct.UT_hash_handle* %512 to i8*
  %514 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %515 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %514, i32 0, i32 3
  %516 = load %struct.entity*, %struct.entity** %515, align 8
  %517 = getelementptr inbounds %struct.entity, %struct.entity* %516, i32 0, i32 6
  %518 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %517, i32 0, i32 0
  %519 = load %struct.UT_hash_table*, %struct.UT_hash_table** %518, align 8
  %520 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %519, i32 0, i32 5
  %521 = load i64, i64* %520, align 8
  %522 = sub i64 0, %521
  %523 = getelementptr inbounds i8, i8* %513, i64 %522
  %524 = bitcast i8* %523 to %struct.entity*
  store %struct.entity* %524, %struct.entity** %5, align 8
  br label %525

; <label>:525                                     ; preds = %508
  br label %527

; <label>:526                                     ; preds = %501
  store %struct.entity* null, %struct.entity** %5, align 8
  br label %527

; <label>:527                                     ; preds = %526, %525
  br label %462

; <label>:528                                     ; preds = %499, %462
  br label %529

; <label>:529                                     ; preds = %528
  br label %530

; <label>:530                                     ; preds = %529, %398
  br label %531

; <label>:531                                     ; preds = %530
  br label %532

; <label>:532                                     ; preds = %531
  %533 = load %struct.entity*, %struct.entity** %5, align 8
  %534 = icmp eq %struct.entity* %533, null
  br i1 %534, label %535, label %1528

; <label>:535                                     ; preds = %532
  %536 = call i8* @malloc(i64 112)
  %537 = bitcast i8* %536 to %struct.entity*
  store %struct.entity* %537, %struct.entity** %5, align 8
  %538 = load %struct.entity*, %struct.entity** %4, align 8
  %539 = getelementptr inbounds %struct.entity, %struct.entity* %538, i32 0, i32 0
  %540 = load i8*, i8** %539, align 8
  %541 = load %struct.entity*, %struct.entity** %5, align 8
  %542 = getelementptr inbounds %struct.entity, %struct.entity* %541, i32 0, i32 0
  store i8* %540, i8** %542, align 8
  br label %543

; <label>:543                                     ; preds = %535
  br label %544

; <label>:544                                     ; preds = %543
  br label %545

; <label>:545                                     ; preds = %544
  %546 = load %struct.entity*, %struct.entity** %5, align 8
  %547 = getelementptr inbounds %struct.entity, %struct.entity* %546, i32 0, i32 0
  %548 = load i8*, i8** %547, align 8
  %549 = getelementptr inbounds i8, i8* %548, i64 0
  store i8* %549, i8** %16, align 8
  store i32 -17973521, i32* %12, align 4
  store i32 -1640531527, i32* %14, align 4
  store i32 -1640531527, i32* %13, align 4
  %550 = load %struct.entity*, %struct.entity** %5, align 8
  %551 = getelementptr inbounds %struct.entity, %struct.entity* %550, i32 0, i32 0
  %552 = load i8*, i8** %551, align 8
  %553 = call i64 @strlen(i8* %552)
  %554 = trunc i64 %553 to i32
  store i32 %554, i32* %15, align 4
  br label %555

; <label>:555                                     ; preds = %722, %545
  %556 = load i32, i32* %15, align 4
  %557 = icmp uge i32 %556, 12
  br i1 %557, label %558, label %727

; <label>:558                                     ; preds = %555
  %559 = load i8*, i8** %16, align 8
  %560 = getelementptr inbounds i8, i8* %559, i64 0
  %561 = load i8, i8* %560, align 1
  %562 = zext i8 %561 to i32
  %563 = load i8*, i8** %16, align 8
  %564 = getelementptr inbounds i8, i8* %563, i64 1
  %565 = load i8, i8* %564, align 1
  %566 = zext i8 %565 to i32
  %567 = shl i32 %566, 8
  %568 = add i32 %562, %567
  %569 = load i8*, i8** %16, align 8
  %570 = getelementptr inbounds i8, i8* %569, i64 2
  %571 = load i8, i8* %570, align 1
  %572 = zext i8 %571 to i32
  %573 = shl i32 %572, 16
  %574 = add i32 %568, %573
  %575 = load i8*, i8** %16, align 8
  %576 = getelementptr inbounds i8, i8* %575, i64 3
  %577 = load i8, i8* %576, align 1
  %578 = zext i8 %577 to i32
  %579 = shl i32 %578, 24
  %580 = add i32 %574, %579
  %581 = load i32, i32* %13, align 4
  %582 = add i32 %581, %580
  store i32 %582, i32* %13, align 4
  %583 = load i8*, i8** %16, align 8
  %584 = getelementptr inbounds i8, i8* %583, i64 4
  %585 = load i8, i8* %584, align 1
  %586 = zext i8 %585 to i32
  %587 = load i8*, i8** %16, align 8
  %588 = getelementptr inbounds i8, i8* %587, i64 5
  %589 = load i8, i8* %588, align 1
  %590 = zext i8 %589 to i32
  %591 = shl i32 %590, 8
  %592 = add i32 %586, %591
  %593 = load i8*, i8** %16, align 8
  %594 = getelementptr inbounds i8, i8* %593, i64 6
  %595 = load i8, i8* %594, align 1
  %596 = zext i8 %595 to i32
  %597 = shl i32 %596, 16
  %598 = add i32 %592, %597
  %599 = load i8*, i8** %16, align 8
  %600 = getelementptr inbounds i8, i8* %599, i64 7
  %601 = load i8, i8* %600, align 1
  %602 = zext i8 %601 to i32
  %603 = shl i32 %602, 24
  %604 = add i32 %598, %603
  %605 = load i32, i32* %14, align 4
  %606 = add i32 %605, %604
  store i32 %606, i32* %14, align 4
  %607 = load i8*, i8** %16, align 8
  %608 = getelementptr inbounds i8, i8* %607, i64 8
  %609 = load i8, i8* %608, align 1
  %610 = zext i8 %609 to i32
  %611 = load i8*, i8** %16, align 8
  %612 = getelementptr inbounds i8, i8* %611, i64 9
  %613 = load i8, i8* %612, align 1
  %614 = zext i8 %613 to i32
  %615 = shl i32 %614, 8
  %616 = add i32 %610, %615
  %617 = load i8*, i8** %16, align 8
  %618 = getelementptr inbounds i8, i8* %617, i64 10
  %619 = load i8, i8* %618, align 1
  %620 = zext i8 %619 to i32
  %621 = shl i32 %620, 16
  %622 = add i32 %616, %621
  %623 = load i8*, i8** %16, align 8
  %624 = getelementptr inbounds i8, i8* %623, i64 11
  %625 = load i8, i8* %624, align 1
  %626 = zext i8 %625 to i32
  %627 = shl i32 %626, 24
  %628 = add i32 %622, %627
  %629 = load i32, i32* %12, align 4
  %630 = add i32 %629, %628
  store i32 %630, i32* %12, align 4
  br label %631

; <label>:631                                     ; preds = %558
  %632 = load i32, i32* %14, align 4
  %633 = load i32, i32* %13, align 4
  %634 = sub i32 %633, %632
  store i32 %634, i32* %13, align 4
  %635 = load i32, i32* %12, align 4
  %636 = load i32, i32* %13, align 4
  %637 = sub i32 %636, %635
  store i32 %637, i32* %13, align 4
  %638 = load i32, i32* %12, align 4
  %639 = lshr i32 %638, 13
  %640 = load i32, i32* %13, align 4
  %641 = xor i32 %640, %639
  store i32 %641, i32* %13, align 4
  %642 = load i32, i32* %12, align 4
  %643 = load i32, i32* %14, align 4
  %644 = sub i32 %643, %642
  store i32 %644, i32* %14, align 4
  %645 = load i32, i32* %13, align 4
  %646 = load i32, i32* %14, align 4
  %647 = sub i32 %646, %645
  store i32 %647, i32* %14, align 4
  %648 = load i32, i32* %13, align 4
  %649 = shl i32 %648, 8
  %650 = load i32, i32* %14, align 4
  %651 = xor i32 %650, %649
  store i32 %651, i32* %14, align 4
  %652 = load i32, i32* %13, align 4
  %653 = load i32, i32* %12, align 4
  %654 = sub i32 %653, %652
  store i32 %654, i32* %12, align 4
  %655 = load i32, i32* %14, align 4
  %656 = load i32, i32* %12, align 4
  %657 = sub i32 %656, %655
  store i32 %657, i32* %12, align 4
  %658 = load i32, i32* %14, align 4
  %659 = lshr i32 %658, 13
  %660 = load i32, i32* %12, align 4
  %661 = xor i32 %660, %659
  store i32 %661, i32* %12, align 4
  %662 = load i32, i32* %14, align 4
  %663 = load i32, i32* %13, align 4
  %664 = sub i32 %663, %662
  store i32 %664, i32* %13, align 4
  %665 = load i32, i32* %12, align 4
  %666 = load i32, i32* %13, align 4
  %667 = sub i32 %666, %665
  store i32 %667, i32* %13, align 4
  %668 = load i32, i32* %12, align 4
  %669 = lshr i32 %668, 12
  %670 = load i32, i32* %13, align 4
  %671 = xor i32 %670, %669
  store i32 %671, i32* %13, align 4
  %672 = load i32, i32* %12, align 4
  %673 = load i32, i32* %14, align 4
  %674 = sub i32 %673, %672
  store i32 %674, i32* %14, align 4
  %675 = load i32, i32* %13, align 4
  %676 = load i32, i32* %14, align 4
  %677 = sub i32 %676, %675
  store i32 %677, i32* %14, align 4
  %678 = load i32, i32* %13, align 4
  %679 = shl i32 %678, 16
  %680 = load i32, i32* %14, align 4
  %681 = xor i32 %680, %679
  store i32 %681, i32* %14, align 4
  %682 = load i32, i32* %13, align 4
  %683 = load i32, i32* %12, align 4
  %684 = sub i32 %683, %682
  store i32 %684, i32* %12, align 4
  %685 = load i32, i32* %14, align 4
  %686 = load i32, i32* %12, align 4
  %687 = sub i32 %686, %685
  store i32 %687, i32* %12, align 4
  %688 = load i32, i32* %14, align 4
  %689 = lshr i32 %688, 5
  %690 = load i32, i32* %12, align 4
  %691 = xor i32 %690, %689
  store i32 %691, i32* %12, align 4
  %692 = load i32, i32* %14, align 4
  %693 = load i32, i32* %13, align 4
  %694 = sub i32 %693, %692
  store i32 %694, i32* %13, align 4
  %695 = load i32, i32* %12, align 4
  %696 = load i32, i32* %13, align 4
  %697 = sub i32 %696, %695
  store i32 %697, i32* %13, align 4
  %698 = load i32, i32* %12, align 4
  %699 = lshr i32 %698, 3
  %700 = load i32, i32* %13, align 4
  %701 = xor i32 %700, %699
  store i32 %701, i32* %13, align 4
  %702 = load i32, i32* %12, align 4
  %703 = load i32, i32* %14, align 4
  %704 = sub i32 %703, %702
  store i32 %704, i32* %14, align 4
  %705 = load i32, i32* %13, align 4
  %706 = load i32, i32* %14, align 4
  %707 = sub i32 %706, %705
  store i32 %707, i32* %14, align 4
  %708 = load i32, i32* %13, align 4
  %709 = shl i32 %708, 10
  %710 = load i32, i32* %14, align 4
  %711 = xor i32 %710, %709
  store i32 %711, i32* %14, align 4
  %712 = load i32, i32* %13, align 4
  %713 = load i32, i32* %12, align 4
  %714 = sub i32 %713, %712
  store i32 %714, i32* %12, align 4
  %715 = load i32, i32* %14, align 4
  %716 = load i32, i32* %12, align 4
  %717 = sub i32 %716, %715
  store i32 %717, i32* %12, align 4
  %718 = load i32, i32* %14, align 4
  %719 = lshr i32 %718, 15
  %720 = load i32, i32* %12, align 4
  %721 = xor i32 %720, %719
  store i32 %721, i32* %12, align 4
  br label %722

; <label>:722                                     ; preds = %631
  %723 = load i8*, i8** %16, align 8
  %724 = getelementptr inbounds i8, i8* %723, i64 12
  store i8* %724, i8** %16, align 8
  %725 = load i32, i32* %15, align 4
  %726 = sub i32 %725, 12
  store i32 %726, i32* %15, align 4
  br label %555

; <label>:727                                     ; preds = %555
  %728 = load %struct.entity*, %struct.entity** %5, align 8
  %729 = getelementptr inbounds %struct.entity, %struct.entity* %728, i32 0, i32 0
  %730 = load i8*, i8** %729, align 8
  %731 = call i64 @strlen(i8* %730)
  %732 = trunc i64 %731 to i32
  %733 = load i32, i32* %12, align 4
  %734 = add i32 %733, %732
  store i32 %734, i32* %12, align 4
  %735 = load i32, i32* %15, align 4
  switch i32 %735, label %822 [
    i32 11, label %736
    i32 10, label %744
    i32 9, label %752
    i32 8, label %760
    i32 7, label %768
    i32 6, label %776
    i32 5, label %784
    i32 4, label %791
    i32 3, label %799
    i32 2, label %807
    i32 1, label %815
  ]

; <label>:736                                     ; preds = %727
  %737 = load i8*, i8** %16, align 8
  %738 = getelementptr inbounds i8, i8* %737, i64 10
  %739 = load i8, i8* %738, align 1
  %740 = zext i8 %739 to i32
  %741 = shl i32 %740, 24
  %742 = load i32, i32* %12, align 4
  %743 = add i32 %742, %741
  store i32 %743, i32* %12, align 4
  br label %744

; <label>:744                                     ; preds = %727, %736
  %745 = load i8*, i8** %16, align 8
  %746 = getelementptr inbounds i8, i8* %745, i64 9
  %747 = load i8, i8* %746, align 1
  %748 = zext i8 %747 to i32
  %749 = shl i32 %748, 16
  %750 = load i32, i32* %12, align 4
  %751 = add i32 %750, %749
  store i32 %751, i32* %12, align 4
  br label %752

; <label>:752                                     ; preds = %727, %744
  %753 = load i8*, i8** %16, align 8
  %754 = getelementptr inbounds i8, i8* %753, i64 8
  %755 = load i8, i8* %754, align 1
  %756 = zext i8 %755 to i32
  %757 = shl i32 %756, 8
  %758 = load i32, i32* %12, align 4
  %759 = add i32 %758, %757
  store i32 %759, i32* %12, align 4
  br label %760

; <label>:760                                     ; preds = %727, %752
  %761 = load i8*, i8** %16, align 8
  %762 = getelementptr inbounds i8, i8* %761, i64 7
  %763 = load i8, i8* %762, align 1
  %764 = zext i8 %763 to i32
  %765 = shl i32 %764, 24
  %766 = load i32, i32* %14, align 4
  %767 = add i32 %766, %765
  store i32 %767, i32* %14, align 4
  br label %768

; <label>:768                                     ; preds = %727, %760
  %769 = load i8*, i8** %16, align 8
  %770 = getelementptr inbounds i8, i8* %769, i64 6
  %771 = load i8, i8* %770, align 1
  %772 = zext i8 %771 to i32
  %773 = shl i32 %772, 16
  %774 = load i32, i32* %14, align 4
  %775 = add i32 %774, %773
  store i32 %775, i32* %14, align 4
  br label %776

; <label>:776                                     ; preds = %727, %768
  %777 = load i8*, i8** %16, align 8
  %778 = getelementptr inbounds i8, i8* %777, i64 5
  %779 = load i8, i8* %778, align 1
  %780 = zext i8 %779 to i32
  %781 = shl i32 %780, 8
  %782 = load i32, i32* %14, align 4
  %783 = add i32 %782, %781
  store i32 %783, i32* %14, align 4
  br label %784

; <label>:784                                     ; preds = %727, %776
  %785 = load i8*, i8** %16, align 8
  %786 = getelementptr inbounds i8, i8* %785, i64 4
  %787 = load i8, i8* %786, align 1
  %788 = zext i8 %787 to i32
  %789 = load i32, i32* %14, align 4
  %790 = add i32 %789, %788
  store i32 %790, i32* %14, align 4
  br label %791

; <label>:791                                     ; preds = %727, %784
  %792 = load i8*, i8** %16, align 8
  %793 = getelementptr inbounds i8, i8* %792, i64 3
  %794 = load i8, i8* %793, align 1
  %795 = zext i8 %794 to i32
  %796 = shl i32 %795, 24
  %797 = load i32, i32* %13, align 4
  %798 = add i32 %797, %796
  store i32 %798, i32* %13, align 4
  br label %799

; <label>:799                                     ; preds = %727, %791
  %800 = load i8*, i8** %16, align 8
  %801 = getelementptr inbounds i8, i8* %800, i64 2
  %802 = load i8, i8* %801, align 1
  %803 = zext i8 %802 to i32
  %804 = shl i32 %803, 16
  %805 = load i32, i32* %13, align 4
  %806 = add i32 %805, %804
  store i32 %806, i32* %13, align 4
  br label %807

; <label>:807                                     ; preds = %727, %799
  %808 = load i8*, i8** %16, align 8
  %809 = getelementptr inbounds i8, i8* %808, i64 1
  %810 = load i8, i8* %809, align 1
  %811 = zext i8 %810 to i32
  %812 = shl i32 %811, 8
  %813 = load i32, i32* %13, align 4
  %814 = add i32 %813, %812
  store i32 %814, i32* %13, align 4
  br label %815

; <label>:815                                     ; preds = %727, %807
  %816 = load i8*, i8** %16, align 8
  %817 = getelementptr inbounds i8, i8* %816, i64 0
  %818 = load i8, i8* %817, align 1
  %819 = zext i8 %818 to i32
  %820 = load i32, i32* %13, align 4
  %821 = add i32 %820, %819
  store i32 %821, i32* %13, align 4
  br label %822

; <label>:822                                     ; preds = %815, %727
  br label %823

; <label>:823                                     ; preds = %822
  %824 = load i32, i32* %14, align 4
  %825 = load i32, i32* %13, align 4
  %826 = sub i32 %825, %824
  store i32 %826, i32* %13, align 4
  %827 = load i32, i32* %12, align 4
  %828 = load i32, i32* %13, align 4
  %829 = sub i32 %828, %827
  store i32 %829, i32* %13, align 4
  %830 = load i32, i32* %12, align 4
  %831 = lshr i32 %830, 13
  %832 = load i32, i32* %13, align 4
  %833 = xor i32 %832, %831
  store i32 %833, i32* %13, align 4
  %834 = load i32, i32* %12, align 4
  %835 = load i32, i32* %14, align 4
  %836 = sub i32 %835, %834
  store i32 %836, i32* %14, align 4
  %837 = load i32, i32* %13, align 4
  %838 = load i32, i32* %14, align 4
  %839 = sub i32 %838, %837
  store i32 %839, i32* %14, align 4
  %840 = load i32, i32* %13, align 4
  %841 = shl i32 %840, 8
  %842 = load i32, i32* %14, align 4
  %843 = xor i32 %842, %841
  store i32 %843, i32* %14, align 4
  %844 = load i32, i32* %13, align 4
  %845 = load i32, i32* %12, align 4
  %846 = sub i32 %845, %844
  store i32 %846, i32* %12, align 4
  %847 = load i32, i32* %14, align 4
  %848 = load i32, i32* %12, align 4
  %849 = sub i32 %848, %847
  store i32 %849, i32* %12, align 4
  %850 = load i32, i32* %14, align 4
  %851 = lshr i32 %850, 13
  %852 = load i32, i32* %12, align 4
  %853 = xor i32 %852, %851
  store i32 %853, i32* %12, align 4
  %854 = load i32, i32* %14, align 4
  %855 = load i32, i32* %13, align 4
  %856 = sub i32 %855, %854
  store i32 %856, i32* %13, align 4
  %857 = load i32, i32* %12, align 4
  %858 = load i32, i32* %13, align 4
  %859 = sub i32 %858, %857
  store i32 %859, i32* %13, align 4
  %860 = load i32, i32* %12, align 4
  %861 = lshr i32 %860, 12
  %862 = load i32, i32* %13, align 4
  %863 = xor i32 %862, %861
  store i32 %863, i32* %13, align 4
  %864 = load i32, i32* %12, align 4
  %865 = load i32, i32* %14, align 4
  %866 = sub i32 %865, %864
  store i32 %866, i32* %14, align 4
  %867 = load i32, i32* %13, align 4
  %868 = load i32, i32* %14, align 4
  %869 = sub i32 %868, %867
  store i32 %869, i32* %14, align 4
  %870 = load i32, i32* %13, align 4
  %871 = shl i32 %870, 16
  %872 = load i32, i32* %14, align 4
  %873 = xor i32 %872, %871
  store i32 %873, i32* %14, align 4
  %874 = load i32, i32* %13, align 4
  %875 = load i32, i32* %12, align 4
  %876 = sub i32 %875, %874
  store i32 %876, i32* %12, align 4
  %877 = load i32, i32* %14, align 4
  %878 = load i32, i32* %12, align 4
  %879 = sub i32 %878, %877
  store i32 %879, i32* %12, align 4
  %880 = load i32, i32* %14, align 4
  %881 = lshr i32 %880, 5
  %882 = load i32, i32* %12, align 4
  %883 = xor i32 %882, %881
  store i32 %883, i32* %12, align 4
  %884 = load i32, i32* %14, align 4
  %885 = load i32, i32* %13, align 4
  %886 = sub i32 %885, %884
  store i32 %886, i32* %13, align 4
  %887 = load i32, i32* %12, align 4
  %888 = load i32, i32* %13, align 4
  %889 = sub i32 %888, %887
  store i32 %889, i32* %13, align 4
  %890 = load i32, i32* %12, align 4
  %891 = lshr i32 %890, 3
  %892 = load i32, i32* %13, align 4
  %893 = xor i32 %892, %891
  store i32 %893, i32* %13, align 4
  %894 = load i32, i32* %12, align 4
  %895 = load i32, i32* %14, align 4
  %896 = sub i32 %895, %894
  store i32 %896, i32* %14, align 4
  %897 = load i32, i32* %13, align 4
  %898 = load i32, i32* %14, align 4
  %899 = sub i32 %898, %897
  store i32 %899, i32* %14, align 4
  %900 = load i32, i32* %13, align 4
  %901 = shl i32 %900, 10
  %902 = load i32, i32* %14, align 4
  %903 = xor i32 %902, %901
  store i32 %903, i32* %14, align 4
  %904 = load i32, i32* %13, align 4
  %905 = load i32, i32* %12, align 4
  %906 = sub i32 %905, %904
  store i32 %906, i32* %12, align 4
  %907 = load i32, i32* %14, align 4
  %908 = load i32, i32* %12, align 4
  %909 = sub i32 %908, %907
  store i32 %909, i32* %12, align 4
  %910 = load i32, i32* %14, align 4
  %911 = lshr i32 %910, 15
  %912 = load i32, i32* %12, align 4
  %913 = xor i32 %912, %911
  store i32 %913, i32* %12, align 4
  br label %914

; <label>:914                                     ; preds = %823
  br label %915

; <label>:915                                     ; preds = %914
  br label %916

; <label>:916                                     ; preds = %915
  br label %917

; <label>:917                                     ; preds = %916
  %918 = load i32, i32* %12, align 4
  %919 = load %struct.entity*, %struct.entity** %5, align 8
  %920 = getelementptr inbounds %struct.entity, %struct.entity* %919, i32 0, i32 6
  %921 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %920, i32 0, i32 7
  store i32 %918, i32* %921, align 4
  %922 = load %struct.entity*, %struct.entity** %5, align 8
  %923 = getelementptr inbounds %struct.entity, %struct.entity* %922, i32 0, i32 0
  %924 = load i8*, i8** %923, align 8
  %925 = getelementptr inbounds i8, i8* %924, i64 0
  %926 = load %struct.entity*, %struct.entity** %5, align 8
  %927 = getelementptr inbounds %struct.entity, %struct.entity* %926, i32 0, i32 6
  %928 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %927, i32 0, i32 5
  store i8* %925, i8** %928, align 8
  %929 = load %struct.entity*, %struct.entity** %5, align 8
  %930 = getelementptr inbounds %struct.entity, %struct.entity* %929, i32 0, i32 0
  %931 = load i8*, i8** %930, align 8
  %932 = call i64 @strlen(i8* %931)
  %933 = trunc i64 %932 to i32
  %934 = load %struct.entity*, %struct.entity** %5, align 8
  %935 = getelementptr inbounds %struct.entity, %struct.entity* %934, i32 0, i32 6
  %936 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %935, i32 0, i32 6
  store i32 %933, i32* %936, align 8
  %937 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %938 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %937, i32 0, i32 3
  %939 = load %struct.entity*, %struct.entity** %938, align 8
  %940 = icmp ne %struct.entity* %939, null
  br i1 %940, label %1076, label %941

; <label>:941                                     ; preds = %917
  %942 = load %struct.entity*, %struct.entity** %5, align 8
  %943 = getelementptr inbounds %struct.entity, %struct.entity* %942, i32 0, i32 6
  %944 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %943, i32 0, i32 2
  store i8* null, i8** %944, align 8
  %945 = load %struct.entity*, %struct.entity** %5, align 8
  %946 = getelementptr inbounds %struct.entity, %struct.entity* %945, i32 0, i32 6
  %947 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %946, i32 0, i32 1
  store i8* null, i8** %947, align 8
  %948 = load %struct.entity*, %struct.entity** %5, align 8
  %949 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %950 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %949, i32 0, i32 3
  store %struct.entity* %948, %struct.entity** %950, align 8
  br label %951

; <label>:951                                     ; preds = %941
  %952 = call i8* @malloc(i64 64)
  %953 = bitcast i8* %952 to %struct.UT_hash_table*
  %954 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %955 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %954, i32 0, i32 3
  %956 = load %struct.entity*, %struct.entity** %955, align 8
  %957 = getelementptr inbounds %struct.entity, %struct.entity* %956, i32 0, i32 6
  %958 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %957, i32 0, i32 0
  store %struct.UT_hash_table* %953, %struct.UT_hash_table** %958, align 8
  %959 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %960 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %959, i32 0, i32 3
  %961 = load %struct.entity*, %struct.entity** %960, align 8
  %962 = getelementptr inbounds %struct.entity, %struct.entity* %961, i32 0, i32 6
  %963 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %962, i32 0, i32 0
  %964 = load %struct.UT_hash_table*, %struct.UT_hash_table** %963, align 8
  %965 = icmp ne %struct.UT_hash_table* %964, null
  br i1 %965, label %967, label %966

; <label>:966                                     ; preds = %951
  call void @exit(i32 -1) #6
  unreachable

; <label>:967                                     ; preds = %951
  %968 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %969 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %968, i32 0, i32 3
  %970 = load %struct.entity*, %struct.entity** %969, align 8
  %971 = getelementptr inbounds %struct.entity, %struct.entity* %970, i32 0, i32 6
  %972 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %971, i32 0, i32 0
  %973 = load %struct.UT_hash_table*, %struct.UT_hash_table** %972, align 8
  %974 = bitcast %struct.UT_hash_table* %973 to i8*
  %975 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %976 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %975, i32 0, i32 3
  %977 = load %struct.entity*, %struct.entity** %976, align 8
  %978 = getelementptr inbounds %struct.entity, %struct.entity* %977, i32 0, i32 6
  %979 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %978, i32 0, i32 0
  %980 = load %struct.UT_hash_table*, %struct.UT_hash_table** %979, align 8
  %981 = bitcast %struct.UT_hash_table* %980 to i8*
  %982 = call i64 @llvm.objectsize.i64.p0i8(i8* %981, i1 false)
  %983 = call i8* @__memset_chk(i8* %974, i32 0, i64 64, i64 %982) #7
  %984 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %985 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %984, i32 0, i32 3
  %986 = load %struct.entity*, %struct.entity** %985, align 8
  %987 = getelementptr inbounds %struct.entity, %struct.entity* %986, i32 0, i32 6
  %988 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %989 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %988, i32 0, i32 3
  %990 = load %struct.entity*, %struct.entity** %989, align 8
  %991 = getelementptr inbounds %struct.entity, %struct.entity* %990, i32 0, i32 6
  %992 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %991, i32 0, i32 0
  %993 = load %struct.UT_hash_table*, %struct.UT_hash_table** %992, align 8
  %994 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %993, i32 0, i32 4
  store %struct.UT_hash_handle* %987, %struct.UT_hash_handle** %994, align 8
  %995 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %996 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %995, i32 0, i32 3
  %997 = load %struct.entity*, %struct.entity** %996, align 8
  %998 = getelementptr inbounds %struct.entity, %struct.entity* %997, i32 0, i32 6
  %999 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %998, i32 0, i32 0
  %1000 = load %struct.UT_hash_table*, %struct.UT_hash_table** %999, align 8
  %1001 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1000, i32 0, i32 1
  store i32 32, i32* %1001, align 8
  %1002 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %1003 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %1002, i32 0, i32 3
  %1004 = load %struct.entity*, %struct.entity** %1003, align 8
  %1005 = getelementptr inbounds %struct.entity, %struct.entity* %1004, i32 0, i32 6
  %1006 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1005, i32 0, i32 0
  %1007 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1006, align 8
  %1008 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1007, i32 0, i32 2
  store i32 5, i32* %1008, align 4
  %1009 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %1010 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %1009, i32 0, i32 3
  %1011 = load %struct.entity*, %struct.entity** %1010, align 8
  %1012 = getelementptr inbounds %struct.entity, %struct.entity* %1011, i32 0, i32 6
  %1013 = bitcast %struct.UT_hash_handle* %1012 to i8*
  %1014 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %1015 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %1014, i32 0, i32 3
  %1016 = load %struct.entity*, %struct.entity** %1015, align 8
  %1017 = bitcast %struct.entity* %1016 to i8*
  %1018 = ptrtoint i8* %1013 to i64
  %1019 = ptrtoint i8* %1017 to i64
  %1020 = sub i64 %1018, %1019
  %1021 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %1022 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %1021, i32 0, i32 3
  %1023 = load %struct.entity*, %struct.entity** %1022, align 8
  %1024 = getelementptr inbounds %struct.entity, %struct.entity* %1023, i32 0, i32 6
  %1025 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1024, i32 0, i32 0
  %1026 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1025, align 8
  %1027 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1026, i32 0, i32 5
  store i64 %1020, i64* %1027, align 8
  %1028 = call i8* @malloc(i64 512)
  %1029 = bitcast i8* %1028 to %struct.UT_hash_bucket*
  %1030 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %1031 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %1030, i32 0, i32 3
  %1032 = load %struct.entity*, %struct.entity** %1031, align 8
  %1033 = getelementptr inbounds %struct.entity, %struct.entity* %1032, i32 0, i32 6
  %1034 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1033, i32 0, i32 0
  %1035 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1034, align 8
  %1036 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1035, i32 0, i32 0
  store %struct.UT_hash_bucket* %1029, %struct.UT_hash_bucket** %1036, align 8
  %1037 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %1038 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %1037, i32 0, i32 3
  %1039 = load %struct.entity*, %struct.entity** %1038, align 8
  %1040 = getelementptr inbounds %struct.entity, %struct.entity* %1039, i32 0, i32 6
  %1041 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1040, i32 0, i32 0
  %1042 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1041, align 8
  %1043 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1042, i32 0, i32 0
  %1044 = load %struct.UT_hash_bucket*, %struct.UT_hash_bucket** %1043, align 8
  %1045 = icmp ne %struct.UT_hash_bucket* %1044, null
  br i1 %1045, label %1047, label %1046

; <label>:1046                                    ; preds = %967
  call void @exit(i32 -1) #6
  unreachable

; <label>:1047                                    ; preds = %967
  %1048 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %1049 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %1048, i32 0, i32 3
  %1050 = load %struct.entity*, %struct.entity** %1049, align 8
  %1051 = getelementptr inbounds %struct.entity, %struct.entity* %1050, i32 0, i32 6
  %1052 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1051, i32 0, i32 0
  %1053 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1052, align 8
  %1054 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1053, i32 0, i32 0
  %1055 = load %struct.UT_hash_bucket*, %struct.UT_hash_bucket** %1054, align 8
  %1056 = bitcast %struct.UT_hash_bucket* %1055 to i8*
  %1057 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %1058 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %1057, i32 0, i32 3
  %1059 = load %struct.entity*, %struct.entity** %1058, align 8
  %1060 = getelementptr inbounds %struct.entity, %struct.entity* %1059, i32 0, i32 6
  %1061 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1060, i32 0, i32 0
  %1062 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1061, align 8
  %1063 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1062, i32 0, i32 0
  %1064 = load %struct.UT_hash_bucket*, %struct.UT_hash_bucket** %1063, align 8
  %1065 = bitcast %struct.UT_hash_bucket* %1064 to i8*
  %1066 = call i64 @llvm.objectsize.i64.p0i8(i8* %1065, i1 false)
  %1067 = call i8* @__memset_chk(i8* %1056, i32 0, i64 512, i64 %1066) #7
  %1068 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %1069 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %1068, i32 0, i32 3
  %1070 = load %struct.entity*, %struct.entity** %1069, align 8
  %1071 = getelementptr inbounds %struct.entity, %struct.entity* %1070, i32 0, i32 6
  %1072 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1071, i32 0, i32 0
  %1073 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1072, align 8
  %1074 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1073, i32 0, i32 10
  store i32 -1609490463, i32* %1074, align 8
  br label %1075

; <label>:1075                                    ; preds = %1047
  br label %1133

; <label>:1076                                    ; preds = %917
  %1077 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %1078 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %1077, i32 0, i32 3
  %1079 = load %struct.entity*, %struct.entity** %1078, align 8
  %1080 = getelementptr inbounds %struct.entity, %struct.entity* %1079, i32 0, i32 6
  %1081 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1080, i32 0, i32 0
  %1082 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1081, align 8
  %1083 = load %struct.entity*, %struct.entity** %5, align 8
  %1084 = getelementptr inbounds %struct.entity, %struct.entity* %1083, i32 0, i32 6
  %1085 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1084, i32 0, i32 0
  store %struct.UT_hash_table* %1082, %struct.UT_hash_table** %1085, align 8
  br label %1086

; <label>:1086                                    ; preds = %1076
  %1087 = load %struct.entity*, %struct.entity** %5, align 8
  %1088 = getelementptr inbounds %struct.entity, %struct.entity* %1087, i32 0, i32 6
  %1089 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1088, i32 0, i32 2
  store i8* null, i8** %1089, align 8
  %1090 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %1091 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %1090, i32 0, i32 3
  %1092 = load %struct.entity*, %struct.entity** %1091, align 8
  %1093 = getelementptr inbounds %struct.entity, %struct.entity* %1092, i32 0, i32 6
  %1094 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1093, i32 0, i32 0
  %1095 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1094, align 8
  %1096 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1095, i32 0, i32 4
  %1097 = load %struct.UT_hash_handle*, %struct.UT_hash_handle** %1096, align 8
  %1098 = bitcast %struct.UT_hash_handle* %1097 to i8*
  %1099 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %1100 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %1099, i32 0, i32 3
  %1101 = load %struct.entity*, %struct.entity** %1100, align 8
  %1102 = getelementptr inbounds %struct.entity, %struct.entity* %1101, i32 0, i32 6
  %1103 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1102, i32 0, i32 0
  %1104 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1103, align 8
  %1105 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1104, i32 0, i32 5
  %1106 = load i64, i64* %1105, align 8
  %1107 = sub i64 0, %1106
  %1108 = getelementptr inbounds i8, i8* %1098, i64 %1107
  %1109 = load %struct.entity*, %struct.entity** %5, align 8
  %1110 = getelementptr inbounds %struct.entity, %struct.entity* %1109, i32 0, i32 6
  %1111 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1110, i32 0, i32 1
  store i8* %1108, i8** %1111, align 8
  %1112 = load %struct.entity*, %struct.entity** %5, align 8
  %1113 = bitcast %struct.entity* %1112 to i8*
  %1114 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %1115 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %1114, i32 0, i32 3
  %1116 = load %struct.entity*, %struct.entity** %1115, align 8
  %1117 = getelementptr inbounds %struct.entity, %struct.entity* %1116, i32 0, i32 6
  %1118 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1117, i32 0, i32 0
  %1119 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1118, align 8
  %1120 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1119, i32 0, i32 4
  %1121 = load %struct.UT_hash_handle*, %struct.UT_hash_handle** %1120, align 8
  %1122 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1121, i32 0, i32 2
  store i8* %1113, i8** %1122, align 8
  %1123 = load %struct.entity*, %struct.entity** %5, align 8
  %1124 = getelementptr inbounds %struct.entity, %struct.entity* %1123, i32 0, i32 6
  %1125 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %1126 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %1125, i32 0, i32 3
  %1127 = load %struct.entity*, %struct.entity** %1126, align 8
  %1128 = getelementptr inbounds %struct.entity, %struct.entity* %1127, i32 0, i32 6
  %1129 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1128, i32 0, i32 0
  %1130 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1129, align 8
  %1131 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1130, i32 0, i32 4
  store %struct.UT_hash_handle* %1124, %struct.UT_hash_handle** %1131, align 8
  br label %1132

; <label>:1132                                    ; preds = %1086
  br label %1133

; <label>:1133                                    ; preds = %1132, %1075
  %1134 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %1135 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %1134, i32 0, i32 3
  %1136 = load %struct.entity*, %struct.entity** %1135, align 8
  %1137 = getelementptr inbounds %struct.entity, %struct.entity* %1136, i32 0, i32 6
  %1138 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1137, i32 0, i32 0
  %1139 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1138, align 8
  %1140 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1139, i32 0, i32 3
  %1141 = load i32, i32* %1140, align 8
  %1142 = add i32 %1141, 1
  store i32 %1142, i32* %1140, align 8
  br label %1143

; <label>:1143                                    ; preds = %1133
  %1144 = load i32, i32* %12, align 4
  %1145 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %1146 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %1145, i32 0, i32 3
  %1147 = load %struct.entity*, %struct.entity** %1146, align 8
  %1148 = getelementptr inbounds %struct.entity, %struct.entity* %1147, i32 0, i32 6
  %1149 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1148, i32 0, i32 0
  %1150 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1149, align 8
  %1151 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1150, i32 0, i32 1
  %1152 = load i32, i32* %1151, align 8
  %1153 = sub i32 %1152, 1
  %1154 = and i32 %1144, %1153
  store i32 %1154, i32* %17, align 4
  br label %1155

; <label>:1155                                    ; preds = %1143
  br label %1156

; <label>:1156                                    ; preds = %1155
  %1157 = load i32, i32* %17, align 4
  %1158 = zext i32 %1157 to i64
  %1159 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %1160 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %1159, i32 0, i32 3
  %1161 = load %struct.entity*, %struct.entity** %1160, align 8
  %1162 = getelementptr inbounds %struct.entity, %struct.entity* %1161, i32 0, i32 6
  %1163 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1162, i32 0, i32 0
  %1164 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1163, align 8
  %1165 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1164, i32 0, i32 0
  %1166 = load %struct.UT_hash_bucket*, %struct.UT_hash_bucket** %1165, align 8
  %1167 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %1166, i64 %1158
  %1168 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %1167, i32 0, i32 1
  %1169 = load i32, i32* %1168, align 8
  %1170 = add i32 %1169, 1
  store i32 %1170, i32* %1168, align 8
  %1171 = load i32, i32* %17, align 4
  %1172 = zext i32 %1171 to i64
  %1173 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %1174 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %1173, i32 0, i32 3
  %1175 = load %struct.entity*, %struct.entity** %1174, align 8
  %1176 = getelementptr inbounds %struct.entity, %struct.entity* %1175, i32 0, i32 6
  %1177 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1176, i32 0, i32 0
  %1178 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1177, align 8
  %1179 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1178, i32 0, i32 0
  %1180 = load %struct.UT_hash_bucket*, %struct.UT_hash_bucket** %1179, align 8
  %1181 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %1180, i64 %1172
  %1182 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %1181, i32 0, i32 0
  %1183 = load %struct.UT_hash_handle*, %struct.UT_hash_handle** %1182, align 8
  %1184 = load %struct.entity*, %struct.entity** %5, align 8
  %1185 = getelementptr inbounds %struct.entity, %struct.entity* %1184, i32 0, i32 6
  %1186 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1185, i32 0, i32 4
  store %struct.UT_hash_handle* %1183, %struct.UT_hash_handle** %1186, align 8
  %1187 = load %struct.entity*, %struct.entity** %5, align 8
  %1188 = getelementptr inbounds %struct.entity, %struct.entity* %1187, i32 0, i32 6
  %1189 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1188, i32 0, i32 3
  store %struct.UT_hash_handle* null, %struct.UT_hash_handle** %1189, align 8
  %1190 = load i32, i32* %17, align 4
  %1191 = zext i32 %1190 to i64
  %1192 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %1193 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %1192, i32 0, i32 3
  %1194 = load %struct.entity*, %struct.entity** %1193, align 8
  %1195 = getelementptr inbounds %struct.entity, %struct.entity* %1194, i32 0, i32 6
  %1196 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1195, i32 0, i32 0
  %1197 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1196, align 8
  %1198 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1197, i32 0, i32 0
  %1199 = load %struct.UT_hash_bucket*, %struct.UT_hash_bucket** %1198, align 8
  %1200 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %1199, i64 %1191
  %1201 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %1200, i32 0, i32 0
  %1202 = load %struct.UT_hash_handle*, %struct.UT_hash_handle** %1201, align 8
  %1203 = icmp ne %struct.UT_hash_handle* %1202, null
  br i1 %1203, label %1204, label %1221

; <label>:1204                                    ; preds = %1156
  %1205 = load %struct.entity*, %struct.entity** %5, align 8
  %1206 = getelementptr inbounds %struct.entity, %struct.entity* %1205, i32 0, i32 6
  %1207 = load i32, i32* %17, align 4
  %1208 = zext i32 %1207 to i64
  %1209 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %1210 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %1209, i32 0, i32 3
  %1211 = load %struct.entity*, %struct.entity** %1210, align 8
  %1212 = getelementptr inbounds %struct.entity, %struct.entity* %1211, i32 0, i32 6
  %1213 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1212, i32 0, i32 0
  %1214 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1213, align 8
  %1215 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1214, i32 0, i32 0
  %1216 = load %struct.UT_hash_bucket*, %struct.UT_hash_bucket** %1215, align 8
  %1217 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %1216, i64 %1208
  %1218 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %1217, i32 0, i32 0
  %1219 = load %struct.UT_hash_handle*, %struct.UT_hash_handle** %1218, align 8
  %1220 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1219, i32 0, i32 3
  store %struct.UT_hash_handle* %1206, %struct.UT_hash_handle** %1220, align 8
  br label %1221

; <label>:1221                                    ; preds = %1204, %1156
  %1222 = load %struct.entity*, %struct.entity** %5, align 8
  %1223 = getelementptr inbounds %struct.entity, %struct.entity* %1222, i32 0, i32 6
  %1224 = load i32, i32* %17, align 4
  %1225 = zext i32 %1224 to i64
  %1226 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %1227 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %1226, i32 0, i32 3
  %1228 = load %struct.entity*, %struct.entity** %1227, align 8
  %1229 = getelementptr inbounds %struct.entity, %struct.entity* %1228, i32 0, i32 6
  %1230 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1229, i32 0, i32 0
  %1231 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1230, align 8
  %1232 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1231, i32 0, i32 0
  %1233 = load %struct.UT_hash_bucket*, %struct.UT_hash_bucket** %1232, align 8
  %1234 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %1233, i64 %1225
  %1235 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %1234, i32 0, i32 0
  store %struct.UT_hash_handle* %1223, %struct.UT_hash_handle** %1235, align 8
  %1236 = load i32, i32* %17, align 4
  %1237 = zext i32 %1236 to i64
  %1238 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %1239 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %1238, i32 0, i32 3
  %1240 = load %struct.entity*, %struct.entity** %1239, align 8
  %1241 = getelementptr inbounds %struct.entity, %struct.entity* %1240, i32 0, i32 6
  %1242 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1241, i32 0, i32 0
  %1243 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1242, align 8
  %1244 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1243, i32 0, i32 0
  %1245 = load %struct.UT_hash_bucket*, %struct.UT_hash_bucket** %1244, align 8
  %1246 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %1245, i64 %1237
  %1247 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %1246, i32 0, i32 1
  %1248 = load i32, i32* %1247, align 8
  %1249 = load i32, i32* %17, align 4
  %1250 = zext i32 %1249 to i64
  %1251 = load %struct.gameboard*, %struct.gameboard** %3, align 8
  %1252 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %1251, i32 0, i32 3
  %1253 = load %struct.entity*, %struct.entity** %1252, align 8
  %1254 = getelementptr inbounds %struct.entity, %struct.entity* %1253, i32 0, i32 6
  %1255 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1254, i32 0, i32 0
  %1256 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1255, align 8
  %1257 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1256, i32 0, i32 0
  %1258 = load %struct.UT_hash_bucket*, %struct.UT_hash_bucket** %1257, align 8
  %1259 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %1258, i64 %1250
  %1260 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %1259, i32 0, i32 2
  %1261 = load i32, i32* %1260, align 4
  %1262 = add i32 %1261, 1
  %1263 = mul i32 %1262, 10
  %1264 = icmp uge i32 %1248, %1263
  br i1 %1264, label %1265, label %1524

; <label>:1265                                    ; preds = %1221
  %1266 = load %struct.entity*, %struct.entity** %5, align 8
  %1267 = getelementptr inbounds %struct.entity, %struct.entity* %1266, i32 0, i32 6
  %1268 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1267, i32 0, i32 0
  %1269 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1268, align 8
  %1270 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1269, i32 0, i32 9
  %1271 = load i32, i32* %1270, align 4
  %1272 = icmp ne i32 %1271, 1
  br i1 %1272, label %1273, label %1524

; <label>:1273                                    ; preds = %1265
  br label %1274

; <label>:1274                                    ; preds = %1273
  %1275 = load %struct.entity*, %struct.entity** %5, align 8
  %1276 = getelementptr inbounds %struct.entity, %struct.entity* %1275, i32 0, i32 6
  %1277 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1276, i32 0, i32 0
  %1278 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1277, align 8
  %1279 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1278, i32 0, i32 1
  %1280 = load i32, i32* %1279, align 8
  %1281 = zext i32 %1280 to i64
  %1282 = mul i64 2, %1281
  %1283 = mul i64 %1282, 16
  %1284 = call i8* @malloc(i64 %1283)
  %1285 = bitcast i8* %1284 to %struct.UT_hash_bucket*
  store %struct.UT_hash_bucket* %1285, %struct.UT_hash_bucket** %22, align 8
  %1286 = load %struct.UT_hash_bucket*, %struct.UT_hash_bucket** %22, align 8
  %1287 = icmp ne %struct.UT_hash_bucket* %1286, null
  br i1 %1287, label %1289, label %1288

; <label>:1288                                    ; preds = %1274
  call void @exit(i32 -1) #6
  unreachable

; <label>:1289                                    ; preds = %1274
  %1290 = load %struct.UT_hash_bucket*, %struct.UT_hash_bucket** %22, align 8
  %1291 = bitcast %struct.UT_hash_bucket* %1290 to i8*
  %1292 = load %struct.entity*, %struct.entity** %5, align 8
  %1293 = getelementptr inbounds %struct.entity, %struct.entity* %1292, i32 0, i32 6
  %1294 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1293, i32 0, i32 0
  %1295 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1294, align 8
  %1296 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1295, i32 0, i32 1
  %1297 = load i32, i32* %1296, align 8
  %1298 = zext i32 %1297 to i64
  %1299 = mul i64 2, %1298
  %1300 = mul i64 %1299, 16
  %1301 = load %struct.UT_hash_bucket*, %struct.UT_hash_bucket** %22, align 8
  %1302 = bitcast %struct.UT_hash_bucket* %1301 to i8*
  %1303 = call i64 @llvm.objectsize.i64.p0i8(i8* %1302, i1 false)
  %1304 = call i8* @__memset_chk(i8* %1291, i32 0, i64 %1300, i64 %1303) #7
  %1305 = load %struct.entity*, %struct.entity** %5, align 8
  %1306 = getelementptr inbounds %struct.entity, %struct.entity* %1305, i32 0, i32 6
  %1307 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1306, i32 0, i32 0
  %1308 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1307, align 8
  %1309 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1308, i32 0, i32 3
  %1310 = load i32, i32* %1309, align 8
  %1311 = load %struct.entity*, %struct.entity** %5, align 8
  %1312 = getelementptr inbounds %struct.entity, %struct.entity* %1311, i32 0, i32 6
  %1313 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1312, i32 0, i32 0
  %1314 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1313, align 8
  %1315 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1314, i32 0, i32 2
  %1316 = load i32, i32* %1315, align 4
  %1317 = add i32 %1316, 1
  %1318 = lshr i32 %1310, %1317
  %1319 = load %struct.entity*, %struct.entity** %5, align 8
  %1320 = getelementptr inbounds %struct.entity, %struct.entity* %1319, i32 0, i32 6
  %1321 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1320, i32 0, i32 0
  %1322 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1321, align 8
  %1323 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1322, i32 0, i32 3
  %1324 = load i32, i32* %1323, align 8
  %1325 = load %struct.entity*, %struct.entity** %5, align 8
  %1326 = getelementptr inbounds %struct.entity, %struct.entity* %1325, i32 0, i32 6
  %1327 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1326, i32 0, i32 0
  %1328 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1327, align 8
  %1329 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1328, i32 0, i32 1
  %1330 = load i32, i32* %1329, align 8
  %1331 = mul i32 %1330, 2
  %1332 = sub i32 %1331, 1
  %1333 = and i32 %1324, %1332
  %1334 = icmp ne i32 %1333, 0
  %1335 = select i1 %1334, i32 1, i32 0
  %1336 = add i32 %1318, %1335
  %1337 = load %struct.entity*, %struct.entity** %5, align 8
  %1338 = getelementptr inbounds %struct.entity, %struct.entity* %1337, i32 0, i32 6
  %1339 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1338, i32 0, i32 0
  %1340 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1339, align 8
  %1341 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1340, i32 0, i32 6
  store i32 %1336, i32* %1341, align 8
  %1342 = load %struct.entity*, %struct.entity** %5, align 8
  %1343 = getelementptr inbounds %struct.entity, %struct.entity* %1342, i32 0, i32 6
  %1344 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1343, i32 0, i32 0
  %1345 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1344, align 8
  %1346 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1345, i32 0, i32 7
  store i32 0, i32* %1346, align 4
  store i32 0, i32* %19, align 4
  br label %1347

; <label>:1347                                    ; preds = %1448, %1289
  %1348 = load i32, i32* %19, align 4
  %1349 = load %struct.entity*, %struct.entity** %5, align 8
  %1350 = getelementptr inbounds %struct.entity, %struct.entity* %1349, i32 0, i32 6
  %1351 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1350, i32 0, i32 0
  %1352 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1351, align 8
  %1353 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1352, i32 0, i32 1
  %1354 = load i32, i32* %1353, align 8
  %1355 = icmp ult i32 %1348, %1354
  br i1 %1355, label %1356, label %1451

; <label>:1356                                    ; preds = %1347
  %1357 = load i32, i32* %19, align 4
  %1358 = zext i32 %1357 to i64
  %1359 = load %struct.entity*, %struct.entity** %5, align 8
  %1360 = getelementptr inbounds %struct.entity, %struct.entity* %1359, i32 0, i32 6
  %1361 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1360, i32 0, i32 0
  %1362 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1361, align 8
  %1363 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1362, i32 0, i32 0
  %1364 = load %struct.UT_hash_bucket*, %struct.UT_hash_bucket** %1363, align 8
  %1365 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %1364, i64 %1358
  %1366 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %1365, i32 0, i32 0
  %1367 = load %struct.UT_hash_handle*, %struct.UT_hash_handle** %1366, align 8
  store %struct.UT_hash_handle* %1367, %struct.UT_hash_handle** %20, align 8
  br label %1368

; <label>:1368                                    ; preds = %1442, %1356
  %1369 = load %struct.UT_hash_handle*, %struct.UT_hash_handle** %20, align 8
  %1370 = icmp ne %struct.UT_hash_handle* %1369, null
  br i1 %1370, label %1371, label %1447

; <label>:1371                                    ; preds = %1368
  %1372 = load %struct.UT_hash_handle*, %struct.UT_hash_handle** %20, align 8
  %1373 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1372, i32 0, i32 4
  %1374 = load %struct.UT_hash_handle*, %struct.UT_hash_handle** %1373, align 8
  store %struct.UT_hash_handle* %1374, %struct.UT_hash_handle** %21, align 8
  br label %1375

; <label>:1375                                    ; preds = %1371
  %1376 = load %struct.UT_hash_handle*, %struct.UT_hash_handle** %20, align 8
  %1377 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1376, i32 0, i32 7
  %1378 = load i32, i32* %1377, align 4
  %1379 = load %struct.entity*, %struct.entity** %5, align 8
  %1380 = getelementptr inbounds %struct.entity, %struct.entity* %1379, i32 0, i32 6
  %1381 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1380, i32 0, i32 0
  %1382 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1381, align 8
  %1383 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1382, i32 0, i32 1
  %1384 = load i32, i32* %1383, align 8
  %1385 = mul i32 %1384, 2
  %1386 = sub i32 %1385, 1
  %1387 = and i32 %1378, %1386
  store i32 %1387, i32* %18, align 4
  br label %1388

; <label>:1388                                    ; preds = %1375
  %1389 = load i32, i32* %18, align 4
  %1390 = zext i32 %1389 to i64
  %1391 = load %struct.UT_hash_bucket*, %struct.UT_hash_bucket** %22, align 8
  %1392 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %1391, i64 %1390
  store %struct.UT_hash_bucket* %1392, %struct.UT_hash_bucket** %23, align 8
  %1393 = load %struct.UT_hash_bucket*, %struct.UT_hash_bucket** %23, align 8
  %1394 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %1393, i32 0, i32 1
  %1395 = load i32, i32* %1394, align 8
  %1396 = add i32 %1395, 1
  store i32 %1396, i32* %1394, align 8
  %1397 = load %struct.entity*, %struct.entity** %5, align 8
  %1398 = getelementptr inbounds %struct.entity, %struct.entity* %1397, i32 0, i32 6
  %1399 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1398, i32 0, i32 0
  %1400 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1399, align 8
  %1401 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1400, i32 0, i32 6
  %1402 = load i32, i32* %1401, align 8
  %1403 = icmp ugt i32 %1396, %1402
  br i1 %1403, label %1404, label %1424

; <label>:1404                                    ; preds = %1388
  %1405 = load %struct.entity*, %struct.entity** %5, align 8
  %1406 = getelementptr inbounds %struct.entity, %struct.entity* %1405, i32 0, i32 6
  %1407 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1406, i32 0, i32 0
  %1408 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1407, align 8
  %1409 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1408, i32 0, i32 7
  %1410 = load i32, i32* %1409, align 4
  %1411 = add i32 %1410, 1
  store i32 %1411, i32* %1409, align 4
  %1412 = load %struct.UT_hash_bucket*, %struct.UT_hash_bucket** %23, align 8
  %1413 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %1412, i32 0, i32 1
  %1414 = load i32, i32* %1413, align 8
  %1415 = load %struct.entity*, %struct.entity** %5, align 8
  %1416 = getelementptr inbounds %struct.entity, %struct.entity* %1415, i32 0, i32 6
  %1417 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1416, i32 0, i32 0
  %1418 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1417, align 8
  %1419 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1418, i32 0, i32 6
  %1420 = load i32, i32* %1419, align 8
  %1421 = udiv i32 %1414, %1420
  %1422 = load %struct.UT_hash_bucket*, %struct.UT_hash_bucket** %23, align 8
  %1423 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %1422, i32 0, i32 2
  store i32 %1421, i32* %1423, align 4
  br label %1424

; <label>:1424                                    ; preds = %1404, %1388
  %1425 = load %struct.UT_hash_handle*, %struct.UT_hash_handle** %20, align 8
  %1426 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1425, i32 0, i32 3
  store %struct.UT_hash_handle* null, %struct.UT_hash_handle** %1426, align 8
  %1427 = load %struct.UT_hash_bucket*, %struct.UT_hash_bucket** %23, align 8
  %1428 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %1427, i32 0, i32 0
  %1429 = load %struct.UT_hash_handle*, %struct.UT_hash_handle** %1428, align 8
  %1430 = load %struct.UT_hash_handle*, %struct.UT_hash_handle** %20, align 8
  %1431 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1430, i32 0, i32 4
  store %struct.UT_hash_handle* %1429, %struct.UT_hash_handle** %1431, align 8
  %1432 = load %struct.UT_hash_bucket*, %struct.UT_hash_bucket** %23, align 8
  %1433 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %1432, i32 0, i32 0
  %1434 = load %struct.UT_hash_handle*, %struct.UT_hash_handle** %1433, align 8
  %1435 = icmp ne %struct.UT_hash_handle* %1434, null
  br i1 %1435, label %1436, label %1442

; <label>:1436                                    ; preds = %1424
  %1437 = load %struct.UT_hash_handle*, %struct.UT_hash_handle** %20, align 8
  %1438 = load %struct.UT_hash_bucket*, %struct.UT_hash_bucket** %23, align 8
  %1439 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %1438, i32 0, i32 0
  %1440 = load %struct.UT_hash_handle*, %struct.UT_hash_handle** %1439, align 8
  %1441 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1440, i32 0, i32 3
  store %struct.UT_hash_handle* %1437, %struct.UT_hash_handle** %1441, align 8
  br label %1442

; <label>:1442                                    ; preds = %1436, %1424
  %1443 = load %struct.UT_hash_handle*, %struct.UT_hash_handle** %20, align 8
  %1444 = load %struct.UT_hash_bucket*, %struct.UT_hash_bucket** %23, align 8
  %1445 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %1444, i32 0, i32 0
  store %struct.UT_hash_handle* %1443, %struct.UT_hash_handle** %1445, align 8
  %1446 = load %struct.UT_hash_handle*, %struct.UT_hash_handle** %21, align 8
  store %struct.UT_hash_handle* %1446, %struct.UT_hash_handle** %20, align 8
  br label %1368

; <label>:1447                                    ; preds = %1368
  br label %1448

; <label>:1448                                    ; preds = %1447
  %1449 = load i32, i32* %19, align 4
  %1450 = add i32 %1449, 1
  store i32 %1450, i32* %19, align 4
  br label %1347

; <label>:1451                                    ; preds = %1347
  %1452 = load %struct.entity*, %struct.entity** %5, align 8
  %1453 = getelementptr inbounds %struct.entity, %struct.entity* %1452, i32 0, i32 6
  %1454 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1453, i32 0, i32 0
  %1455 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1454, align 8
  %1456 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1455, i32 0, i32 0
  %1457 = load %struct.UT_hash_bucket*, %struct.UT_hash_bucket** %1456, align 8
  %1458 = bitcast %struct.UT_hash_bucket* %1457 to i8*
  call void @free(i8* %1458)
  %1459 = load %struct.entity*, %struct.entity** %5, align 8
  %1460 = getelementptr inbounds %struct.entity, %struct.entity* %1459, i32 0, i32 6
  %1461 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1460, i32 0, i32 0
  %1462 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1461, align 8
  %1463 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1462, i32 0, i32 1
  %1464 = load i32, i32* %1463, align 8
  %1465 = mul i32 %1464, 2
  store i32 %1465, i32* %1463, align 8
  %1466 = load %struct.entity*, %struct.entity** %5, align 8
  %1467 = getelementptr inbounds %struct.entity, %struct.entity* %1466, i32 0, i32 6
  %1468 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1467, i32 0, i32 0
  %1469 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1468, align 8
  %1470 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1469, i32 0, i32 2
  %1471 = load i32, i32* %1470, align 4
  %1472 = add i32 %1471, 1
  store i32 %1472, i32* %1470, align 4
  %1473 = load %struct.UT_hash_bucket*, %struct.UT_hash_bucket** %22, align 8
  %1474 = load %struct.entity*, %struct.entity** %5, align 8
  %1475 = getelementptr inbounds %struct.entity, %struct.entity* %1474, i32 0, i32 6
  %1476 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1475, i32 0, i32 0
  %1477 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1476, align 8
  %1478 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1477, i32 0, i32 0
  store %struct.UT_hash_bucket* %1473, %struct.UT_hash_bucket** %1478, align 8
  %1479 = load %struct.entity*, %struct.entity** %5, align 8
  %1480 = getelementptr inbounds %struct.entity, %struct.entity* %1479, i32 0, i32 6
  %1481 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1480, i32 0, i32 0
  %1482 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1481, align 8
  %1483 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1482, i32 0, i32 7
  %1484 = load i32, i32* %1483, align 4
  %1485 = load %struct.entity*, %struct.entity** %5, align 8
  %1486 = getelementptr inbounds %struct.entity, %struct.entity* %1485, i32 0, i32 6
  %1487 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1486, i32 0, i32 0
  %1488 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1487, align 8
  %1489 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1488, i32 0, i32 3
  %1490 = load i32, i32* %1489, align 8
  %1491 = lshr i32 %1490, 1
  %1492 = icmp ugt i32 %1484, %1491
  br i1 %1492, label %1493, label %1501

; <label>:1493                                    ; preds = %1451
  %1494 = load %struct.entity*, %struct.entity** %5, align 8
  %1495 = getelementptr inbounds %struct.entity, %struct.entity* %1494, i32 0, i32 6
  %1496 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1495, i32 0, i32 0
  %1497 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1496, align 8
  %1498 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1497, i32 0, i32 8
  %1499 = load i32, i32* %1498, align 8
  %1500 = add i32 %1499, 1
  br label %1502

; <label>:1501                                    ; preds = %1451
  br label %1502

; <label>:1502                                    ; preds = %1501, %1493
  %1503 = phi i32 [ %1500, %1493 ], [ 0, %1501 ]
  %1504 = load %struct.entity*, %struct.entity** %5, align 8
  %1505 = getelementptr inbounds %struct.entity, %struct.entity* %1504, i32 0, i32 6
  %1506 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1505, i32 0, i32 0
  %1507 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1506, align 8
  %1508 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1507, i32 0, i32 8
  store i32 %1503, i32* %1508, align 8
  %1509 = load %struct.entity*, %struct.entity** %5, align 8
  %1510 = getelementptr inbounds %struct.entity, %struct.entity* %1509, i32 0, i32 6
  %1511 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1510, i32 0, i32 0
  %1512 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1511, align 8
  %1513 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1512, i32 0, i32 8
  %1514 = load i32, i32* %1513, align 8
  %1515 = icmp ugt i32 %1514, 1
  br i1 %1515, label %1516, label %1522

; <label>:1516                                    ; preds = %1502
  %1517 = load %struct.entity*, %struct.entity** %5, align 8
  %1518 = getelementptr inbounds %struct.entity, %struct.entity* %1517, i32 0, i32 6
  %1519 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %1518, i32 0, i32 0
  %1520 = load %struct.UT_hash_table*, %struct.UT_hash_table** %1519, align 8
  %1521 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %1520, i32 0, i32 9
  store i32 1, i32* %1521, align 4
  br label %1522

; <label>:1522                                    ; preds = %1516, %1502
  br label %1523

; <label>:1523                                    ; preds = %1522
  br label %1524

; <label>:1524                                    ; preds = %1523, %1265, %1221
  br label %1525

; <label>:1525                                    ; preds = %1524
  br label %1526

; <label>:1526                                    ; preds = %1525
  br label %1527

; <label>:1527                                    ; preds = %1526
  br label %1528

; <label>:1528                                    ; preds = %1527, %532
  br label %1529

; <label>:1529                                    ; preds = %1528
  %1530 = load %struct.entity*, %struct.entity** %4, align 8
  %1531 = getelementptr inbounds %struct.entity, %struct.entity* %1530, i32 0, i32 5
  store %struct.entity* null, %struct.entity** %1531, align 8
  %1532 = load %struct.entity*, %struct.entity** %5, align 8
  %1533 = icmp ne %struct.entity* %1532, null
  br i1 %1533, label %1534, label %1549

; <label>:1534                                    ; preds = %1529
  %1535 = load %struct.entity*, %struct.entity** %5, align 8
  store %struct.entity* %1535, %struct.entity** %24, align 8
  br label %1536

; <label>:1536                                    ; preds = %1541, %1534
  %1537 = load %struct.entity*, %struct.entity** %24, align 8
  %1538 = getelementptr inbounds %struct.entity, %struct.entity* %1537, i32 0, i32 5
  %1539 = load %struct.entity*, %struct.entity** %1538, align 8
  %1540 = icmp ne %struct.entity* %1539, null
  br i1 %1540, label %1541, label %1545

; <label>:1541                                    ; preds = %1536
  %1542 = load %struct.entity*, %struct.entity** %24, align 8
  %1543 = getelementptr inbounds %struct.entity, %struct.entity* %1542, i32 0, i32 5
  %1544 = load %struct.entity*, %struct.entity** %1543, align 8
  store %struct.entity* %1544, %struct.entity** %24, align 8
  br label %1536

; <label>:1545                                    ; preds = %1536
  %1546 = load %struct.entity*, %struct.entity** %4, align 8
  %1547 = load %struct.entity*, %struct.entity** %24, align 8
  %1548 = getelementptr inbounds %struct.entity, %struct.entity* %1547, i32 0, i32 5
  store %struct.entity* %1546, %struct.entity** %1548, align 8
  br label %1551

; <label>:1549                                    ; preds = %1529
  %1550 = load %struct.entity*, %struct.entity** %4, align 8
  store %struct.entity* %1550, %struct.entity** %5, align 8
  br label %1551

; <label>:1551                                    ; preds = %1549, %1545
  br label %1552

; <label>:1552                                    ; preds = %1551
  ret void
}

declare i64 @strlen(i8*) #2

declare i32 @memcmp(i8*, i8*, i64) #2

declare i8* @malloc(i64) #2

; Function Attrs: noreturn
declare void @exit(i32) #3

; Function Attrs: nounwind
declare i8* @__memset_chk(i8*, i32, i64, i64) #4

; Function Attrs: nounwind readnone
declare i64 @llvm.objectsize.i64.p0i8(i8*, i1) #5

declare void @free(i8*) #2

; Function Attrs: nounwind ssp uwtable
define i32 @rect_intersect(i32, i32, i32, i32, i32, i32, i32, i32) #0 {
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  store i32 %0, i32* %10, align 4
  store i32 %1, i32* %11, align 4
  store i32 %2, i32* %12, align 4
  store i32 %3, i32* %13, align 4
  store i32 %4, i32* %14, align 4
  store i32 %5, i32* %15, align 4
  store i32 %6, i32* %16, align 4
  store i32 %7, i32* %17, align 4
  %18 = load i32, i32* %10, align 4
  %19 = load i32, i32* %14, align 4
  %20 = load i32, i32* %16, align 4
  %21 = add nsw i32 %19, %20
  %22 = icmp sgt i32 %18, %21
  br i1 %22, label %41, label %23

; <label>:23                                      ; preds = %8
  %24 = load i32, i32* %14, align 4
  %25 = load i32, i32* %10, align 4
  %26 = load i32, i32* %12, align 4
  %27 = add nsw i32 %25, %26
  %28 = icmp sgt i32 %24, %27
  br i1 %28, label %41, label %29

; <label>:29                                      ; preds = %23
  %30 = load i32, i32* %11, align 4
  %31 = load i32, i32* %15, align 4
  %32 = load i32, i32* %17, align 4
  %33 = add nsw i32 %31, %32
  %34 = icmp sgt i32 %30, %33
  br i1 %34, label %41, label %35

; <label>:35                                      ; preds = %29
  %36 = load i32, i32* %15, align 4
  %37 = load i32, i32* %11, align 4
  %38 = load i32, i32* %13, align 4
  %39 = add nsw i32 %37, %38
  %40 = icmp sgt i32 %36, %39
  br i1 %40, label %41, label %42

; <label>:41                                      ; preds = %35, %29, %23, %8
  store i32 1, i32* %9, align 4
  br label %43

; <label>:42                                      ; preds = %35
  store i32 0, i32* %9, align 4
  br label %43

; <label>:43                                      ; preds = %42, %41
  %44 = load i32, i32* %9, align 4
  ret i32 %44
}

; Function Attrs: nounwind ssp uwtable
define i32 @ents_touching(%struct.entity*, %struct.entity*) #0 {
  %3 = alloca %struct.entity*, align 8
  %4 = alloca %struct.entity*, align 8
  store %struct.entity* %0, %struct.entity** %3, align 8
  store %struct.entity* %1, %struct.entity** %4, align 8
  %5 = load %struct.entity*, %struct.entity** %3, align 8
  %6 = getelementptr inbounds %struct.entity, %struct.entity* %5, i32 0, i32 2
  %7 = getelementptr inbounds %struct.blr_pos, %struct.blr_pos* %6, i32 0, i32 0
  %8 = load i32, i32* %7, align 8
  %9 = load %struct.entity*, %struct.entity** %3, align 8
  %10 = getelementptr inbounds %struct.entity, %struct.entity* %9, i32 0, i32 2
  %11 = getelementptr inbounds %struct.blr_pos, %struct.blr_pos* %10, i32 0, i32 1
  %12 = load i32, i32* %11, align 4
  %13 = load %struct.entity*, %struct.entity** %3, align 8
  %14 = getelementptr inbounds %struct.entity, %struct.entity* %13, i32 0, i32 1
  %15 = getelementptr inbounds %struct.blr_size, %struct.blr_size* %14, i32 0, i32 0
  %16 = load i32, i32* %15, align 8
  %17 = load %struct.entity*, %struct.entity** %3, align 8
  %18 = getelementptr inbounds %struct.entity, %struct.entity* %17, i32 0, i32 1
  %19 = getelementptr inbounds %struct.blr_size, %struct.blr_size* %18, i32 0, i32 1
  %20 = load i32, i32* %19, align 4
  %21 = load %struct.entity*, %struct.entity** %4, align 8
  %22 = getelementptr inbounds %struct.entity, %struct.entity* %21, i32 0, i32 2
  %23 = getelementptr inbounds %struct.blr_pos, %struct.blr_pos* %22, i32 0, i32 0
  %24 = load i32, i32* %23, align 8
  %25 = load %struct.entity*, %struct.entity** %4, align 8
  %26 = getelementptr inbounds %struct.entity, %struct.entity* %25, i32 0, i32 2
  %27 = getelementptr inbounds %struct.blr_pos, %struct.blr_pos* %26, i32 0, i32 1
  %28 = load i32, i32* %27, align 4
  %29 = load %struct.entity*, %struct.entity** %4, align 8
  %30 = getelementptr inbounds %struct.entity, %struct.entity* %29, i32 0, i32 1
  %31 = getelementptr inbounds %struct.blr_size, %struct.blr_size* %30, i32 0, i32 0
  %32 = load i32, i32* %31, align 8
  %33 = load %struct.entity*, %struct.entity** %4, align 8
  %34 = getelementptr inbounds %struct.entity, %struct.entity* %33, i32 0, i32 1
  %35 = getelementptr inbounds %struct.blr_size, %struct.blr_size* %34, i32 0, i32 1
  %36 = load i32, i32* %35, align 4
  %37 = call i32 @rect_intersect(i32 %8, i32 %12, i32 %16, i32 %20, i32 %24, i32 %28, i32 %32, i32 %36)
  ret i32 %37
}

; Function Attrs: nounwind ssp uwtable
define void @chk_collision(%struct.entity*, i8*, void (%struct.entity*, %struct.entity*)*) #0 {
  %4 = alloca %struct.entity*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca void (%struct.entity*, %struct.entity*)*, align 8
  %7 = alloca %struct.entity*, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i8*, align 8
  %13 = alloca i32, align 4
  %14 = alloca %struct.entity*, align 8
  %15 = alloca %struct.entity*, align 8
  store %struct.entity* %0, %struct.entity** %4, align 8
  store i8* %1, i8** %5, align 8
  store void (%struct.entity*, %struct.entity*)* %2, void (%struct.entity*, %struct.entity*)** %6, align 8
  br label %16

; <label>:16                                      ; preds = %3
  br label %17

; <label>:17                                      ; preds = %16
  br label %18

; <label>:18                                      ; preds = %17
  %19 = load i8*, i8** %5, align 8
  store i8* %19, i8** %12, align 8
  store i32 -17973521, i32* %8, align 4
  store i32 -1640531527, i32* %10, align 4
  store i32 -1640531527, i32* %9, align 4
  %20 = load i8*, i8** %5, align 8
  %21 = call i64 @strlen(i8* %20)
  %22 = trunc i64 %21 to i32
  store i32 %22, i32* %11, align 4
  br label %23

; <label>:23                                      ; preds = %190, %18
  %24 = load i32, i32* %11, align 4
  %25 = icmp uge i32 %24, 12
  br i1 %25, label %26, label %195

; <label>:26                                      ; preds = %23
  %27 = load i8*, i8** %12, align 8
  %28 = getelementptr inbounds i8, i8* %27, i64 0
  %29 = load i8, i8* %28, align 1
  %30 = zext i8 %29 to i32
  %31 = load i8*, i8** %12, align 8
  %32 = getelementptr inbounds i8, i8* %31, i64 1
  %33 = load i8, i8* %32, align 1
  %34 = zext i8 %33 to i32
  %35 = shl i32 %34, 8
  %36 = add i32 %30, %35
  %37 = load i8*, i8** %12, align 8
  %38 = getelementptr inbounds i8, i8* %37, i64 2
  %39 = load i8, i8* %38, align 1
  %40 = zext i8 %39 to i32
  %41 = shl i32 %40, 16
  %42 = add i32 %36, %41
  %43 = load i8*, i8** %12, align 8
  %44 = getelementptr inbounds i8, i8* %43, i64 3
  %45 = load i8, i8* %44, align 1
  %46 = zext i8 %45 to i32
  %47 = shl i32 %46, 24
  %48 = add i32 %42, %47
  %49 = load i32, i32* %9, align 4
  %50 = add i32 %49, %48
  store i32 %50, i32* %9, align 4
  %51 = load i8*, i8** %12, align 8
  %52 = getelementptr inbounds i8, i8* %51, i64 4
  %53 = load i8, i8* %52, align 1
  %54 = zext i8 %53 to i32
  %55 = load i8*, i8** %12, align 8
  %56 = getelementptr inbounds i8, i8* %55, i64 5
  %57 = load i8, i8* %56, align 1
  %58 = zext i8 %57 to i32
  %59 = shl i32 %58, 8
  %60 = add i32 %54, %59
  %61 = load i8*, i8** %12, align 8
  %62 = getelementptr inbounds i8, i8* %61, i64 6
  %63 = load i8, i8* %62, align 1
  %64 = zext i8 %63 to i32
  %65 = shl i32 %64, 16
  %66 = add i32 %60, %65
  %67 = load i8*, i8** %12, align 8
  %68 = getelementptr inbounds i8, i8* %67, i64 7
  %69 = load i8, i8* %68, align 1
  %70 = zext i8 %69 to i32
  %71 = shl i32 %70, 24
  %72 = add i32 %66, %71
  %73 = load i32, i32* %10, align 4
  %74 = add i32 %73, %72
  store i32 %74, i32* %10, align 4
  %75 = load i8*, i8** %12, align 8
  %76 = getelementptr inbounds i8, i8* %75, i64 8
  %77 = load i8, i8* %76, align 1
  %78 = zext i8 %77 to i32
  %79 = load i8*, i8** %12, align 8
  %80 = getelementptr inbounds i8, i8* %79, i64 9
  %81 = load i8, i8* %80, align 1
  %82 = zext i8 %81 to i32
  %83 = shl i32 %82, 8
  %84 = add i32 %78, %83
  %85 = load i8*, i8** %12, align 8
  %86 = getelementptr inbounds i8, i8* %85, i64 10
  %87 = load i8, i8* %86, align 1
  %88 = zext i8 %87 to i32
  %89 = shl i32 %88, 16
  %90 = add i32 %84, %89
  %91 = load i8*, i8** %12, align 8
  %92 = getelementptr inbounds i8, i8* %91, i64 11
  %93 = load i8, i8* %92, align 1
  %94 = zext i8 %93 to i32
  %95 = shl i32 %94, 24
  %96 = add i32 %90, %95
  %97 = load i32, i32* %8, align 4
  %98 = add i32 %97, %96
  store i32 %98, i32* %8, align 4
  br label %99

; <label>:99                                      ; preds = %26
  %100 = load i32, i32* %10, align 4
  %101 = load i32, i32* %9, align 4
  %102 = sub i32 %101, %100
  store i32 %102, i32* %9, align 4
  %103 = load i32, i32* %8, align 4
  %104 = load i32, i32* %9, align 4
  %105 = sub i32 %104, %103
  store i32 %105, i32* %9, align 4
  %106 = load i32, i32* %8, align 4
  %107 = lshr i32 %106, 13
  %108 = load i32, i32* %9, align 4
  %109 = xor i32 %108, %107
  store i32 %109, i32* %9, align 4
  %110 = load i32, i32* %8, align 4
  %111 = load i32, i32* %10, align 4
  %112 = sub i32 %111, %110
  store i32 %112, i32* %10, align 4
  %113 = load i32, i32* %9, align 4
  %114 = load i32, i32* %10, align 4
  %115 = sub i32 %114, %113
  store i32 %115, i32* %10, align 4
  %116 = load i32, i32* %9, align 4
  %117 = shl i32 %116, 8
  %118 = load i32, i32* %10, align 4
  %119 = xor i32 %118, %117
  store i32 %119, i32* %10, align 4
  %120 = load i32, i32* %9, align 4
  %121 = load i32, i32* %8, align 4
  %122 = sub i32 %121, %120
  store i32 %122, i32* %8, align 4
  %123 = load i32, i32* %10, align 4
  %124 = load i32, i32* %8, align 4
  %125 = sub i32 %124, %123
  store i32 %125, i32* %8, align 4
  %126 = load i32, i32* %10, align 4
  %127 = lshr i32 %126, 13
  %128 = load i32, i32* %8, align 4
  %129 = xor i32 %128, %127
  store i32 %129, i32* %8, align 4
  %130 = load i32, i32* %10, align 4
  %131 = load i32, i32* %9, align 4
  %132 = sub i32 %131, %130
  store i32 %132, i32* %9, align 4
  %133 = load i32, i32* %8, align 4
  %134 = load i32, i32* %9, align 4
  %135 = sub i32 %134, %133
  store i32 %135, i32* %9, align 4
  %136 = load i32, i32* %8, align 4
  %137 = lshr i32 %136, 12
  %138 = load i32, i32* %9, align 4
  %139 = xor i32 %138, %137
  store i32 %139, i32* %9, align 4
  %140 = load i32, i32* %8, align 4
  %141 = load i32, i32* %10, align 4
  %142 = sub i32 %141, %140
  store i32 %142, i32* %10, align 4
  %143 = load i32, i32* %9, align 4
  %144 = load i32, i32* %10, align 4
  %145 = sub i32 %144, %143
  store i32 %145, i32* %10, align 4
  %146 = load i32, i32* %9, align 4
  %147 = shl i32 %146, 16
  %148 = load i32, i32* %10, align 4
  %149 = xor i32 %148, %147
  store i32 %149, i32* %10, align 4
  %150 = load i32, i32* %9, align 4
  %151 = load i32, i32* %8, align 4
  %152 = sub i32 %151, %150
  store i32 %152, i32* %8, align 4
  %153 = load i32, i32* %10, align 4
  %154 = load i32, i32* %8, align 4
  %155 = sub i32 %154, %153
  store i32 %155, i32* %8, align 4
  %156 = load i32, i32* %10, align 4
  %157 = lshr i32 %156, 5
  %158 = load i32, i32* %8, align 4
  %159 = xor i32 %158, %157
  store i32 %159, i32* %8, align 4
  %160 = load i32, i32* %10, align 4
  %161 = load i32, i32* %9, align 4
  %162 = sub i32 %161, %160
  store i32 %162, i32* %9, align 4
  %163 = load i32, i32* %8, align 4
  %164 = load i32, i32* %9, align 4
  %165 = sub i32 %164, %163
  store i32 %165, i32* %9, align 4
  %166 = load i32, i32* %8, align 4
  %167 = lshr i32 %166, 3
  %168 = load i32, i32* %9, align 4
  %169 = xor i32 %168, %167
  store i32 %169, i32* %9, align 4
  %170 = load i32, i32* %8, align 4
  %171 = load i32, i32* %10, align 4
  %172 = sub i32 %171, %170
  store i32 %172, i32* %10, align 4
  %173 = load i32, i32* %9, align 4
  %174 = load i32, i32* %10, align 4
  %175 = sub i32 %174, %173
  store i32 %175, i32* %10, align 4
  %176 = load i32, i32* %9, align 4
  %177 = shl i32 %176, 10
  %178 = load i32, i32* %10, align 4
  %179 = xor i32 %178, %177
  store i32 %179, i32* %10, align 4
  %180 = load i32, i32* %9, align 4
  %181 = load i32, i32* %8, align 4
  %182 = sub i32 %181, %180
  store i32 %182, i32* %8, align 4
  %183 = load i32, i32* %10, align 4
  %184 = load i32, i32* %8, align 4
  %185 = sub i32 %184, %183
  store i32 %185, i32* %8, align 4
  %186 = load i32, i32* %10, align 4
  %187 = lshr i32 %186, 15
  %188 = load i32, i32* %8, align 4
  %189 = xor i32 %188, %187
  store i32 %189, i32* %8, align 4
  br label %190

; <label>:190                                     ; preds = %99
  %191 = load i8*, i8** %12, align 8
  %192 = getelementptr inbounds i8, i8* %191, i64 12
  store i8* %192, i8** %12, align 8
  %193 = load i32, i32* %11, align 4
  %194 = sub i32 %193, 12
  store i32 %194, i32* %11, align 4
  br label %23

; <label>:195                                     ; preds = %23
  %196 = load i8*, i8** %5, align 8
  %197 = call i64 @strlen(i8* %196)
  %198 = trunc i64 %197 to i32
  %199 = load i32, i32* %8, align 4
  %200 = add i32 %199, %198
  store i32 %200, i32* %8, align 4
  %201 = load i32, i32* %11, align 4
  switch i32 %201, label %288 [
    i32 11, label %202
    i32 10, label %210
    i32 9, label %218
    i32 8, label %226
    i32 7, label %234
    i32 6, label %242
    i32 5, label %250
    i32 4, label %257
    i32 3, label %265
    i32 2, label %273
    i32 1, label %281
  ]

; <label>:202                                     ; preds = %195
  %203 = load i8*, i8** %12, align 8
  %204 = getelementptr inbounds i8, i8* %203, i64 10
  %205 = load i8, i8* %204, align 1
  %206 = zext i8 %205 to i32
  %207 = shl i32 %206, 24
  %208 = load i32, i32* %8, align 4
  %209 = add i32 %208, %207
  store i32 %209, i32* %8, align 4
  br label %210

; <label>:210                                     ; preds = %195, %202
  %211 = load i8*, i8** %12, align 8
  %212 = getelementptr inbounds i8, i8* %211, i64 9
  %213 = load i8, i8* %212, align 1
  %214 = zext i8 %213 to i32
  %215 = shl i32 %214, 16
  %216 = load i32, i32* %8, align 4
  %217 = add i32 %216, %215
  store i32 %217, i32* %8, align 4
  br label %218

; <label>:218                                     ; preds = %195, %210
  %219 = load i8*, i8** %12, align 8
  %220 = getelementptr inbounds i8, i8* %219, i64 8
  %221 = load i8, i8* %220, align 1
  %222 = zext i8 %221 to i32
  %223 = shl i32 %222, 8
  %224 = load i32, i32* %8, align 4
  %225 = add i32 %224, %223
  store i32 %225, i32* %8, align 4
  br label %226

; <label>:226                                     ; preds = %195, %218
  %227 = load i8*, i8** %12, align 8
  %228 = getelementptr inbounds i8, i8* %227, i64 7
  %229 = load i8, i8* %228, align 1
  %230 = zext i8 %229 to i32
  %231 = shl i32 %230, 24
  %232 = load i32, i32* %10, align 4
  %233 = add i32 %232, %231
  store i32 %233, i32* %10, align 4
  br label %234

; <label>:234                                     ; preds = %195, %226
  %235 = load i8*, i8** %12, align 8
  %236 = getelementptr inbounds i8, i8* %235, i64 6
  %237 = load i8, i8* %236, align 1
  %238 = zext i8 %237 to i32
  %239 = shl i32 %238, 16
  %240 = load i32, i32* %10, align 4
  %241 = add i32 %240, %239
  store i32 %241, i32* %10, align 4
  br label %242

; <label>:242                                     ; preds = %195, %234
  %243 = load i8*, i8** %12, align 8
  %244 = getelementptr inbounds i8, i8* %243, i64 5
  %245 = load i8, i8* %244, align 1
  %246 = zext i8 %245 to i32
  %247 = shl i32 %246, 8
  %248 = load i32, i32* %10, align 4
  %249 = add i32 %248, %247
  store i32 %249, i32* %10, align 4
  br label %250

; <label>:250                                     ; preds = %195, %242
  %251 = load i8*, i8** %12, align 8
  %252 = getelementptr inbounds i8, i8* %251, i64 4
  %253 = load i8, i8* %252, align 1
  %254 = zext i8 %253 to i32
  %255 = load i32, i32* %10, align 4
  %256 = add i32 %255, %254
  store i32 %256, i32* %10, align 4
  br label %257

; <label>:257                                     ; preds = %195, %250
  %258 = load i8*, i8** %12, align 8
  %259 = getelementptr inbounds i8, i8* %258, i64 3
  %260 = load i8, i8* %259, align 1
  %261 = zext i8 %260 to i32
  %262 = shl i32 %261, 24
  %263 = load i32, i32* %9, align 4
  %264 = add i32 %263, %262
  store i32 %264, i32* %9, align 4
  br label %265

; <label>:265                                     ; preds = %195, %257
  %266 = load i8*, i8** %12, align 8
  %267 = getelementptr inbounds i8, i8* %266, i64 2
  %268 = load i8, i8* %267, align 1
  %269 = zext i8 %268 to i32
  %270 = shl i32 %269, 16
  %271 = load i32, i32* %9, align 4
  %272 = add i32 %271, %270
  store i32 %272, i32* %9, align 4
  br label %273

; <label>:273                                     ; preds = %195, %265
  %274 = load i8*, i8** %12, align 8
  %275 = getelementptr inbounds i8, i8* %274, i64 1
  %276 = load i8, i8* %275, align 1
  %277 = zext i8 %276 to i32
  %278 = shl i32 %277, 8
  %279 = load i32, i32* %9, align 4
  %280 = add i32 %279, %278
  store i32 %280, i32* %9, align 4
  br label %281

; <label>:281                                     ; preds = %195, %273
  %282 = load i8*, i8** %12, align 8
  %283 = getelementptr inbounds i8, i8* %282, i64 0
  %284 = load i8, i8* %283, align 1
  %285 = zext i8 %284 to i32
  %286 = load i32, i32* %9, align 4
  %287 = add i32 %286, %285
  store i32 %287, i32* %9, align 4
  br label %288

; <label>:288                                     ; preds = %281, %195
  br label %289

; <label>:289                                     ; preds = %288
  %290 = load i32, i32* %10, align 4
  %291 = load i32, i32* %9, align 4
  %292 = sub i32 %291, %290
  store i32 %292, i32* %9, align 4
  %293 = load i32, i32* %8, align 4
  %294 = load i32, i32* %9, align 4
  %295 = sub i32 %294, %293
  store i32 %295, i32* %9, align 4
  %296 = load i32, i32* %8, align 4
  %297 = lshr i32 %296, 13
  %298 = load i32, i32* %9, align 4
  %299 = xor i32 %298, %297
  store i32 %299, i32* %9, align 4
  %300 = load i32, i32* %8, align 4
  %301 = load i32, i32* %10, align 4
  %302 = sub i32 %301, %300
  store i32 %302, i32* %10, align 4
  %303 = load i32, i32* %9, align 4
  %304 = load i32, i32* %10, align 4
  %305 = sub i32 %304, %303
  store i32 %305, i32* %10, align 4
  %306 = load i32, i32* %9, align 4
  %307 = shl i32 %306, 8
  %308 = load i32, i32* %10, align 4
  %309 = xor i32 %308, %307
  store i32 %309, i32* %10, align 4
  %310 = load i32, i32* %9, align 4
  %311 = load i32, i32* %8, align 4
  %312 = sub i32 %311, %310
  store i32 %312, i32* %8, align 4
  %313 = load i32, i32* %10, align 4
  %314 = load i32, i32* %8, align 4
  %315 = sub i32 %314, %313
  store i32 %315, i32* %8, align 4
  %316 = load i32, i32* %10, align 4
  %317 = lshr i32 %316, 13
  %318 = load i32, i32* %8, align 4
  %319 = xor i32 %318, %317
  store i32 %319, i32* %8, align 4
  %320 = load i32, i32* %10, align 4
  %321 = load i32, i32* %9, align 4
  %322 = sub i32 %321, %320
  store i32 %322, i32* %9, align 4
  %323 = load i32, i32* %8, align 4
  %324 = load i32, i32* %9, align 4
  %325 = sub i32 %324, %323
  store i32 %325, i32* %9, align 4
  %326 = load i32, i32* %8, align 4
  %327 = lshr i32 %326, 12
  %328 = load i32, i32* %9, align 4
  %329 = xor i32 %328, %327
  store i32 %329, i32* %9, align 4
  %330 = load i32, i32* %8, align 4
  %331 = load i32, i32* %10, align 4
  %332 = sub i32 %331, %330
  store i32 %332, i32* %10, align 4
  %333 = load i32, i32* %9, align 4
  %334 = load i32, i32* %10, align 4
  %335 = sub i32 %334, %333
  store i32 %335, i32* %10, align 4
  %336 = load i32, i32* %9, align 4
  %337 = shl i32 %336, 16
  %338 = load i32, i32* %10, align 4
  %339 = xor i32 %338, %337
  store i32 %339, i32* %10, align 4
  %340 = load i32, i32* %9, align 4
  %341 = load i32, i32* %8, align 4
  %342 = sub i32 %341, %340
  store i32 %342, i32* %8, align 4
  %343 = load i32, i32* %10, align 4
  %344 = load i32, i32* %8, align 4
  %345 = sub i32 %344, %343
  store i32 %345, i32* %8, align 4
  %346 = load i32, i32* %10, align 4
  %347 = lshr i32 %346, 5
  %348 = load i32, i32* %8, align 4
  %349 = xor i32 %348, %347
  store i32 %349, i32* %8, align 4
  %350 = load i32, i32* %10, align 4
  %351 = load i32, i32* %9, align 4
  %352 = sub i32 %351, %350
  store i32 %352, i32* %9, align 4
  %353 = load i32, i32* %8, align 4
  %354 = load i32, i32* %9, align 4
  %355 = sub i32 %354, %353
  store i32 %355, i32* %9, align 4
  %356 = load i32, i32* %8, align 4
  %357 = lshr i32 %356, 3
  %358 = load i32, i32* %9, align 4
  %359 = xor i32 %358, %357
  store i32 %359, i32* %9, align 4
  %360 = load i32, i32* %8, align 4
  %361 = load i32, i32* %10, align 4
  %362 = sub i32 %361, %360
  store i32 %362, i32* %10, align 4
  %363 = load i32, i32* %9, align 4
  %364 = load i32, i32* %10, align 4
  %365 = sub i32 %364, %363
  store i32 %365, i32* %10, align 4
  %366 = load i32, i32* %9, align 4
  %367 = shl i32 %366, 10
  %368 = load i32, i32* %10, align 4
  %369 = xor i32 %368, %367
  store i32 %369, i32* %10, align 4
  %370 = load i32, i32* %9, align 4
  %371 = load i32, i32* %8, align 4
  %372 = sub i32 %371, %370
  store i32 %372, i32* %8, align 4
  %373 = load i32, i32* %10, align 4
  %374 = load i32, i32* %8, align 4
  %375 = sub i32 %374, %373
  store i32 %375, i32* %8, align 4
  %376 = load i32, i32* %10, align 4
  %377 = lshr i32 %376, 15
  %378 = load i32, i32* %8, align 4
  %379 = xor i32 %378, %377
  store i32 %379, i32* %8, align 4
  br label %380

; <label>:380                                     ; preds = %289
  br label %381

; <label>:381                                     ; preds = %380
  br label %382

; <label>:382                                     ; preds = %381
  br label %383

; <label>:383                                     ; preds = %382
  store %struct.entity* null, %struct.entity** %7, align 8
  %384 = load %struct.gameboard*, %struct.gameboard** @current_board, align 8
  %385 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %384, i32 0, i32 3
  %386 = load %struct.entity*, %struct.entity** %385, align 8
  %387 = icmp ne %struct.entity* %386, null
  br i1 %387, label %388, label %509

; <label>:388                                     ; preds = %383
  br label %389

; <label>:389                                     ; preds = %388
  %390 = load i32, i32* %8, align 4
  %391 = load %struct.gameboard*, %struct.gameboard** @current_board, align 8
  %392 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %391, i32 0, i32 3
  %393 = load %struct.entity*, %struct.entity** %392, align 8
  %394 = getelementptr inbounds %struct.entity, %struct.entity* %393, i32 0, i32 6
  %395 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %394, i32 0, i32 0
  %396 = load %struct.UT_hash_table*, %struct.UT_hash_table** %395, align 8
  %397 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %396, i32 0, i32 1
  %398 = load i32, i32* %397, align 8
  %399 = sub i32 %398, 1
  %400 = and i32 %390, %399
  store i32 %400, i32* %13, align 4
  br label %401

; <label>:401                                     ; preds = %389
  br label %402

; <label>:402                                     ; preds = %401
  %403 = load i32, i32* %13, align 4
  %404 = zext i32 %403 to i64
  %405 = load %struct.gameboard*, %struct.gameboard** @current_board, align 8
  %406 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %405, i32 0, i32 3
  %407 = load %struct.entity*, %struct.entity** %406, align 8
  %408 = getelementptr inbounds %struct.entity, %struct.entity* %407, i32 0, i32 6
  %409 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %408, i32 0, i32 0
  %410 = load %struct.UT_hash_table*, %struct.UT_hash_table** %409, align 8
  %411 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %410, i32 0, i32 0
  %412 = load %struct.UT_hash_bucket*, %struct.UT_hash_bucket** %411, align 8
  %413 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %412, i64 %404
  %414 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %413, i32 0, i32 0
  %415 = load %struct.UT_hash_handle*, %struct.UT_hash_handle** %414, align 8
  %416 = icmp ne %struct.UT_hash_handle* %415, null
  br i1 %416, label %417, label %445

; <label>:417                                     ; preds = %402
  br label %418

; <label>:418                                     ; preds = %417
  %419 = load i32, i32* %13, align 4
  %420 = zext i32 %419 to i64
  %421 = load %struct.gameboard*, %struct.gameboard** @current_board, align 8
  %422 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %421, i32 0, i32 3
  %423 = load %struct.entity*, %struct.entity** %422, align 8
  %424 = getelementptr inbounds %struct.entity, %struct.entity* %423, i32 0, i32 6
  %425 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %424, i32 0, i32 0
  %426 = load %struct.UT_hash_table*, %struct.UT_hash_table** %425, align 8
  %427 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %426, i32 0, i32 0
  %428 = load %struct.UT_hash_bucket*, %struct.UT_hash_bucket** %427, align 8
  %429 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %428, i64 %420
  %430 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %429, i32 0, i32 0
  %431 = load %struct.UT_hash_handle*, %struct.UT_hash_handle** %430, align 8
  %432 = bitcast %struct.UT_hash_handle* %431 to i8*
  %433 = load %struct.gameboard*, %struct.gameboard** @current_board, align 8
  %434 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %433, i32 0, i32 3
  %435 = load %struct.entity*, %struct.entity** %434, align 8
  %436 = getelementptr inbounds %struct.entity, %struct.entity* %435, i32 0, i32 6
  %437 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %436, i32 0, i32 0
  %438 = load %struct.UT_hash_table*, %struct.UT_hash_table** %437, align 8
  %439 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %438, i32 0, i32 5
  %440 = load i64, i64* %439, align 8
  %441 = sub i64 0, %440
  %442 = getelementptr inbounds i8, i8* %432, i64 %441
  %443 = bitcast i8* %442 to %struct.entity*
  store %struct.entity* %443, %struct.entity** %7, align 8
  br label %444

; <label>:444                                     ; preds = %418
  br label %446

; <label>:445                                     ; preds = %402
  store %struct.entity* null, %struct.entity** %7, align 8
  br label %446

; <label>:446                                     ; preds = %445, %444
  br label %447

; <label>:447                                     ; preds = %506, %446
  %448 = load %struct.entity*, %struct.entity** %7, align 8
  %449 = icmp ne %struct.entity* %448, null
  br i1 %449, label %450, label %507

; <label>:450                                     ; preds = %447
  %451 = load %struct.entity*, %struct.entity** %7, align 8
  %452 = getelementptr inbounds %struct.entity, %struct.entity* %451, i32 0, i32 6
  %453 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %452, i32 0, i32 7
  %454 = load i32, i32* %453, align 4
  %455 = load i32, i32* %8, align 4
  %456 = icmp eq i32 %454, %455
  br i1 %456, label %457, label %480

; <label>:457                                     ; preds = %450
  %458 = load %struct.entity*, %struct.entity** %7, align 8
  %459 = getelementptr inbounds %struct.entity, %struct.entity* %458, i32 0, i32 6
  %460 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %459, i32 0, i32 6
  %461 = load i32, i32* %460, align 8
  %462 = load i8*, i8** %5, align 8
  %463 = call i64 @strlen(i8* %462)
  %464 = trunc i64 %463 to i32
  %465 = icmp eq i32 %461, %464
  br i1 %465, label %466, label %480

; <label>:466                                     ; preds = %457
  %467 = load %struct.entity*, %struct.entity** %7, align 8
  %468 = getelementptr inbounds %struct.entity, %struct.entity* %467, i32 0, i32 6
  %469 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %468, i32 0, i32 5
  %470 = load i8*, i8** %469, align 8
  %471 = load i8*, i8** %5, align 8
  %472 = load i8*, i8** %5, align 8
  %473 = call i64 @strlen(i8* %472)
  %474 = trunc i64 %473 to i32
  %475 = zext i32 %474 to i64
  %476 = call i32 @memcmp(i8* %470, i8* %471, i64 %475)
  %477 = icmp eq i32 %476, 0
  br i1 %477, label %478, label %479

; <label>:478                                     ; preds = %466
  br label %507

; <label>:479                                     ; preds = %466
  br label %480

; <label>:480                                     ; preds = %479, %457, %450
  %481 = load %struct.entity*, %struct.entity** %7, align 8
  %482 = getelementptr inbounds %struct.entity, %struct.entity* %481, i32 0, i32 6
  %483 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %482, i32 0, i32 4
  %484 = load %struct.UT_hash_handle*, %struct.UT_hash_handle** %483, align 8
  %485 = icmp ne %struct.UT_hash_handle* %484, null
  br i1 %485, label %486, label %505

; <label>:486                                     ; preds = %480
  br label %487

; <label>:487                                     ; preds = %486
  %488 = load %struct.entity*, %struct.entity** %7, align 8
  %489 = getelementptr inbounds %struct.entity, %struct.entity* %488, i32 0, i32 6
  %490 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %489, i32 0, i32 4
  %491 = load %struct.UT_hash_handle*, %struct.UT_hash_handle** %490, align 8
  %492 = bitcast %struct.UT_hash_handle* %491 to i8*
  %493 = load %struct.gameboard*, %struct.gameboard** @current_board, align 8
  %494 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %493, i32 0, i32 3
  %495 = load %struct.entity*, %struct.entity** %494, align 8
  %496 = getelementptr inbounds %struct.entity, %struct.entity* %495, i32 0, i32 6
  %497 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %496, i32 0, i32 0
  %498 = load %struct.UT_hash_table*, %struct.UT_hash_table** %497, align 8
  %499 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %498, i32 0, i32 5
  %500 = load i64, i64* %499, align 8
  %501 = sub i64 0, %500
  %502 = getelementptr inbounds i8, i8* %492, i64 %501
  %503 = bitcast i8* %502 to %struct.entity*
  store %struct.entity* %503, %struct.entity** %7, align 8
  br label %504

; <label>:504                                     ; preds = %487
  br label %506

; <label>:505                                     ; preds = %480
  store %struct.entity* null, %struct.entity** %7, align 8
  br label %506

; <label>:506                                     ; preds = %505, %504
  br label %447

; <label>:507                                     ; preds = %478, %447
  br label %508

; <label>:508                                     ; preds = %507
  br label %509

; <label>:509                                     ; preds = %508, %383
  br label %510

; <label>:510                                     ; preds = %509
  br label %511

; <label>:511                                     ; preds = %510
  %512 = load %struct.entity*, %struct.entity** %7, align 8
  %513 = icmp eq %struct.entity* %512, null
  br i1 %513, label %514, label %515

; <label>:514                                     ; preds = %511
  br label %544

; <label>:515                                     ; preds = %511
  %516 = load %struct.entity*, %struct.entity** %7, align 8
  store %struct.entity* %516, %struct.entity** %15, align 8
  br label %517

; <label>:517                                     ; preds = %542, %515
  %518 = load %struct.entity*, %struct.entity** %15, align 8
  %519 = icmp ne %struct.entity* %518, null
  br i1 %519, label %520, label %524

; <label>:520                                     ; preds = %517
  %521 = load %struct.entity*, %struct.entity** %15, align 8
  %522 = getelementptr inbounds %struct.entity, %struct.entity* %521, i32 0, i32 5
  %523 = load %struct.entity*, %struct.entity** %522, align 8
  store %struct.entity* %523, %struct.entity** %14, align 8
  br label %524

; <label>:524                                     ; preds = %520, %517
  %525 = phi i1 [ false, %517 ], [ true, %520 ]
  br i1 %525, label %526, label %544

; <label>:526                                     ; preds = %524
  %527 = load %struct.entity*, %struct.entity** %4, align 8
  %528 = load %struct.entity*, %struct.entity** %15, align 8
  %529 = icmp eq %struct.entity* %527, %528
  br i1 %529, label %530, label %531

; <label>:530                                     ; preds = %526
  br label %542

; <label>:531                                     ; preds = %526
  %532 = load %struct.entity*, %struct.entity** %4, align 8
  %533 = load %struct.entity*, %struct.entity** %15, align 8
  %534 = call i32 @ents_touching(%struct.entity* %532, %struct.entity* %533)
  %535 = icmp ne i32 %534, 0
  br i1 %535, label %536, label %540

; <label>:536                                     ; preds = %531
  %537 = load void (%struct.entity*, %struct.entity*)*, void (%struct.entity*, %struct.entity*)** %6, align 8
  %538 = load %struct.entity*, %struct.entity** %4, align 8
  %539 = load %struct.entity*, %struct.entity** %15, align 8
  call void %537(%struct.entity* %538, %struct.entity* %539)
  br label %540

; <label>:540                                     ; preds = %536, %531
  br label %541

; <label>:541                                     ; preds = %540
  br label %542

; <label>:542                                     ; preds = %541, %530
  %543 = load %struct.entity*, %struct.entity** %14, align 8
  store %struct.entity* %543, %struct.entity** %15, align 8
  br label %517

; <label>:544                                     ; preds = %514, %524
  ret void
}

; Function Attrs: nounwind ssp uwtable
define void @chk_keypress(i32) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  ret void
}

attributes #0 = { nounwind ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+sse4.1,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+sse4.1,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+sse4.1,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+sse4.1,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind readnone }
attributes #6 = { noreturn }
attributes #7 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"Apple LLVM version 8.0.0 (clang-800.0.42.1)"}
