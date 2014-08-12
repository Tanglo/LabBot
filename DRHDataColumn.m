//
//  DRHDataColumn.m
//  LabBot
//
//  Created by Lee Walsh on 11/08/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import "DRHDataColumn.h"

@implementation DRHDataColumn

-(id)init{
    if (self = [super init]) {
        _columnName = nil;
        _columnData = nil;
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        _columnName = [aDecoder decodeObjectForKey:@"columnName"];
        if (!_columnName) {
            _columnName = nil;
        }
        _columnData = [aDecoder decodeObjectForKey:@"columnData"];
        if (!_columnData) {
            _columnData = nil;
        }
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_columnName forKey:@"columnName"];
    [aCoder encodeObject:_columnData forKey:@"columnData"];
}

-(DRHDataColumn *)initWithName:(NSString *)name AndArray:(NSArray *)array{
    if (self = [super init]) {
        _columnName = name;
        _columnData = array;
    }
    return self;
}

-(NSArray *)data{
    return _columnData;
}

-(NSInteger)count{
    return [_columnData count];
}

-(id)rowAtIndex:(NSInteger)index{
    return [_columnData objectAtIndex:index];
}

+(DRHDataColumn *)dataColumnWithName:(NSString *)name AndArray:(NSArray *)array{
    DRHDataColumn *newArray = [[self alloc] initWithName:name AndArray:array];
    return newArray;
}

+(DRHDataColumn *)dataColumnWithName:(NSString *)name OfNanWithLength:(NSInteger)length{
    NSMutableArray *newArray = [NSMutableArray array];
    for (NSInteger i=0; i<length; i++) {
        [newArray addObject:[NSDecimalNumber notANumber]];
    }
    return [DRHDataColumn dataColumnWithName:name AndArray:newArray];
}

+(DRHDataColumn *)linearDataColumnWithName:(NSString *)name OfIntegersFrom:(NSInteger)start To:(NSInteger)end WithIncrement:(NSInteger)increment AndRepetitions:(NSInteger)repetitions{
    NSMutableArray *newArray = [NSMutableArray array];
    for (NSInteger i=start; i<=end; i+=increment) {
        for (NSInteger j=0; j<repetitions; j++) {
            [newArray addObject:[NSDecimalNumber numberWithInteger:i]];
        }
    }
    return [DRHDataColumn dataColumnWithName:name AndArray:newArray];
}

+(DRHDataColumn *)linearDataColumnWithName:(NSString *)name OfDoublesFrom:(CGFloat)start To:(CGFloat)end WithIncrement:(CGFloat)increment AndRepetitions:(NSInteger)repetitions{
    NSMutableArray *newArray = [NSMutableArray array];
    CGFloat currentDouble = start;
    do {
        for (NSInteger j=0; j<repetitions; j++) {
            [newArray addObject:[NSDecimalNumber numberWithDouble:currentDouble]];
        }
        currentDouble += increment;
    } while (currentDouble < end);
    return [DRHDataColumn dataColumnWithName:name AndArray:newArray];
}

+(DRHDataColumn *)dataColumnWithName:(NSString *)name ByRepeatingArray:(NSArray *)array WithRepetitions:(NSInteger)repetitions{
    NSMutableArray *newArray = [NSMutableArray array];
    for (NSInteger i=0; i<repetitions; i++) {
        [newArray addObjectsFromArray:array];
    }
    return [DRHDataColumn dataColumnWithName:name AndArray:newArray];
}

+(DRHDataColumn *)shuffledDataColumnWithName:(NSString *)name And:(NSArray *)array{
    NSMutableArray *temp = [[NSMutableArray alloc] initWithArray:array];
    
    for(NSUInteger i = [array count]; i > 1; i--) {
        NSUInteger j = arc4random_uniform((uint32)i);
        [temp exchangeObjectAtIndex:i-1 withObjectAtIndex:j];
    }
    
    return [DRHDataColumn dataColumnWithName:name AndArray:temp];
}

-(DRHDataColumn *)dataColumnByFillingWithObject:(id)object ToLength:(NSInteger)length{
    NSMutableArray *newDataArray = [NSMutableArray arrayWithArray:_columnData];
    for (NSInteger i=[newDataArray count]; i<length; i++)
        [newDataArray addObject:object];
    return [DRHDataColumn dataColumnWithName:_columnName AndArray:newDataArray];
}

-(DRHDataColumn *)dataColumnByCropingToLength:(NSInteger)length{
    NSMutableArray *newDataArray = [NSMutableArray arrayWithArray:_columnData];
    while ([newDataArray count] > length) {
        [newDataArray removeLastObject];
    }
    return [DRHDataColumn dataColumnWithName:_columnName AndArray:newDataArray];
}

@end
