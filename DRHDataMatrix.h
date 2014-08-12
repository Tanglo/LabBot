//
//  DRHDataMatrix.h
//  LabBot
//
//  Created by Lee Walsh on 11/08/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const DRHDataMatrixFactorsKey;
extern NSString * const DRHDataMatrixFactorNamesKey;

@class DRHDataColumn;

@interface DRHDataMatrix : NSObject <NSCoding>

@property NSArray *names;
@property NSArray *data;

-(DRHDataMatrix *)initWithRowArrays:(NSArray *)rowArrays;
+(DRHDataMatrix *)dataMatrixWithColumnArrays:(NSArray *)dataArrays __attribute__((deprecated));
+(DRHDataMatrix *)dataMatrixWithDataColumnArray:(NSArray *)dataArrays;
-(NSInteger)rowCount;
-(NSInteger)columnCount;
-(NSArray *)dataRowAtIndex:(NSInteger)index;
-(NSArray *)dataRowAtIndex:(NSInteger)index ForColumnsWithIndexes:(NSIndexSet *)columnIndexes;
-(NSArray *)dataRowAtIndex:(NSInteger)index ForColumnsWithNames:(NSArray *)nameArray;
-(NSInteger)indexOfDataColumnWithName:(NSString *)columnName;
-(NSIndexSet *)indexesOfDataColumnsWithNames:(NSArray *)nameArray;
-(DRHDataColumn *)dataColumnAtIndex:(NSInteger)index;
-(DRHDataColumn *)dataColumnWithName:(NSString *)name;
-(DRHDataMatrix *)dataMatrixByAddingDataColumn:(DRHDataColumn *)dataColumn;
-(DRHDataMatrix *)dataMatrixByInsertingColumn:(DRHDataColumn *)dataColumn AtIndex:(NSInteger)index;
-(DRHDataMatrix *)dataMatrixByRemovingColumnWithName:(NSString *)columnName;
-(void)shuffleRows;

@end
