; ModuleID = 'ballr.c'
source_filename = "ballr.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

%struct.gameboard = type { i8*, [2 x i32], [3 x i32], %struct.entity*, void (%struct.gameboard*)*, %struct.UT_hash_handle }
%struct.entity = type { i8*, [2 x i32], [2 x i32], [3 x i32], void (%struct.entity*)*, %struct.entity*, %struct.UT_hash_handle }
%struct.UT_hash_handle = type { %struct.UT_hash_table*, i8*, i8*, %struct.UT_hash_handle*, %struct.UT_hash_handle*, i8*, i32, i32 }
%struct.UT_hash_table = type { %struct.UT_hash_bucket*, i32, i32, i32, %struct.UT_hash_handle*, i64, i32, i32, i32, i32, i32 }
%struct.UT_hash_bucket = type { %struct.UT_hash_handle*, i32, i32 }

@current_board = external global %struct.gameboard*, align 8

; Function Attrs: nounwind ssp uwtable
define void @gb_init(%struct.gameboard*, i8*, i32* nocapture readonly, i32* nocapture readonly, void (%struct.gameboard*)*) #0 {
  %6 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %0, i64 0, i32 0
  store i8* %1, i8** %6, align 8, !tbaa !2
  %7 = load i32, i32* %2, align 4, !tbaa !9
  %8 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %0, i64 0, i32 1, i64 0
  store i32 %7, i32* %8, align 8, !tbaa !9
  %9 = getelementptr inbounds i32, i32* %2, i64 1
  %10 = load i32, i32* %9, align 4, !tbaa !9
  %11 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %0, i64 0, i32 1, i64 1
  store i32 %10, i32* %11, align 4, !tbaa !9
  %12 = load i32, i32* %3, align 4, !tbaa !9
  %13 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %0, i64 0, i32 2, i64 0
  store i32 %12, i32* %13, align 8, !tbaa !9
  %14 = getelementptr inbounds i32, i32* %3, i64 1
  %15 = load i32, i32* %14, align 4, !tbaa !9
  %16 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %0, i64 0, i32 2, i64 1
  store i32 %15, i32* %16, align 4, !tbaa !9
  %17 = getelementptr inbounds i32, i32* %3, i64 2
  %18 = load i32, i32* %17, align 4, !tbaa !9
  %19 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %0, i64 0, i32 2, i64 2
  store i32 %18, i32* %19, align 8, !tbaa !9
  %20 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %0, i64 0, i32 3
  store %struct.entity* null, %struct.entity** %20, align 8, !tbaa !10
  %21 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %0, i64 0, i32 4
  store void (%struct.gameboard*)* %4, void (%struct.gameboard*)** %21, align 8, !tbaa !11
  tail call void @register_gb(%struct.gameboard* %0) #9
  ret void
}

declare void @register_gb(%struct.gameboard*) #1

; Function Attrs: nounwind ssp uwtable
define void @ent_add(%struct.gameboard*, %struct.entity*) #0 {
  %3 = getelementptr inbounds %struct.entity, %struct.entity* %1, i64 0, i32 0
  %4 = load i8*, i8** %3, align 8, !tbaa !12
  %5 = tail call i64 @strlen(i8* %4)
  %6 = trunc i64 %5 to i32
  %7 = icmp ugt i32 %6, 11
  br i1 %7, label %8, label %117

; <label>:8                                       ; preds = %2
  br label %9

; <label>:9                                       ; preds = %8, %9
  %10 = phi i32 [ %106, %9 ], [ -17973521, %8 ]
  %11 = phi i32 [ %98, %9 ], [ -1640531527, %8 ]
  %12 = phi i32 [ %102, %9 ], [ -1640531527, %8 ]
  %13 = phi i32 [ %108, %9 ], [ %6, %8 ]
  %14 = phi i8* [ %107, %9 ], [ %4, %8 ]
  %15 = load i8, i8* %14, align 1, !tbaa !14
  %16 = zext i8 %15 to i32
  %17 = getelementptr inbounds i8, i8* %14, i64 1
  %18 = load i8, i8* %17, align 1, !tbaa !14
  %19 = zext i8 %18 to i32
  %20 = shl nuw nsw i32 %19, 8
  %21 = or i32 %20, %16
  %22 = getelementptr inbounds i8, i8* %14, i64 2
  %23 = load i8, i8* %22, align 1, !tbaa !14
  %24 = zext i8 %23 to i32
  %25 = shl nuw nsw i32 %24, 16
  %26 = or i32 %21, %25
  %27 = getelementptr inbounds i8, i8* %14, i64 3
  %28 = load i8, i8* %27, align 1, !tbaa !14
  %29 = zext i8 %28 to i32
  %30 = shl nuw i32 %29, 24
  %31 = or i32 %26, %30
  %32 = add i32 %31, %11
  %33 = getelementptr inbounds i8, i8* %14, i64 4
  %34 = load i8, i8* %33, align 1, !tbaa !14
  %35 = zext i8 %34 to i32
  %36 = getelementptr inbounds i8, i8* %14, i64 5
  %37 = load i8, i8* %36, align 1, !tbaa !14
  %38 = zext i8 %37 to i32
  %39 = shl nuw nsw i32 %38, 8
  %40 = or i32 %39, %35
  %41 = getelementptr inbounds i8, i8* %14, i64 6
  %42 = load i8, i8* %41, align 1, !tbaa !14
  %43 = zext i8 %42 to i32
  %44 = shl nuw nsw i32 %43, 16
  %45 = or i32 %40, %44
  %46 = getelementptr inbounds i8, i8* %14, i64 7
  %47 = load i8, i8* %46, align 1, !tbaa !14
  %48 = zext i8 %47 to i32
  %49 = shl nuw i32 %48, 24
  %50 = or i32 %45, %49
  %51 = add i32 %50, %12
  %52 = getelementptr inbounds i8, i8* %14, i64 8
  %53 = load i8, i8* %52, align 1, !tbaa !14
  %54 = zext i8 %53 to i32
  %55 = getelementptr inbounds i8, i8* %14, i64 9
  %56 = load i8, i8* %55, align 1, !tbaa !14
  %57 = zext i8 %56 to i32
  %58 = shl nuw nsw i32 %57, 8
  %59 = or i32 %58, %54
  %60 = getelementptr inbounds i8, i8* %14, i64 10
  %61 = load i8, i8* %60, align 1, !tbaa !14
  %62 = zext i8 %61 to i32
  %63 = shl nuw nsw i32 %62, 16
  %64 = or i32 %59, %63
  %65 = getelementptr inbounds i8, i8* %14, i64 11
  %66 = load i8, i8* %65, align 1, !tbaa !14
  %67 = zext i8 %66 to i32
  %68 = shl nuw i32 %67, 24
  %69 = or i32 %64, %68
  %70 = add i32 %69, %10
  %71 = sub i32 %32, %51
  %72 = sub i32 %71, %70
  %73 = lshr i32 %70, 13
  %74 = xor i32 %72, %73
  %75 = sub i32 %51, %70
  %76 = sub i32 %75, %74
  %77 = shl i32 %74, 8
  %78 = xor i32 %76, %77
  %79 = sub i32 %70, %74
  %80 = sub i32 %79, %78
  %81 = lshr i32 %78, 13
  %82 = xor i32 %80, %81
  %83 = sub i32 %74, %78
  %84 = sub i32 %83, %82
  %85 = lshr i32 %82, 12
  %86 = xor i32 %84, %85
  %87 = sub i32 %78, %82
  %88 = sub i32 %87, %86
  %89 = shl i32 %86, 16
  %90 = xor i32 %88, %89
  %91 = sub i32 %82, %86
  %92 = sub i32 %91, %90
  %93 = lshr i32 %90, 5
  %94 = xor i32 %92, %93
  %95 = sub i32 %86, %90
  %96 = sub i32 %95, %94
  %97 = lshr i32 %94, 3
  %98 = xor i32 %96, %97
  %99 = sub i32 %90, %94
  %100 = sub i32 %99, %98
  %101 = shl i32 %98, 10
  %102 = xor i32 %100, %101
  %103 = sub i32 %94, %98
  %104 = sub i32 %103, %102
  %105 = lshr i32 %102, 15
  %106 = xor i32 %104, %105
  %107 = getelementptr inbounds i8, i8* %14, i64 12
  %108 = add i32 %13, -12
  %109 = icmp ugt i32 %108, 11
  br i1 %109, label %9, label %110

; <label>:110                                     ; preds = %9
  %111 = phi i32 [ %108, %9 ]
  %112 = phi i8* [ %107, %9 ]
  %113 = phi i32 [ %106, %9 ]
  %114 = phi i32 [ %102, %9 ]
  %115 = phi i32 [ %98, %9 ]
  %116 = load i8*, i8** %3, align 8, !tbaa !12
  br label %117

; <label>:117                                     ; preds = %110, %2
  %118 = phi i8* [ %4, %2 ], [ %116, %110 ]
  %119 = phi i32 [ -17973521, %2 ], [ %113, %110 ]
  %120 = phi i32 [ -1640531527, %2 ], [ %115, %110 ]
  %121 = phi i32 [ -1640531527, %2 ], [ %114, %110 ]
  %122 = phi i32 [ %6, %2 ], [ %111, %110 ]
  %123 = phi i8* [ %4, %2 ], [ %112, %110 ]
  %124 = tail call i64 @strlen(i8* %118)
  %125 = trunc i64 %124 to i32
  %126 = add i32 %125, %119
  switch i32 %122, label %210 [
    i32 11, label %127
    i32 10, label %133
    i32 9, label %140
    i32 8, label %147
    i32 7, label %154
    i32 6, label %162
    i32 5, label %170
    i32 4, label %177
    i32 3, label %185
    i32 2, label %194
    i32 1, label %203
  ]

; <label>:127                                     ; preds = %117
  %128 = getelementptr inbounds i8, i8* %123, i64 10
  %129 = load i8, i8* %128, align 1, !tbaa !14
  %130 = zext i8 %129 to i32
  %131 = shl nuw i32 %130, 24
  %132 = add i32 %131, %126
  br label %133

