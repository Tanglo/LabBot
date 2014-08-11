//
//  DRHDataColumn.h
//  LabBot
//
//  Created by Lee Walsh on 11/08/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRHDataColumn : NSObject <NSCoding>

@property NSString *columnName;
@property NSArray *columnData;

-(DRHDataColumn *)initWithName:(NSString *)name AndArray:(NSArray *)array;
-(NSArray *)data;
-(NSInteger)count;
-(id)rowAtIndex:(NSInteger)index;
+(DRHDataColumn *)dataColumnWithName:(NSString *)name AndArray:(NSArray *)array;
+(DRHDataColumn *)dataColumnWithName:(NSString *)name OfNanWithLength:(NSInteger)length;
+(DRHDataColumn *)linearDataColumnWithName:(NSString *)name OfIntegersFrom:(NSInteger)start To:(NSInteger)end WithIncrement:(NSInteger)increment AndRepetitions:(NSInteger)repetitions;
+(DRHDataColumn *)linearDataColumnWithName:(NSString *)name OfDoublesFrom:(CGFloat)start To:(CGFloat)end WithIncrement:(CGFloat)increment AndRepetitions:(NSInteger)repetitions;
+(DRHDataColumn *)dataColumnWithName:(NSString *)name ByRepeatingArray:(NSArray *)array WithRepetitions:(NSInteger)repetitions;
+(DRHDataColumn *)shuffledDataColumnWithName:(NSString *)name And:(NSArray *)array;
-(DRHDataColumn *)dataColumnByFillingWithObject:(id)object ToLength:(NSInteger)length;
-(DRHDataColumn *)dataColumnByCropingToLength:(NSInteger)length;

@end
