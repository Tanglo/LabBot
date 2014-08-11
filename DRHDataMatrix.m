//
//  DRHDataMatrix.m
//  LabBot
//
//  Created by Lee Walsh on 11/08/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import "DRHDataMatrix.h"
#import "DRHDataColumn.h"

NSString * const DRHDataMatrixFactorsKey = @"trialMatrixFactors";
NSString * const DRHDataMatrixFactorNamesKey = @"trialMatrixFactorNames";

@implementation DRHDataMatrix

-(id)init{
    if (self = [super init]) {
        _names = nil;
        _data = nil;
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        _names = [aDecoder decodeObjectForKey:@"names"];
        if (!_names) {
            _names = nil;
        }
        _data = [aDecoder decodeObjectForKey:@"dataArray"];
        if (!_data) {
            _data = nil;
        }
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_names forKey:@"names"];
    [aCoder encodeObject:_data forKey:@"data"];
}


-(DRHDataMatrix *)initWithRowArrays:(NSArray *)rowArrays{
    if (self = [super init]) {
        _names = nil;
        _data = rowArrays;
    }
    return self;
}

+(DRHDataMatrix *)dataMatrixWithColumnArrays:(NSArray *)dataArrays{
    NSInteger numberOfColumns = [dataArrays count];
    NSInteger numberOfRows = [[dataArrays objectAtIndex:0] count];
    NSMutableArray *newTrialRows = [NSMutableArray array];
    for (NSInteger i=0; i<numberOfRows; i++) {
        NSMutableArray *newRowArray = [NSMutableArray array];
        for (NSInteger j=0; j<numberOfColumns; j++) {
            [newRowArray addObject:[[dataArrays objectAtIndex:j] rowAtIndex:i]];
        }
        [newTrialRows addObject:newRowArray];
    }
    DRHDataMatrix *newDataMatrix = [[DRHDataMatrix alloc] initWithRowArrays:newTrialRows];
    NSMutableArray *newNameArray = [NSMutableArray array];
    for (NSInteger i=0; i<numberOfColumns; i++) {
        [newNameArray addObject:[[dataArrays objectAtIndex:i] columnName]];
    }
    [newDataMatrix setNames:[NSArray arrayWithArray:newNameArray]];
    return newDataMatrix;
}

-(NSInteger)rowCount{
    return [_data count];
}

-(NSInteger)columnCount{
    return [_names count];
}

-(NSArray *)dataRowAtIndex:(NSInteger)index{
    return [_data objectAtIndex:index];
}

-(DRHDataColumn *)dataColumnAtIndex:(NSInteger)index{
    NSMutableArray *newDataColumnArray = [NSMutableArray array];
    for (NSArray *rowArray in _data){
        [newDataColumnArray addObject:[rowArray objectAtIndex:index]];
    }
    return [DRHDataColumn dataColumnWithName:[_names objectAtIndex:index] AndArray:newDataColumnArray];
}

-(DRHDataColumn *)dataColumnWithName:(NSString *)name{
    NSInteger index = [_names indexOfObject:name];
    if (index == NSNotFound)
        return nil;
    return [self dataColumnAtIndex:index];
}

-(DRHDataMatrix *)dataMatrixByAddingDataColumn:(DRHDataColumn *)dataColumn{
    if ([_data count] == [dataColumn count]) {
        NSMutableArray *dataColumnArray = [NSMutableArray array];
        for (NSInteger i=0; i<[self columnCount]; i++) {
            [dataColumnArray addObject:[self dataColumnAtIndex:i]];
        }
        [dataColumnArray addObject:dataColumn];
        return [DRHDataMatrix dataMatrixWithColumnArrays:dataColumnArray];
    }
    return nil;
}

-(DRHDataMatrix *)dataMatrixByInsertingColumn:(DRHDataColumn *)dataColumn AtIndex:(NSInteger)index{
    if ([_data count] == [dataColumn count]) {
        NSMutableArray *dataColumnArray = [NSMutableArray array];
        for (NSInteger i=0; i<index; i++) {
            [dataColumnArray addObject:[self dataColumnAtIndex:i]];
        }
        [dataColumnArray addObject:dataColumn];
        for (NSInteger i=index; i<[self columnCount]; i++) {
            [dataColumnArray addObject:[self dataColumnAtIndex:i]];
        }
        return [DRHDataMatrix dataMatrixWithColumnArrays:dataColumnArray];
    }
    return nil;
}

-(void)shuffleRows{
    NSMutableArray *temp = [[NSMutableArray alloc] initWithArray:_data];
    
    for(NSUInteger i = [_data count]; i > 1; i--) {
        NSUInteger j = arc4random_uniform((uint32)i);
        [temp exchangeObjectAtIndex:i-1 withObjectAtIndex:j];
    }
    _data = temp;
}

@end