; <label>:133                                     ; preds = %117, %127
  %134 = phi i32 [ %126, %117 ], [ %132, %127 ]
  %135 = getelementptr inbounds i8, i8* %123, i64 9
  %136 = load i8, i8* %135, align 1, !tbaa !14
  %137 = zext i8 %136 to i32
  %138 = shl nuw nsw i32 %137, 16
  %139 = add i32 %138, %134
  br label %140

; <label>:140                                     ; preds = %117, %133
  %141 = phi i32 [ %126, %117 ], [ %139, %133 ]
  %142 = getelementptr inbounds i8, i8* %123, i64 8
  %143 = load i8, i8* %142, align 1, !tbaa !14
  %144 = zext i8 %143 to i32
  %145 = shl nuw nsw i32 %144, 8
  %146 = add i32 %145, %141
  br label %147

; <label>:147                                     ; preds = %117, %140
  %148 = phi i32 [ %126, %117 ], [ %146, %140 ]
  %149 = getelementptr inbounds i8, i8* %123, i64 7
  %150 = load i8, i8* %149, align 1, !tbaa !14
  %151 = zext i8 %150 to i32
  %152 = shl nuw i32 %151, 24
  %153 = add i32 %152, %121
  br label %154

; <label>:154                                     ; preds = %117, %147
  %155 = phi i32 [ %121, %117 ], [ %153, %147 ]
  %156 = phi i32 [ %126, %117 ], [ %148, %147 ]
  %157 = getelementptr inbounds i8, i8* %123, i64 6
  %158 = load i8, i8* %157, align 1, !tbaa !14
  %159 = zext i8 %158 to i32
  %160 = shl nuw nsw i32 %159, 16
  %161 = add i32 %160, %155
  br label %162

; <label>:162                                     ; preds = %117, %154
  %163 = phi i32 [ %121, %117 ], [ %161, %154 ]
  %164 = phi i32 [ %126, %117 ], [ %156, %154 ]
  %165 = getelementptr inbounds i8, i8* %123, i64 5
  %166 = load i8, i8* %165, align 1, !tbaa !14
  %167 = zext i8 %166 to i32
  %168 = shl nuw nsw i32 %167, 8
  %169 = add i32 %168, %163
  br label %170

; <label>:170                                     ; preds = %117, %162
  %171 = phi i32 [ %121, %117 ], [ %169, %162 ]
  %172 = phi i32 [ %126, %117 ], [ %164, %162 ]
  %173 = getelementptr inbounds i8, i8* %123, i64 4
  %174 = load i8, i8* %173, align 1, !tbaa !14
  %175 = zext i8 %174 to i32
  %176 = add i32 %175, %171
  br label %177

; <label>:177                                     ; preds = %117, %170
  %178 = phi i32 [ %121, %117 ], [ %176, %170 ]
  %179 = phi i32 [ %126, %117 ], [ %172, %170 ]
  %180 = getelementptr inbounds i8, i8* %123, i64 3
  %181 = load i8, i8* %180, align 1, !tbaa !14
  %182 = zext i8 %181 to i32
  %183 = shl nuw i32 %182, 24
  %184 = add i32 %183, %120
  br label %185

; <label>:185                                     ; preds = %117, %177
  %186 = phi i32 [ %121, %117 ], [ %178, %177 ]
  %187 = phi i32 [ %120, %117 ], [ %184, %177 ]
  %188 = phi i32 [ %126, %117 ], [ %179, %177 ]
  %189 = getelementptr inbounds i8, i8* %123, i64 2
  %190 = load i8, i8* %189, align 1, !tbaa !14
  %191 = zext i8 %190 to i32
  %192 = shl nuw nsw i32 %191, 16
  %193 = add i32 %192, %187
  br label %194

; <label>:194                                     ; preds = %117, %185
  %195 = phi i32 [ %121, %117 ], [ %186, %185 ]
  %196 = phi i32 [ %120, %117 ], [ %193, %185 ]
  %197 = phi i32 [ %126, %117 ], [ %188, %185 ]
  %198 = getelementptr inbounds i8, i8* %123, i64 1
  %199 = load i8, i8* %198, align 1, !tbaa !14
  %200 = zext i8 %199 to i32
  %201 = shl nuw nsw i32 %200, 8
  %202 = add i32 %201, %196
  br label %203

; <label>:203                                     ; preds = %117, %194
  %204 = phi i32 [ %121, %117 ], [ %195, %194 ]
  %205 = phi i32 [ %120, %117 ], [ %202, %194 ]
  %206 = phi i32 [ %126, %117 ], [ %197, %194 ]
  %207 = load i8, i8* %123, align 1, !tbaa !14
  %208 = zext i8 %207 to i32
  %209 = add i32 %208, %205
  br label %210

; <label>:210                                     ; preds = %117, %203
  %211 = phi i32 [ %121, %117 ], [ %204, %203 ]
  %212 = phi i32 [ %120, %117 ], [ %209, %203 ]
  %213 = phi i32 [ %126, %117 ], [ %206, %203 ]
  %214 = sub i32 %212, %211
  %215 = sub i32 %214, %213
  %216 = lshr i32 %213, 13
  %217 = xor i32 %215, %216
  %218 = sub i32 %211, %213
  %219 = sub i32 %218, %217
  %220 = shl i32 %217, 8
  %221 = xor i32 %219, %220
  %222 = sub i32 %213, %217
  %223 = sub i32 %222, %221
  %224 = lshr i32 %221, 13
  %225 = xor i32 %223, %224
  %226 = sub i32 %217, %221
  %227 = sub i32 %226, %225
  %228 = lshr i32 %225, 12
  %229 = xor i32 %227, %228
  %230 = sub i32 %221, %225
  %231 = sub i32 %230, %229
  %232 = shl i32 %229, 16
  %233 = xor i32 %231, %232
  %234 = sub i32 %225, %229
  %235 = sub i32 %234, %233
  %236 = lshr i32 %233, 5
  %237 = xor i32 %235, %236
  %238 = sub i32 %229, %233
  %239 = sub i32 %238, %237
  %240 = lshr i32 %237, 3
  %241 = xor i32 %239, %240
  %242 = sub i32 %233, %237
  %243 = sub i32 %242, %241
  %244 = shl i32 %241, 10
  %245 = xor i32 %243, %244
  %246 = sub i32 %237, %241
  %247 = sub i32 %246, %245
  %248 = lshr i32 %245, 15
  %249 = xor i32 %247, %248
  %250 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %0, i64 0, i32 3
  %251 = load %struct.entity*, %struct.entity** %250, align 8, !tbaa !10
  %252 = icmp eq %struct.entity* %251, null
  br i1 %252, label %307, label %253

; <label>:253                                     ; preds = %210
  %254 = getelementptr inbounds %struct.entity, %struct.entity* %251, i64 0, i32 6, i32 0
  %255 = load %struct.UT_hash_table*, %struct.UT_hash_table** %254, align 8, !tbaa !15
  %256 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %255, i64 0, i32 1
  %257 = load i32, i32* %256, align 8, !tbaa !16
  %258 = add i32 %257, -1
  %259 = and i32 %258, %249
  %260 = zext i32 %259 to i64
  %261 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %255, i64 0, i32 0
  %262 = load %struct.UT_hash_bucket*, %struct.UT_hash_bucket** %261, align 8, !tbaa !19
  %263 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %262, i64 %260, i32 0
  %264 = load %struct.UT_hash_handle*, %struct.UT_hash_handle** %263, align 8, !tbaa !20
  %265 = icmp eq %struct.UT_hash_handle* %264, null
  br i1 %265, label %307, label %266

; <label>:266                                     ; preds = %253
  %267 = bitcast %struct.UT_hash_handle* %264 to i8*
  %268 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %255, i64 0, i32 5
  %269 = load i64, i64* %268, align 8, !tbaa !22
  %270 = sub i64 0, %269
  %271 = getelementptr inbounds i8, i8* %267, i64 %270
  %272 = icmp eq i8* %271, null
  br i1 %272, label %307, label %273

; <label>:273                                     ; preds = %266
  %274 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %255, i64 0, i32 5
  br label %275

; <label>:275                                     ; preds = %273, %300
  %276 = phi i8* [ %304, %300 ], [ %271, %273 ]
  %277 = getelementptr inbounds i8, i8* %276, i64 108
  %278 = bitcast i8* %277 to i32*
  %279 = load i32, i32* %278, align 4, !tbaa !23
  %280 = icmp eq i32 %279, %249
  br i1 %280, label %281, label %295

; <label>:281                                     ; preds = %275
  %282 = getelementptr inbounds i8, i8* %276, i64 104
  %283 = bitcast i8* %282 to i32*
  %284 = load i32, i32* %283, align 8, !tbaa !24
  %285 = tail call i64 @strlen(i8* %118)
  %286 = trunc i64 %285 to i32
  %287 = icmp eq i32 %284, %286
  br i1 %287, label %288, label %295

; <label>:288                                     ; preds = %281
  %289 = getelementptr inbounds i8, i8* %276, i64 96
  %290 = bitcast i8* %289 to i8**
  %291 = load i8*, i8** %290, align 8, !tbaa !25
  %292 = and i64 %285, 4294967295
  %293 = tail call i32 @memcmp(i8* %291, i8* %118, i64 %292)
  %294 = icmp eq i32 %293, 0
  br i1 %294, label %786, label %295

; <label>:295                                     ; preds = %288, %281, %275
  %296 = getelementptr inbounds i8, i8* %276, i64 88
  %297 = bitcast i8* %296 to %struct.UT_hash_handle**
  %298 = load %struct.UT_hash_handle*, %struct.UT_hash_handle** %297, align 8, !tbaa !26
  %299 = icmp eq %struct.UT_hash_handle* %298, null
  br i1 %299, label %306, label %300

; <label>:300                                     ; preds = %295
  %301 = bitcast %struct.UT_hash_handle* %298 to i8*
  %302 = load i64, i64* %274, align 8, !tbaa !22
  %303 = sub i64 0, %302
  %304 = getelementptr inbounds i8, i8* %301, i64 %303
  %305 = icmp eq i8* %304, null
  br i1 %305, label %306, label %275

