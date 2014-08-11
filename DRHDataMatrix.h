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
+(DRHDataMatrix *)dataMatrixWithColumnArrays:(NSArray *)dataArrays;
-(NSInteger)rowCount;
-(NSInteger)columnCount;
-(NSArray *)dataRowAtIndex:(NSInteger)index;
-(DRHDataColumn *)dataColumnAtIndex:(NSInteger)index;
-(DRHDataColumn *)dataColumnWithName:(NSString *)name;
-(DRHDataMatrix *)dataMatrixByAddingDataColumn:(DRHDataColumn *)dataColumn;
-(DRHDataMatrix *)dataMatrixByInsertingColumn:(DRHDataColumn *)dataColumn AtIndex:(NSInteger)index;
-(void)shuffleRows;

@end