; <label>:306                                     ; preds = %300, %295
  br label %307

; <label>:307                                     ; preds = %306, %253, %266, %210
  %308 = tail call i8* @malloc(i64 112)
  %309 = bitcast i8* %308 to %struct.entity*
  %310 = bitcast i8* %308 to i8**
  store i8* %118, i8** %310, align 8, !tbaa !12
  %311 = tail call i64 @strlen(i8* %118)
  %312 = trunc i64 %311 to i32
  %313 = icmp ugt i32 %312, 11
  br i1 %313, label %314, label %423

; <label>:314                                     ; preds = %307
  br label %315

; <label>:315                                     ; preds = %314, %315
  %316 = phi i8* [ %413, %315 ], [ %118, %314 ]
  %317 = phi i32 [ %414, %315 ], [ %312, %314 ]
  %318 = phi i32 [ %408, %315 ], [ -1640531527, %314 ]
  %319 = phi i32 [ %404, %315 ], [ -1640531527, %314 ]
  %320 = phi i32 [ %412, %315 ], [ -17973521, %314 ]
  %321 = load i8, i8* %316, align 1, !tbaa !14
  %322 = zext i8 %321 to i32
  %323 = getelementptr inbounds i8, i8* %316, i64 1
  %324 = load i8, i8* %323, align 1, !tbaa !14
  %325 = zext i8 %324 to i32
  %326 = shl nuw nsw i32 %325, 8
  %327 = or i32 %326, %322
  %328 = getelementptr inbounds i8, i8* %316, i64 2
  %329 = load i8, i8* %328, align 1, !tbaa !14
  %330 = zext i8 %329 to i32
  %331 = shl nuw nsw i32 %330, 16
  %332 = or i32 %327, %331
  %333 = getelementptr inbounds i8, i8* %316, i64 3
  %334 = load i8, i8* %333, align 1, !tbaa !14
  %335 = zext i8 %334 to i32
  %336 = shl nuw i32 %335, 24
  %337 = or i32 %332, %336
  %338 = add i32 %337, %319
  %339 = getelementptr inbounds i8, i8* %316, i64 4
  %340 = load i8, i8* %339, align 1, !tbaa !14
  %341 = zext i8 %340 to i32
  %342 = getelementptr inbounds i8, i8* %316, i64 5
  %343 = load i8, i8* %342, align 1, !tbaa !14
  %344 = zext i8 %343 to i32
  %345 = shl nuw nsw i32 %344, 8
  %346 = or i32 %345, %341
  %347 = getelementptr inbounds i8, i8* %316, i64 6
  %348 = load i8, i8* %347, align 1, !tbaa !14
  %349 = zext i8 %348 to i32
  %350 = shl nuw nsw i32 %349, 16
  %351 = or i32 %346, %350
  %352 = getelementptr inbounds i8, i8* %316, i64 7
  %353 = load i8, i8* %352, align 1, !tbaa !14
  %354 = zext i8 %353 to i32
  %355 = shl nuw i32 %354, 24
  %356 = or i32 %351, %355
  %357 = add i32 %356, %318
  %358 = getelementptr inbounds i8, i8* %316, i64 8
  %359 = load i8, i8* %358, align 1, !tbaa !14
  %360 = zext i8 %359 to i32
  %361 = getelementptr inbounds i8, i8* %316, i64 9
  %362 = load i8, i8* %361, align 1, !tbaa !14
  %363 = zext i8 %362 to i32
  %364 = shl nuw nsw i32 %363, 8
  %365 = or i32 %364, %360
  %366 = getelementptr inbounds i8, i8* %316, i64 10
  %367 = load i8, i8* %366, align 1, !tbaa !14
  %368 = zext i8 %367 to i32
  %369 = shl nuw nsw i32 %368, 16
  %370 = or i32 %365, %369
  %371 = getelementptr inbounds i8, i8* %316, i64 11
  %372 = load i8, i8* %371, align 1, !tbaa !14
  %373 = zext i8 %372 to i32
  %374 = shl nuw i32 %373, 24
  %375 = or i32 %370, %374
  %376 = add i32 %375, %320
  %377 = sub i32 %338, %357
  %378 = sub i32 %377, %376
  %379 = lshr i32 %376, 13
  %380 = xor i32 %378, %379
  %381 = sub i32 %357, %376
  %382 = sub i32 %381, %380
  %383 = shl i32 %380, 8
  %384 = xor i32 %382, %383
  %385 = sub i32 %376, %380
  %386 = sub i32 %385, %384
  %387 = lshr i32 %384, 13
  %388 = xor i32 %386, %387
  %389 = sub i32 %380, %384
  %390 = sub i32 %389, %388
  %391 = lshr i32 %388, 12
  %392 = xor i32 %390, %391
  %393 = sub i32 %384, %388
  %394 = sub i32 %393, %392
  %395 = shl i32 %392, 16
  %396 = xor i32 %394, %395
  %397 = sub i32 %388, %392
  %398 = sub i32 %397, %396
  %399 = lshr i32 %396, 5
  %400 = xor i32 %398, %399
  %401 = sub i32 %392, %396
  %402 = sub i32 %401, %400
  %403 = lshr i32 %400, 3
  %404 = xor i32 %402, %403
  %405 = sub i32 %396, %400
  %406 = sub i32 %405, %404
  %407 = shl i32 %404, 10
  %408 = xor i32 %406, %407
  %409 = sub i32 %400, %404
  %410 = sub i32 %409, %408
  %411 = lshr i32 %408, 15
  %412 = xor i32 %410, %411
  %413 = getelementptr inbounds i8, i8* %316, i64 12
  %414 = add i32 %317, -12
  %415 = icmp ugt i32 %414, 11
  br i1 %415, label %315, label %416

; <label>:416                                     ; preds = %315
  %417 = phi i32 [ %414, %315 ]
  %418 = phi i8* [ %413, %315 ]
  %419 = phi i32 [ %412, %315 ]
  %420 = phi i32 [ %408, %315 ]
  %421 = phi i32 [ %404, %315 ]
  %422 = load i8*, i8** %310, align 8, !tbaa !12
  br label %423

; <label>:423                                     ; preds = %416, %307
  %424 = phi i8* [ %118, %307 ], [ %422, %416 ]
  %425 = phi i8* [ %118, %307 ], [ %418, %416 ]
  %426 = phi i32 [ %312, %307 ], [ %417, %416 ]
  %427 = phi i32 [ -1640531527, %307 ], [ %420, %416 ]
  %428 = phi i32 [ -1640531527, %307 ], [ %421, %416 ]
  %429 = phi i32 [ -17973521, %307 ], [ %419, %416 ]
  %430 = ptrtoint i8* %424 to i64
  %431 = tail call i64 @strlen(i8* %424)
  %432 = trunc i64 %431 to i32
  %433 = add i32 %432, %429
  switch i32 %426, label %517 [
    i32 11, label %434
    i32 10, label %440
    i32 9, label %447
    i32 8, label %454
    i32 7, label %461
    i32 6, label %469
    i32 5, label %477
    i32 4, label %484
    i32 3, label %492
    i32 2, label %501
    i32 1, label %510
  ]

; <label>:434                                     ; preds = %423
  %435 = getelementptr inbounds i8, i8* %425, i64 10
  %436 = load i8, i8* %435, align 1, !tbaa !14
  %437 = zext i8 %436 to i32
  %438 = shl nuw i32 %437, 24
  %439 = add i32 %438, %433
  br label %440

; <label>:440                                     ; preds = %423, %434
  %441 = phi i32 [ %433, %423 ], [ %439, %434 ]
  %442 = getelementptr inbounds i8, i8* %425, i64 9
  %443 = load i8, i8* %442, align 1, !tbaa !14
  %444 = zext i8 %443 to i32
  %445 = shl nuw nsw i32 %444, 16
  %446 = add i32 %445, %441
  br label %447

; <label>:447                                     ; preds = %423, %440
  %448 = phi i32 [ %433, %423 ], [ %446, %440 ]
  %449 = getelementptr inbounds i8, i8* %425, i64 8
  %450 = load i8, i8* %449, align 1, !tbaa !14
  %451 = zext i8 %450 to i32
  %452 = shl nuw nsw i32 %451, 8
  %453 = add i32 %452, %448
  br label %454

; <label>:454                                     ; preds = %423, %447
  %455 = phi i32 [ %433, %423 ], [ %453, %447 ]
  %456 = getelementptr inbounds i8, i8* %425, i64 7
  %457 = load i8, i8* %456, align 1, !tbaa !14
  %458 = zext i8 %457 to i32
  %459 = shl nuw i32 %458, 24
  %460 = add i32 %459, %427
  br label %461

; <label>:461                                     ; preds = %423, %454
  %462 = phi i32 [ %433, %423 ], [ %455, %454 ]
  %463 = phi i32 [ %427, %423 ], [ %460, %454 ]
  %464 = getelementptr inbounds i8, i8* %425, i64 6
  %465 = load i8, i8* %464, align 1, !tbaa !14
  %466 = zext i8 %465 to i32
  %467 = shl nuw nsw i32 %466, 16
  %468 = add i32 %467, %463
  br label %469

; <label>:469                                     ; preds = %423, %461
  %470 = phi i32 [ %433, %423 ], [ %462, %461 ]
  %471 = phi i32 [ %427, %423 ], [ %468, %461 ]
  %472 = getelementptr inbounds i8, i8* %425, i64 5
  %473 = load i8, i8* %472, align 1, !tbaa !14
  %474 = zext i8 %473 to i32
  %475 = shl nuw nsw i32 %474, 8
  %476 = add i32 %475, %471
  br label %477

; <label>:477                                     ; preds = %423, %469
  %478 = phi i32 [ %433, %423 ], [ %470, %469 ]
  %479 = phi i32 [ %427, %423 ], [ %476, %469 ]
  %480 = getelementptr inbounds i8, i8* %425, i64 4
  %481 = load i8, i8* %480, align 1, !tbaa !14
  %482 = zext i8 %481 to i32
  %483 = add i32 %482, %479
  br label %484

; <label>:484                                     ; preds = %423, %477
  %485 = phi i32 [ %433, %423 ], [ %478, %477 ]
  %486 = phi i32 [ %427, %423 ], [ %483, %477 ]
  %487 = getelementptr inbounds i8, i8* %425, i64 3
  %488 = load i8, i8* %487, align 1, !tbaa !14
  %489 = zext i8 %488 to i32
  %490 = shl nuw i32 %489, 24
  %491 = add i32 %490, %428
  br label %492

; <label>:492                                     ; preds = %423, %484
  %493 = phi i32 [ %433, %423 ], [ %485, %484 ]
  %494 = phi i32 [ %428, %423 ], [ %491, %484 ]
  %495 = phi i32 [ %427, %423 ], [ %486, %484 ]
  %496 = getelementptr inbounds i8, i8* %425, i64 2
  %497 = load i8, i8* %496, align 1, !tbaa !14
  %498 = zext i8 %497 to i32
  %499 = shl nuw nsw i32 %498, 16
  %500 = add i32 %499, %494
  br label %501

; <label>:501                                     ; preds = %423, %492
  %502 = phi i32 [ %433, %423 ], [ %493, %492 ]
  %503 = phi i32 [ %428, %423 ], [ %500, %492 ]
  %504 = phi i32 [ %427, %423 ], [ %495, %492 ]
  %505 = getelementptr inbounds i8, i8* %425, i64 1
  %506 = load i8, i8* %505, align 1, !tbaa !14
  %507 = zext i8 %506 to i32
  %508 = shl nuw nsw i32 %507, 8
  %509 = add i32 %508, %503
  br label %510

; <label>:510                                     ; preds = %423, %501
  %511 = phi i32 [ %433, %423 ], [ %502, %501 ]
  %512 = phi i32 [ %428, %423 ], [ %509, %501 ]
  %513 = phi i32 [ %427, %423 ], [ %504, %501 ]
  %514 = load i8, i8* %425, align 1, !tbaa !14
  %515 = zext i8 %514 to i32
  %516 = add i32 %515, %512
  br label %517

; <label>:517                                     ; preds = %423, %510
  %518 = phi i32 [ %433, %423 ], [ %511, %510 ]
  %519 = phi i32 [ %428, %423 ], [ %516, %510 ]
  %520 = phi i32 [ %427, %423 ], [ %513, %510 ]
  %521 = sub i32 %519, %518
  %522 = sub i32 %521, %520
  %523 = lshr i32 %518, 13
  %524 = xor i32 %522, %523
  %525 = sub i32 %520, %518
  %526 = sub i32 %525, %524
  %527 = shl i32 %524, 8
  %528 = xor i32 %526, %527
  %529 = sub i32 %518, %524
  %530 = sub i32 %529, %528
  %531 = lshr i32 %528, 13
  %532 = xor i32 %530, %531
  %533 = sub i32 %524, %528
  %534 = sub i32 %533, %532
  %535 = lshr i32 %532, 12
  %536 = xor i32 %534, %535
  %537 = sub i32 %528, %532
  %538 = sub i32 %537, %536
  %539 = shl i32 %536, 16
  %540 = xor i32 %538, %539
  %541 = sub i32 %532, %536
  %542 = sub i32 %541, %540
  %543 = lshr i32 %540, 5
  %544 = xor i32 %542, %543
  %545 = sub i32 %536, %540
  %546 = sub i32 %545, %544
  %547 = lshr i32 %544, 3
  %548 = xor i32 %546, %547
  %549 = sub i32 %540, %544
  %550 = sub i32 %549, %548
  %551 = shl i32 %548, 10
  %552 = xor i32 %550, %551
  %553 = sub i32 %544, %548
  %554 = sub i32 %553, %552
  %555 = lshr i32 %552, 15
  %556 = xor i32 %554, %555
  %557 = getelementptr inbounds i8, i8* %308, i64 56
  %558 = getelementptr inbounds i8, i8* %308, i64 108
  %559 = bitcast i8* %558 to i32*
  store i32 %556, i32* %559, align 4, !tbaa !23
  %560 = getelementptr inbounds i8, i8* %308, i64 96
  %561 = bitcast i8* %560 to i64*
  store i64 %430, i64* %561, align 8, !tbaa !25
  %562 = tail call i64 @strlen(i8* %424)
  %563 = trunc i64 %562 to i32
  %564 = getelementptr inbounds i8, i8* %308, i64 104
  %565 = bitcast i8* %564 to i32*
  store i32 %563, i32* %565, align 8, !tbaa !24
  %566 = load %struct.entity*, %struct.entity** %250, align 8, !tbaa !10
  %567 = icmp eq %struct.entity* %566, null
  br i1 %567, label %568, label %596

; <label>:568                                     ; preds = %517
  %569 = getelementptr inbounds i8, i8* %308, i64 64
  %570 = bitcast %struct.entity** %250 to i8**
  call void @llvm.memset.p0i8.i64(i8* %569, i8 0, i64 16, i32 8, i1 false)
  store i8* %308, i8** %570, align 8, !tbaa !10
  %571 = tail call i8* @malloc(i64 64)
  %572 = getelementptr inbounds i8, i8* %308, i64 56
  %573 = bitcast i8* %572 to i8**
  store i8* %571, i8** %573, align 8, !tbaa !15
  %574 = icmp eq i8* %571, null
  br i1 %574, label %575, label %576

; <label>:575                                     ; preds = %568
  tail call void @exit(i32 -1) #10
  unreachable

; <label>:576                                     ; preds = %568
  call void @llvm.memset.p0i8.i64(i8* nonnull %571, i8 0, i64 64, i32 1, i1 false)
  %577 = load %struct.entity*, %struct.entity** %250, align 8, !tbaa !10
  %578 = getelementptr inbounds %struct.entity, %struct.entity* %577, i64 0, i32 6
  %579 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %578, i64 0, i32 0
  %580 = load %struct.UT_hash_table*, %struct.UT_hash_table** %579, align 8, !tbaa !15
  %581 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %580, i64 0, i32 4
  store %struct.UT_hash_handle* %578, %struct.UT_hash_handle** %581, align 8, !tbaa !27
  %582 = getelementptr inbounds %struct.entity, %struct.entity* %577, i64 0, i32 6, i32 0
  %583 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %580, i64 0, i32 1
  store i32 32, i32* %583, align 8, !tbaa !16
  %584 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %580, i64 0, i32 2
  store i32 5, i32* %584, align 4, !tbaa !28
  %585 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %580, i64 0, i32 5
  store i64 56, i64* %585, align 8, !tbaa !22
  %586 = tail call i8* @malloc(i64 512)
  %587 = bitcast %struct.UT_hash_table** %582 to i8***
  %588 = load i8**, i8*** %587, align 8, !tbaa !15
  store i8* %586, i8** %588, align 8, !tbaa !19
  %589 = icmp eq i8* %586, null
  br i1 %589, label %590, label %591

; <label>:590                                     ; preds = %576
  tail call void @exit(i32 -1) #10
  unreachable

; <label>:591                                     ; preds = %576
  call void @llvm.memset.p0i8.i64(i8* nonnull %586, i8 0, i64 512, i32 1, i1 false)
  %592 = load %struct.entity*, %struct.entity** %250, align 8, !tbaa !10
  %593 = getelementptr inbounds %struct.entity, %struct.entity* %592, i64 0, i32 6, i32 0
  %594 = load %struct.UT_hash_table*, %struct.UT_hash_table** %593, align 8, !tbaa !15
  %595 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %594, i64 0, i32 10
  store i32 -1609490463, i32* %595, align 8, !tbaa !29
  br label %615

; <label>:596                                     ; preds = %517
  %597 = getelementptr inbounds %struct.entity, %struct.entity* %566, i64 0, i32 6, i32 0
  %598 = bitcast %struct.UT_hash_table** %597 to i64*
  %599 = load i64, i64* %598, align 8, !tbaa !15
  %600 = bitcast i8* %557 to i64*
  store i64 %599, i64* %600, align 8, !tbaa !15
  %601 = getelementptr inbounds i8, i8* %308, i64 72
  %602 = bitcast i8* %601 to i8**
  store i8* null, i8** %602, align 8, !tbaa !30
  %603 = load %struct.UT_hash_table*, %struct.UT_hash_table** %597, align 8, !tbaa !15
  %604 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %603, i64 0, i32 4
  %605 = bitcast %struct.UT_hash_handle** %604 to i8**
  %606 = load i8*, i8** %605, align 8, !tbaa !27
  %607 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %603, i64 0, i32 5
  %608 = load i64, i64* %607, align 8, !tbaa !22
  %609 = sub i64 0, %608
  %610 = getelementptr inbounds i8, i8* %606, i64 %609
  %611 = getelementptr inbounds i8, i8* %308, i64 64
  %612 = bitcast i8* %611 to i8**
  store i8* %610, i8** %612, align 8, !tbaa !31
  %613 = getelementptr inbounds i8, i8* %606, i64 16
  %614 = bitcast i8* %613 to i8**
  store i8* %308, i8** %614, align 8, !tbaa !32
  store i8* %557, i8** %605, align 8, !tbaa !27
  br label %615

; <label>:615                                     ; preds = %596, %591
  %616 = phi %struct.UT_hash_table* [ %603, %596 ], [ %594, %591 ]
  %617 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %616, i64 0, i32 3
  %618 = load i32, i32* %617, align 8, !tbaa !33
  %619 = add i32 %618, 1
  store i32 %619, i32* %617, align 8, !tbaa !33
  %620 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %616, i64 0, i32 1
  %621 = load i32, i32* %620, align 8, !tbaa !16
  %622 = add i32 %621, -1
  %623 = and i32 %622, %556
  %624 = zext i32 %623 to i64
  %625 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %616, i64 0, i32 0
  %626 = load %struct.UT_hash_bucket*, %struct.UT_hash_bucket** %625, align 8, !tbaa !19
  %627 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %626, i64 %624, i32 1
  %628 = load i32, i32* %627, align 8, !tbaa !34
  %629 = add i32 %628, 1
  store i32 %629, i32* %627, align 8, !tbaa !34
  %630 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %626, i64 %624, i32 0
  %631 = bitcast %struct.UT_hash_handle** %630 to i64*
  %632 = load i64, i64* %631, align 8, !tbaa !20
  %633 = getelementptr inbounds i8, i8* %308, i64 88
  %634 = bitcast i8* %633 to i64*
  store i64 %632, i64* %634, align 8, !tbaa !35
  %635 = getelementptr inbounds i8, i8* %308, i64 80
  %636 = bitcast i8* %635 to %struct.UT_hash_handle**
  store %struct.UT_hash_handle* null, %struct.UT_hash_handle** %636, align 8, !tbaa !36
  %637 = icmp eq i64 %632, 0
  br i1 %637, label %642, label %638

; <label>:638                                     ; preds = %615
  %639 = inttoptr i64 %632 to %struct.UT_hash_handle*
  %640 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %639, i64 0, i32 3
  %641 = bitcast %struct.UT_hash_handle** %640 to i8**
  store i8* %557, i8** %641, align 8, !tbaa !36
  br label %642

; <label>:642                                     ; preds = %615, %638
  %643 = bitcast %struct.UT_hash_handle** %630 to i8**
  store i8* %557, i8** %643, align 8, !tbaa !20
  %644 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %626, i64 %624, i32 2
  %645 = load i32, i32* %644, align 4, !tbaa !37
  %646 = mul i32 %645, 10
  %647 = add i32 %646, 10
  %648 = icmp ult i32 %629, %647
  br i1 %648, label %792, label %649

; <label>:649                                     ; preds = %642
  %650 = bitcast i8* %557 to %struct.UT_hash_table**
  %651 = load %struct.UT_hash_table*, %struct.UT_hash_table** %650, align 8, !tbaa !38
  %652 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %651, i64 0, i32 9
  %653 = load i32, i32* %652, align 4, !tbaa !39
  %654 = icmp eq i32 %653, 1
  br i1 %654, label %789, label %655

; <label>:655                                     ; preds = %649
  %656 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %651, i64 0, i32 1
  %657 = load i32, i32* %656, align 8, !tbaa !16
  %658 = zext i32 %657 to i64
  %659 = shl nuw nsw i64 %658, 5
  %660 = tail call i8* @malloc(i64 %659)
  %661 = bitcast i8* %660 to %struct.UT_hash_bucket*
  %662 = icmp eq i8* %660, null
  br i1 %662, label %663, label %664

; <label>:663                                     ; preds = %655
  tail call void @exit(i32 -1) #10
  unreachable

; <label>:664                                     ; preds = %655
  %665 = load i32, i32* %656, align 8, !tbaa !16
  %666 = zext i32 %665 to i64
  %667 = shl nuw nsw i64 %666, 5
  %668 = tail call i64 @llvm.objectsize.i64.p0i8(i8* nonnull %660, i1 false)
  %669 = tail call i8* @__memset_chk(i8* nonnull %660, i32 0, i64 %667, i64 %668) #9
  %670 = load %struct.UT_hash_table*, %struct.UT_hash_table** %650, align 8, !tbaa !38
  %671 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %670, i64 0, i32 3
  %672 = load i32, i32* %671, align 8, !tbaa !33
  %673 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %670, i64 0, i32 2
  %674 = load i32, i32* %673, align 4, !tbaa !28
  %675 = add i32 %674, 1
  %676 = lshr i32 %672, %675
  %677 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %670, i64 0, i32 1
  %678 = load i32, i32* %677, align 8, !tbaa !16
  %679 = shl i32 %678, 1
  %680 = add i32 %679, -1
  %681 = and i32 %680, %672
  %682 = icmp ne i32 %681, 0
  %683 = zext i1 %682 to i32
  %684 = add i32 %683, %676
  %685 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %670, i64 0, i32 6
  store i32 %684, i32* %685, align 8, !tbaa !40
  %686 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %670, i64 0, i32 7
  store i32 0, i32* %686, align 4, !tbaa !41
  %687 = icmp eq i32 %678, 0
  br i1 %687, label %753, label %688

; <label>:688                                     ; preds = %664
  %689 = load %struct.UT_hash_table*, %struct.UT_hash_table** %650, align 8
  %690 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %689, i64 0, i32 1
  %691 = load i32, i32* %690, align 8
  %692 = zext i32 %691 to i64
  br label %693

; <label>:693                                     ; preds = %688, %749
  %694 = phi i64 [ 0, %688 ], [ %750, %749 ]
  %695 = phi %struct.UT_hash_table* [ %670, %688 ], [ %689, %749 ]
  %696 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %695, i64 0, i32 0
  %697 = load %struct.UT_hash_bucket*, %struct.UT_hash_bucket** %696, align 8, !tbaa !19
  %698 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %697, i64 %694, i32 0
  %699 = load %struct.UT_hash_handle*, %struct.UT_hash_handle** %698, align 8, !tbaa !20
  %700 = icmp eq %struct.UT_hash_handle* %699, null
  br i1 %700, label %749, label %701

; <label>:701                                     ; preds = %693
  %702 = load %struct.UT_hash_table*, %struct.UT_hash_table** %650, align 8
  %703 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %702, i64 0, i32 1
  %704 = load i32, i32* %703, align 8
  %705 = shl i32 %704, 1
  %706 = add i32 %705, -1
  %707 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %702, i64 0, i32 6
  %708 = bitcast i32* %707 to i64*
  %709 = load i64, i64* %708, align 8
  %710 = trunc i64 %709 to i32
  %711 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %702, i64 0, i32 7
  %712 = lshr i64 %709, 32
  %713 = trunc i64 %712 to i32
  br label %714

; <label>:714                                     ; preds = %701, %746
  %715 = phi i32 [ %713, %701 ], [ %736, %746 ]
  %716 = phi %struct.UT_hash_handle* [ %699, %701 ], [ %718, %746 ]
  %717 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %716, i64 0, i32 4
  %718 = load %struct.UT_hash_handle*, %struct.UT_hash_handle** %717, align 8, !tbaa !35
  %719 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %716, i64 0, i32 7
  %720 = load i32, i32* %719, align 4, !tbaa !42
  %721 = and i32 %706, %720
  %722 = zext i32 %721 to i64
  %723 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %661, i64 %722
  %724 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %661, i64 %722, i32 1
  %725 = load i32, i32* %724, align 8, !tbaa !34
  %726 = add i32 %725, 1
  store i32 %726, i32* %724, align 8, !tbaa !34
  %727 = icmp ugt i32 %726, %710
  br i1 %727, label %728, label %735

; <label>:728                                     ; preds = %714
  %729 = add i32 %715, 1
  store i32 %729, i32* %711, align 4, !tbaa !41
  %730 = load %struct.UT_hash_table*, %struct.UT_hash_table** %650, align 8, !tbaa !38
  %731 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %730, i64 0, i32 6
  %732 = load i32, i32* %731, align 8, !tbaa !40
  %733 = udiv i32 %726, %732
  %734 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %661, i64 %722, i32 2
  store i32 %733, i32* %734, align 4, !tbaa !37
  br label %735

; <label>:735                                     ; preds = %728, %714
  %736 = phi i32 [ %729, %728 ], [ %715, %714 ]
  %737 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %716, i64 0, i32 3
  store %struct.UT_hash_handle* null, %struct.UT_hash_handle** %737, align 8, !tbaa !36
  %738 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %723, i64 0, i32 0
  %739 = bitcast %struct.UT_hash_bucket* %723 to i64*
  %740 = load i64, i64* %739, align 8, !tbaa !20
  %741 = bitcast %struct.UT_hash_handle** %717 to i64*
  store i64 %740, i64* %741, align 8, !tbaa !35
  %742 = icmp eq i64 %740, 0
  br i1 %742, label %746, label %743

; <label>:743                                     ; preds = %735
  %744 = inttoptr i64 %740 to %struct.UT_hash_handle*
  %745 = getelementptr inbounds %struct.UT_hash_handle, %struct.UT_hash_handle* %744, i64 0, i32 3
  store %struct.UT_hash_handle* %716, %struct.UT_hash_handle** %745, align 8, !tbaa !36
  br label %746

; <label>:746                                     ; preds = %735, %743
  store %struct.UT_hash_handle* %716, %struct.UT_hash_handle** %738, align 8, !tbaa !20
  %747 = icmp eq %struct.UT_hash_handle* %718, null
  br i1 %747, label %748, label %714

; <label>:748                                     ; preds = %746
  br label %749

; <label>:749                                     ; preds = %748, %693
  %750 = add nuw nsw i64 %694, 1
  %751 = icmp ult i64 %750, %692
  br i1 %751, label %693, label %752

; <label>:752                                     ; preds = %749
  br label %753

; <label>:753                                     ; preds = %752, %664
  %754 = phi %struct.UT_hash_table* [ %670, %664 ], [ %689, %752 ]
  %755 = bitcast %struct.UT_hash_table* %754 to i8**
  %756 = load i8*, i8** %755, align 8, !tbaa !19
  tail call void @free(i8* %756)
  %757 = load %struct.UT_hash_table*, %struct.UT_hash_table** %650, align 8, !tbaa !38
  %758 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %757, i64 0, i32 1
  %759 = bitcast i32* %758 to i64*
  %760 = load i64, i64* %759, align 8
  %761 = trunc i64 %760 to i32
  %762 = shl i32 %761, 1
  store i32 %762, i32* %758, align 8, !tbaa !16
  %763 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %757, i64 0, i32 2
  %764 = lshr i64 %760, 32
  %765 = trunc i64 %764 to i32
  %766 = add i32 %765, 1
  store i32 %766, i32* %763, align 4, !tbaa !28
  %767 = bitcast %struct.UT_hash_table* %757 to i8**
  store i8* %660, i8** %767, align 8, !tbaa !19
  %768 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %757, i64 0, i32 7
  %769 = load i32, i32* %768, align 4, !tbaa !41
  %770 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %757, i64 0, i32 3
  %771 = load i32, i32* %770, align 8, !tbaa !33
  %772 = lshr i32 %771, 1
  %773 = icmp ugt i32 %769, %772
  br i1 %773, label %777, label %774

; <label>:774                                     ; preds = %753
  %775 = load %struct.UT_hash_table*, %struct.UT_hash_table** %650, align 8, !tbaa !38
  %776 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %775, i64 0, i32 8
  store i32 0, i32* %776, align 8, !tbaa !43
  br label %789

; <label>:777                                     ; preds = %753
  %778 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %757, i64 0, i32 8
  %779 = load i32, i32* %778, align 8, !tbaa !43
  %780 = add i32 %779, 1
  %781 = load %struct.UT_hash_table*, %struct.UT_hash_table** %650, align 8, !tbaa !38
  %782 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %781, i64 0, i32 8
  store i32 %780, i32* %782, align 8, !tbaa !43
  %783 = icmp ugt i32 %780, 1
  br i1 %783, label %784, label %789

; <label>:784                                     ; preds = %777
  %785 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %781, i64 0, i32 9
  store i32 1, i32* %785, align 4, !tbaa !39
  br label %789

; <label>:786                                     ; preds = %288
  %787 = phi i8* [ %276, %288 ]
  %788 = bitcast i8* %787 to %struct.entity*
  br label %789

; <label>:789                                     ; preds = %786, %774, %777, %784, %649
  %790 = phi %struct.entity* [ %309, %649 ], [ %309, %784 ], [ %309, %777 ], [ %309, %774 ], [ %788, %786 ]
  %791 = getelementptr inbounds %struct.entity, %struct.entity* %1, i64 0, i32 5
  store %struct.entity* null, %struct.entity** %791, align 8, !tbaa !44
  br label %795

; <label>:792                                     ; preds = %642
  %793 = getelementptr inbounds %struct.entity, %struct.entity* %1, i64 0, i32 5
  store %struct.entity* null, %struct.entity** %793, align 8, !tbaa !44
  %794 = icmp eq i8* %308, null
  br i1 %794, label %804, label %795

; <label>:795                                     ; preds = %792, %789
  %796 = phi %struct.entity* [ %790, %789 ], [ %309, %792 ]
  br label %797

; <label>:797                                     ; preds = %795, %797
  %798 = phi %struct.entity* [ %800, %797 ], [ %796, %795 ]
  %799 = getelementptr inbounds %struct.entity, %struct.entity* %798, i64 0, i32 5
  %800 = load %struct.entity*, %struct.entity** %799, align 8, !tbaa !44
  %801 = icmp eq %struct.entity* %800, null
  br i1 %801, label %802, label %797

; <label>:802                                     ; preds = %797
  %803 = phi %struct.entity** [ %799, %797 ]
  store %struct.entity* %1, %struct.entity** %803, align 8, !tbaa !44
  br label %804

; <label>:804                                     ; preds = %792, %802
  ret void
}

; Function Attrs: nounwind readonly
declare i64 @strlen(i8* nocapture) #2

; Function Attrs: nounwind readonly
declare i32 @memcmp(i8* nocapture, i8* nocapture, i64) #2

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #3

; Function Attrs: noreturn
declare void @exit(i32) #4

; Function Attrs: nounwind
declare i8* @__memset_chk(i8*, i32, i64, i64) #3

; Function Attrs: nounwind readnone
declare i64 @llvm.objectsize.i64.p0i8(i8*, i1) #5

; Function Attrs: nounwind
declare void @free(i8* nocapture) #3

; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @rect_intersect(i32, i32, i32, i32, i32, i32, i32, i32) #6 {
  %9 = add nsw i32 %6, %4
  %10 = icmp slt i32 %9, %0
  %11 = add nsw i32 %2, %0
  %12 = icmp slt i32 %11, %4
  %13 = or i1 %12, %10
  %14 = add nsw i32 %7, %5
  %15 = icmp slt i32 %14, %1
  %16 = or i1 %13, %15
  %17 = add nsw i32 %3, %1
  %18 = icmp slt i32 %17, %5
  %19 = or i1 %18, %16
  %20 = zext i1 %19 to i32
  ret i32 %20
}

; Function Attrs: norecurse nounwind readonly ssp uwtable
define i32 @ents_touching(%struct.entity* nocapture readonly, %struct.entity* nocapture readonly) #7 {
  %3 = getelementptr inbounds %struct.entity, %struct.entity* %0, i64 0, i32 2, i64 0
  %4 = bitcast i32* %3 to i64*
  %5 = load i64, i64* %4, align 8
  %6 = trunc i64 %5 to i32
  %7 = lshr i64 %5, 32
  %8 = trunc i64 %7 to i32
  %9 = getelementptr inbounds %struct.entity, %struct.entity* %0, i64 0, i32 1, i64 0
  %10 = bitcast i32* %9 to i64*
  %11 = load i64, i64* %10, align 8
  %12 = trunc i64 %11 to i32
  %13 = lshr i64 %11, 32
  %14 = trunc i64 %13 to i32
  %15 = getelementptr inbounds %struct.entity, %struct.entity* %1, i64 0, i32 2, i64 0
  %16 = bitcast i32* %15 to i64*
  %17 = load i64, i64* %16, align 8
  %18 = trunc i64 %17 to i32
  %19 = lshr i64 %17, 32
  %20 = trunc i64 %19 to i32
  %21 = getelementptr inbounds %struct.entity, %struct.entity* %1, i64 0, i32 1, i64 0
  %22 = bitcast i32* %21 to i64*
  %23 = load i64, i64* %22, align 8
  %24 = trunc i64 %23 to i32
  %25 = lshr i64 %23, 32
  %26 = trunc i64 %25 to i32
  %27 = add nsw i32 %24, %18
  %28 = icmp slt i32 %27, %6
  %29 = add nsw i32 %12, %6
  %30 = icmp slt i32 %29, %18
  %31 = or i1 %30, %28
  %32 = add nsw i32 %26, %20
  %33 = icmp slt i32 %32, %8
  %34 = or i1 %31, %33
  %35 = add nsw i32 %14, %8
  %36 = icmp slt i32 %35, %20
  %37 = or i1 %36, %34
  %38 = zext i1 %37 to i32
  ret i32 %38
}

; Function Attrs: nounwind ssp uwtable
define void @chk_collision(%struct.entity*, i8* readonly, void (%struct.entity*, %struct.entity*)* nocapture) #0 {
  %4 = tail call i64 @strlen(i8* %1)
  %5 = trunc i64 %4 to i32
  %6 = icmp ugt i32 %5, 11
  br i1 %6, label %7, label %115

; <label>:7                                       ; preds = %3
  br label %8

; <label>:8                                       ; preds = %7, %8
  %9 = phi i32 [ %105, %8 ], [ -17973521, %7 ]
  %10 = phi i8* [ %106, %8 ], [ %1, %7 ]
  %11 = phi i32 [ %107, %8 ], [ %5, %7 ]
  %12 = phi i32 [ %101, %8 ], [ -1640531527, %7 ]
  %13 = phi i32 [ %97, %8 ], [ -1640531527, %7 ]
  %14 = load i8, i8* %10, align 1, !tbaa !14
  %15 = zext i8 %14 to i32
  %16 = getelementptr inbounds i8, i8* %10, i64 1
  %17 = load i8, i8* %16, align 1, !tbaa !14
  %18 = zext i8 %17 to i32
  %19 = shl nuw nsw i32 %18, 8
  %20 = or i32 %19, %15
  %21 = getelementptr inbounds i8, i8* %10, i64 2
  %22 = load i8, i8* %21, align 1, !tbaa !14
  %23 = zext i8 %22 to i32
  %24 = shl nuw nsw i32 %23, 16
  %25 = or i32 %20, %24
  %26 = getelementptr inbounds i8, i8* %10, i64 3
  %27 = load i8, i8* %26, align 1, !tbaa !14
  %28 = zext i8 %27 to i32
  %29 = shl nuw i32 %28, 24
  %30 = or i32 %25, %29
  %31 = add i32 %30, %13
  %32 = getelementptr inbounds i8, i8* %10, i64 4
  %33 = load i8, i8* %32, align 1, !tbaa !14
  %34 = zext i8 %33 to i32
  %35 = getelementptr inbounds i8, i8* %10, i64 5
  %36 = load i8, i8* %35, align 1, !tbaa !14
  %37 = zext i8 %36 to i32
  %38 = shl nuw nsw i32 %37, 8
  %39 = or i32 %38, %34
  %40 = getelementptr inbounds i8, i8* %10, i64 6
  %41 = load i8, i8* %40, align 1, !tbaa !14
  %42 = zext i8 %41 to i32
  %43 = shl nuw nsw i32 %42, 16
  %44 = or i32 %39, %43
  %45 = getelementptr inbounds i8, i8* %10, i64 7
  %46 = load i8, i8* %45, align 1, !tbaa !14
  %47 = zext i8 %46 to i32
  %48 = shl nuw i32 %47, 24
  %49 = or i32 %44, %48
  %50 = add i32 %49, %12
  %51 = getelementptr inbounds i8, i8* %10, i64 8
  %52 = load i8, i8* %51, align 1, !tbaa !14
  %53 = zext i8 %52 to i32
  %54 = getelementptr inbounds i8, i8* %10, i64 9
  %55 = load i8, i8* %54, align 1, !tbaa !14
  %56 = zext i8 %55 to i32
  %57 = shl nuw nsw i32 %56, 8
  %58 = or i32 %57, %53
  %59 = getelementptr inbounds i8, i8* %10, i64 10
  %60 = load i8, i8* %59, align 1, !tbaa !14
  %61 = zext i8 %60 to i32
  %62 = shl nuw nsw i32 %61, 16
  %63 = or i32 %58, %62
  %64 = getelementptr inbounds i8, i8* %10, i64 11
  %65 = load i8, i8* %64, align 1, !tbaa !14
  %66 = zext i8 %65 to i32
  %67 = shl nuw i32 %66, 24
  %68 = or i32 %63, %67
  %69 = add i32 %68, %9
  %70 = sub i32 %31, %50
  %71 = sub i32 %70, %69
  %72 = lshr i32 %69, 13
  %73 = xor i32 %71, %72
  %74 = sub i32 %50, %69
  %75 = sub i32 %74, %73
  %76 = shl i32 %73, 8
  %77 = xor i32 %75, %76
  %78 = sub i32 %69, %73
  %79 = sub i32 %78, %77
  %80 = lshr i32 %77, 13
  %81 = xor i32 %79, %80
  %82 = sub i32 %73, %77
  %83 = sub i32 %82, %81
  %84 = lshr i32 %81, 12
  %85 = xor i32 %83, %84
  %86 = sub i32 %77, %81
  %87 = sub i32 %86, %85
  %88 = shl i32 %85, 16
  %89 = xor i32 %87, %88
  %90 = sub i32 %81, %85
  %91 = sub i32 %90, %89
  %92 = lshr i32 %89, 5
  %93 = xor i32 %91, %92
  %94 = sub i32 %85, %89
  %95 = sub i32 %94, %93
  %96 = lshr i32 %93, 3
  %97 = xor i32 %95, %96
  %98 = sub i32 %89, %93
  %99 = sub i32 %98, %97
  %100 = shl i32 %97, 10
  %101 = xor i32 %99, %100
  %102 = sub i32 %93, %97
  %103 = sub i32 %102, %101
  %104 = lshr i32 %101, 15
  %105 = xor i32 %103, %104
  %106 = getelementptr inbounds i8, i8* %10, i64 12
  %107 = add i32 %11, -12
  %108 = icmp ugt i32 %107, 11
  br i1 %108, label %8, label %109

; <label>:109                                     ; preds = %8
  %110 = phi i32 [ %107, %8 ]
  %111 = phi i8* [ %106, %8 ]
  %112 = phi i32 [ %105, %8 ]
  %113 = phi i32 [ %101, %8 ]
  %114 = phi i32 [ %97, %8 ]
  br label %115

; <label>:115                                     ; preds = %109, %3
  %116 = phi i32 [ -17973521, %3 ], [ %112, %109 ]
  %117 = phi i8* [ %1, %3 ], [ %111, %109 ]
  %118 = phi i32 [ %5, %3 ], [ %110, %109 ]
  %119 = phi i32 [ -1640531527, %3 ], [ %113, %109 ]
  %120 = phi i32 [ -1640531527, %3 ], [ %114, %109 ]
  %121 = tail call i64 @strlen(i8* %1)
  %122 = trunc i64 %121 to i32
  %123 = add i32 %122, %116
  switch i32 %118, label %207 [
    i32 11, label %124
    i32 10, label %130
    i32 9, label %137
    i32 8, label %144
    i32 7, label %151
    i32 6, label %159
    i32 5, label %167
    i32 4, label %174
    i32 3, label %182
    i32 2, label %191
    i32 1, label %200
  ]

; <label>:124                                     ; preds = %115
  %125 = getelementptr inbounds i8, i8* %117, i64 10
  %126 = load i8, i8* %125, align 1, !tbaa !14
  %127 = zext i8 %126 to i32
  %128 = shl nuw i32 %127, 24
  %129 = add i32 %128, %123
  br label %130

; <label>:130                                     ; preds = %115, %124
  %131 = phi i32 [ %123, %115 ], [ %129, %124 ]
  %132 = getelementptr inbounds i8, i8* %117, i64 9
  %133 = load i8, i8* %132, align 1, !tbaa !14
  %134 = zext i8 %133 to i32
  %135 = shl nuw nsw i32 %134, 16
  %136 = add i32 %135, %131
  br label %137

; <label>:137                                     ; preds = %115, %130
  %138 = phi i32 [ %123, %115 ], [ %136, %130 ]
  %139 = getelementptr inbounds i8, i8* %117, i64 8
  %140 = load i8, i8* %139, align 1, !tbaa !14
  %141 = zext i8 %140 to i32
  %142 = shl nuw nsw i32 %141, 8
  %143 = add i32 %142, %138
  br label %144

; <label>:144                                     ; preds = %115, %137
  %145 = phi i32 [ %123, %115 ], [ %143, %137 ]
  %146 = getelementptr inbounds i8, i8* %117, i64 7
  %147 = load i8, i8* %146, align 1, !tbaa !14
  %148 = zext i8 %147 to i32
  %149 = shl nuw i32 %148, 24
  %150 = add i32 %149, %119
  br label %151

; <label>:151                                     ; preds = %115, %144
  %152 = phi i32 [ %119, %115 ], [ %150, %144 ]
  %153 = phi i32 [ %123, %115 ], [ %145, %144 ]
  %154 = getelementptr inbounds i8, i8* %117, i64 6
  %155 = load i8, i8* %154, align 1, !tbaa !14
  %156 = zext i8 %155 to i32
  %157 = shl nuw nsw i32 %156, 16
  %158 = add i32 %157, %152
  br label %159

; <label>:159                                     ; preds = %115, %151
  %160 = phi i32 [ %119, %115 ], [ %158, %151 ]
  %161 = phi i32 [ %123, %115 ], [ %153, %151 ]
  %162 = getelementptr inbounds i8, i8* %117, i64 5
  %163 = load i8, i8* %162, align 1, !tbaa !14
  %164 = zext i8 %163 to i32
  %165 = shl nuw nsw i32 %164, 8
  %166 = add i32 %165, %160
  br label %167

; <label>:167                                     ; preds = %115, %159
  %168 = phi i32 [ %119, %115 ], [ %166, %159 ]
  %169 = phi i32 [ %123, %115 ], [ %161, %159 ]
  %170 = getelementptr inbounds i8, i8* %117, i64 4
  %171 = load i8, i8* %170, align 1, !tbaa !14
  %172 = zext i8 %171 to i32
  %173 = add i32 %172, %168
  br label %174

; <label>:174                                     ; preds = %115, %167
  %175 = phi i32 [ %119, %115 ], [ %173, %167 ]
  %176 = phi i32 [ %123, %115 ], [ %169, %167 ]
  %177 = getelementptr inbounds i8, i8* %117, i64 3
  %178 = load i8, i8* %177, align 1, !tbaa !14
  %179 = zext i8 %178 to i32
  %180 = shl nuw i32 %179, 24
  %181 = add i32 %180, %120
  br label %182

; <label>:182                                     ; preds = %115, %174
  %183 = phi i32 [ %120, %115 ], [ %181, %174 ]
  %184 = phi i32 [ %119, %115 ], [ %175, %174 ]
  %185 = phi i32 [ %123, %115 ], [ %176, %174 ]
  %186 = getelementptr inbounds i8, i8* %117, i64 2
  %187 = load i8, i8* %186, align 1, !tbaa !14
  %188 = zext i8 %187 to i32
  %189 = shl nuw nsw i32 %188, 16
  %190 = add i32 %189, %183
  br label %191

; <label>:191                                     ; preds = %115, %182
  %192 = phi i32 [ %120, %115 ], [ %190, %182 ]
  %193 = phi i32 [ %119, %115 ], [ %184, %182 ]
  %194 = phi i32 [ %123, %115 ], [ %185, %182 ]
  %195 = getelementptr inbounds i8, i8* %117, i64 1
  %196 = load i8, i8* %195, align 1, !tbaa !14
  %197 = zext i8 %196 to i32
  %198 = shl nuw nsw i32 %197, 8
  %199 = add i32 %198, %192
  br label %200

; <label>:200                                     ; preds = %115, %191
  %201 = phi i32 [ %120, %115 ], [ %199, %191 ]
  %202 = phi i32 [ %119, %115 ], [ %193, %191 ]
  %203 = phi i32 [ %123, %115 ], [ %194, %191 ]
  %204 = load i8, i8* %117, align 1, !tbaa !14
  %205 = zext i8 %204 to i32
  %206 = add i32 %205, %201
  br label %207

; <label>:207                                     ; preds = %115, %200
  %208 = phi i32 [ %120, %115 ], [ %206, %200 ]
  %209 = phi i32 [ %119, %115 ], [ %202, %200 ]
  %210 = phi i32 [ %123, %115 ], [ %203, %200 ]
  %211 = sub i32 %208, %209
  %212 = sub i32 %211, %210
  %213 = lshr i32 %210, 13
  %214 = xor i32 %212, %213
  %215 = sub i32 %209, %210
  %216 = sub i32 %215, %214
  %217 = shl i32 %214, 8
  %218 = xor i32 %216, %217
  %219 = sub i32 %210, %214
  %220 = sub i32 %219, %218
  %221 = lshr i32 %218, 13
  %222 = xor i32 %220, %221
  %223 = sub i32 %214, %218
  %224 = sub i32 %223, %222
  %225 = lshr i32 %222, 12
  %226 = xor i32 %224, %225
  %227 = sub i32 %218, %222
  %228 = sub i32 %227, %226
  %229 = shl i32 %226, 16
  %230 = xor i32 %228, %229
  %231 = sub i32 %222, %226
  %232 = sub i32 %231, %230
  %233 = lshr i32 %230, 5
  %234 = xor i32 %232, %233
  %235 = sub i32 %226, %230
  %236 = sub i32 %235, %234
  %237 = lshr i32 %234, 3
  %238 = xor i32 %236, %237
  %239 = sub i32 %230, %234
  %240 = sub i32 %239, %238
  %241 = shl i32 %238, 10
  %242 = xor i32 %240, %241
  %243 = sub i32 %234, %238
  %244 = sub i32 %243, %242
  %245 = lshr i32 %242, 15
  %246 = xor i32 %244, %245
  %247 = load %struct.gameboard*, %struct.gameboard** @current_board, align 8, !tbaa !45
  %248 = getelementptr inbounds %struct.gameboard, %struct.gameboard* %247, i64 0, i32 3
  %249 = load %struct.entity*, %struct.entity** %248, align 8, !tbaa !10
  %250 = icmp eq %struct.entity* %249, null
  br i1 %250, label %353, label %251

; <label>:251                                     ; preds = %207
  %252 = getelementptr inbounds %struct.entity, %struct.entity* %249, i64 0, i32 6, i32 0
  %253 = load %struct.UT_hash_table*, %struct.UT_hash_table** %252, align 8, !tbaa !15
  %254 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %253, i64 0, i32 1
  %255 = load i32, i32* %254, align 8, !tbaa !16
  %256 = add i32 %255, -1
  %257 = and i32 %256, %246
  %258 = zext i32 %257 to i64
  %259 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %253, i64 0, i32 0
  %260 = load %struct.UT_hash_bucket*, %struct.UT_hash_bucket** %259, align 8, !tbaa !19
  %261 = getelementptr inbounds %struct.UT_hash_bucket, %struct.UT_hash_bucket* %260, i64 %258, i32 0
  %262 = load %struct.UT_hash_handle*, %struct.UT_hash_handle** %261, align 8, !tbaa !20
  %263 = icmp eq %struct.UT_hash_handle* %262, null
  br i1 %263, label %353, label %264

; <label>:264                                     ; preds = %251
  %265 = bitcast %struct.UT_hash_handle* %262 to i8*
  %266 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %253, i64 0, i32 5
  %267 = load i64, i64* %266, align 8, !tbaa !22
  %268 = sub i64 0, %267
  %269 = getelementptr inbounds i8, i8* %265, i64 %268
  %270 = icmp eq i8* %269, null
  br i1 %270, label %353, label %271

; <label>:271                                     ; preds = %264
  %272 = getelementptr inbounds %struct.UT_hash_table, %struct.UT_hash_table* %253, i64 0, i32 5
  br label %273

; <label>:273                                     ; preds = %271, %305
  %274 = phi i8* [ %309, %305 ], [ %269, %271 ]
  %275 = getelementptr inbounds i8, i8* %274, i64 108
  %276 = bitcast i8* %275 to i32*
  %277 = load i32, i32* %276, align 4, !tbaa !23
  %278 = icmp eq i32 %277, %246
  br i1 %278, label %279, label %300

; <label>:279                                     ; preds = %273
  %280 = getelementptr inbounds i8, i8* %274, i64 104
  %281 = bitcast i8* %280 to i32*
  %282 = load i32, i32* %281, align 8, !tbaa !24
  %283 = tail call i64 @strlen(i8* %1)
  %284 = trunc i64 %283 to i32
  %285 = icmp eq i32 %282, %284
  br i1 %285, label %286, label %300

; <label>:286                                     ; preds = %279
  %287 = getelementptr inbounds i8, i8* %274, i64 96
  %288 = bitcast i8* %287 to i8**
  %289 = load i8*, i8** %288, align 8, !tbaa !25
  %290 = and i64 %283, 4294967295
  %291 = tail call i32 @memcmp(i8* %289, i8* %1, i64 %290)
  %292 = icmp eq i32 %291, 0
  br i1 %292, label %293, label %300

; <label>:293                                     ; preds = %286
  %294 = phi i8* [ %274, %286 ]
  %295 = bitcast i8* %294 to %struct.entity*
  %296 = getelementptr inbounds %struct.entity, %struct.entity* %0, i64 0, i32 2, i64 0
  %297 = bitcast i32* %296 to i64*
  %298 = getelementptr inbounds %struct.entity, %struct.entity* %0, i64 0, i32 1, i64 0
  %299 = bitcast i32* %298 to i64*
  br label %311

; <label>:300                                     ; preds = %286, %279, %273
  %301 = getelementptr inbounds i8, i8* %274, i64 88
  %302 = bitcast i8* %301 to %struct.UT_hash_handle**
  %303 = load %struct.UT_hash_handle*, %struct.UT_hash_handle** %302, align 8, !tbaa !26
  %304 = icmp eq %struct.UT_hash_handle* %303, null
  br i1 %304, label %352, label %305

; <label>:305                                     ; preds = %300
  %306 = bitcast %struct.UT_hash_handle* %303 to i8*
  %307 = load i64, i64* %272, align 8, !tbaa !22
  %308 = sub i64 0, %307
  %309 = getelementptr inbounds i8, i8* %306, i64 %308
  %310 = icmp eq i8* %309, null
  br i1 %310, label %352, label %273

; <label>:311                                     ; preds = %293, %349
  %312 = phi %struct.entity* [ %295, %293 ], [ %314, %349 ]
  %313 = getelementptr inbounds %struct.entity, %struct.entity* %312, i64 0, i32 5
  %314 = load %struct.entity*, %struct.entity** %313, align 8, !tbaa !44
  %315 = icmp eq %struct.entity* %312, %0
  br i1 %315, label %349, label %316

; <label>:316                                     ; preds = %311
  %317 = load i64, i64* %297, align 8
  %318 = trunc i64 %317 to i32
  %319 = lshr i64 %317, 32
  %320 = trunc i64 %319 to i32
  %321 = load i64, i64* %299, align 8
  %322 = trunc i64 %321 to i32
  %323 = lshr i64 %321, 32
  %324 = trunc i64 %323 to i32
  %325 = getelementptr inbounds %struct.entity, %struct.entity* %312, i64 0, i32 2, i64 0
  %326 = bitcast i32* %325 to i64*
  %327 = load i64, i64* %326, align 8
  %328 = trunc i64 %327 to i32
  %329 = lshr i64 %327, 32
  %330 = trunc i64 %329 to i32
  %331 = getelementptr inbounds %struct.entity, %struct.entity* %312, i64 0, i32 1, i64 0
  %332 = bitcast i32* %331 to i64*
  %333 = load i64, i64* %332, align 8
  %334 = trunc i64 %333 to i32
  %335 = lshr i64 %333, 32
  %336 = trunc i64 %335 to i32
  %337 = add nsw i32 %334, %328
  %338 = icmp slt i32 %337, %318
  %339 = add nsw i32 %322, %318
  %340 = icmp slt i32 %339, %328
  %341 = or i1 %340, %338
  %342 = add nsw i32 %336, %330
  %343 = icmp slt i32 %342, %320
  %344 = or i1 %341, %343
  %345 = add nsw i32 %324, %320
  %346 = icmp slt i32 %345, %330
  %347 = or i1 %346, %344
  br i1 %347, label %348, label %349

; <label>:348                                     ; preds = %316
  tail call void %2(%struct.entity* nonnull %0, %struct.entity* nonnull %312) #9
  br label %349

; <label>:349                                     ; preds = %348, %311, %316
  %350 = icmp eq %struct.entity* %314, null
  br i1 %350, label %351, label %311

; <label>:351                                     ; preds = %349
  br label %353

; <label>:352                                     ; preds = %305, %300
  br label %353

; <label>:353                                     ; preds = %352, %351, %251, %264, %207
  ret void
}

; Function Attrs: norecurse nounwind readnone ssp uwtable
define void @chk_keypress(i32) #6 {
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #8

attributes #0 = { nounwind ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+sse4.1,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+sse4.1,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+sse4.1,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+sse4.1,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+sse4.1,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind readnone }
attributes #6 = { norecurse nounwind readnone ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+sse4.1,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { norecurse nounwind readonly ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+sse4.1,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #8 = { argmemonly nounwind }
attributes #9 = { nounwind }
attributes #10 = { noreturn nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"Apple LLVM version 8.0.0 (clang-800.0.42.1)"}
!2 = !{!3, !4, i64 0}
!3 = !{!"gameboard", !4, i64 0, !5, i64 8, !5, i64 16, !4, i64 32, !4, i64 40, !7, i64 48}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C/C++ TBAA"}
!7 = !{!"UT_hash_handle", !4, i64 0, !4, i64 8, !4, i64 16, !4, i64 24, !4, i64 32, !4, i64 40, !8, i64 48, !8, i64 52}
!8 = !{!"int", !5, i64 0}
!9 = !{!8, !8, i64 0}
!10 = !{!3, !4, i64 32}
!11 = !{!3, !4, i64 40}
!12 = !{!13, !4, i64 0}
!13 = !{!"entity", !4, i64 0, !5, i64 8, !5, i64 16, !5, i64 24, !4, i64 40, !4, i64 48, !7, i64 56}
!14 = !{!5, !5, i64 0}
!15 = !{!13, !4, i64 56}
!16 = !{!17, !8, i64 8}
!17 = !{!"UT_hash_table", !4, i64 0, !8, i64 8, !8, i64 12, !8, i64 16, !4, i64 24, !18, i64 32, !8, i64 40, !8, i64 44, !8, i64 48, !8, i64 52, !8, i64 56}
!18 = !{!"long", !5, i64 0}
!19 = !{!17, !4, i64 0}
!20 = !{!21, !4, i64 0}
!21 = !{!"UT_hash_bucket", !4, i64 0, !8, i64 8, !8, i64 12}
!22 = !{!17, !18, i64 32}
!23 = !{!13, !8, i64 108}
!24 = !{!13, !8, i64 104}
!25 = !{!13, !4, i64 96}
!26 = !{!13, !4, i64 88}
!27 = !{!17, !4, i64 24}
!28 = !{!17, !8, i64 12}
!29 = !{!17, !8, i64 56}
!30 = !{!13, !4, i64 72}
!31 = !{!13, !4, i64 64}
!32 = !{!7, !4, i64 16}
!33 = !{!17, !8, i64 16}
!34 = !{!21, !8, i64 8}
!35 = !{!7, !4, i64 32}
!36 = !{!7, !4, i64 24}
!37 = !{!21, !8, i64 12}
!38 = !{!7, !4, i64 0}
!39 = !{!17, !8, i64 52}
!40 = !{!17, !8, i64 40}
!41 = !{!17, !8, i64 44}
!42 = !{!7, !8, i64 52}
!43 = !{!17, !8, i64 48}
!44 = !{!13, !4, i64 48}
!45 = !{!4, !4, i64 0}
