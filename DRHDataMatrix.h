//
//  DRHDataMatrix.h
//  LabBot
//
//  Created by Lee Walsh on 11/08/2014.
//  Copyright (c) 2014 Lee David Walsh. All rights reserved.
//  This sofware is licensed under the The MIT License (MIT)
//  See: https://github.com/Tanglo/LabBot/blob/master/LICENSE.md
//

#import <Foundation/Foundation.h>

extern NSString * const DRHDataMatrixFactorsKey;
extern NSString * const DRHDataMatrixFactorNamesKey;

@class DRHDataColumn;

@interface DRHDataMatrix : NSObject <NSCoding>

/*!
 * @brief An array of the names of of the columns contained.
 */
@property NSArray *names;
/*!
 * @brief An array of the columns contained.
 */
@property NSArray *data;

/*!
 * Initialises the receiving `DRHDataMatrix` with the specified array of row arrays.
 * @param rowArrays An array of subarrays.  Each subarray represents an @a observation in the experiment and so should be the same length and consist of the same objects is the same order.
 * @return The receiver containing row arrays specified by `rowArrays`.  The `names` array of the receiver is `nil`.
 */
-(DRHDataMatrix *)initWithRowArrays:(NSArray *)rowArrays;

/*!
 * @deprecated Do not use this method it is deprecated and will be removed in a future version of LabBot. Use `dataMatrixWithDataColumnArray:` instead; its function is identical.
 */
+(DRHDataMatrix *)dataMatrixWithColumnArrays:(NSArray *)dataArrays __attribute__((deprecated));

/*!
 * Creates a new dataMatrix initialised using the specified array of `DRHDataColumns'.
 * @param dataArrays An array of `DRHDataColumn` objects.  Currently all dataColumns must be the same length and have names.
 * @return A new `DRHDataMatrix` object initialised with the array `DRHDataColumns` provided in `dataArrays`.
 */
+(DRHDataMatrix *)dataMatrixWithDataColumnArray:(NSArray *)dataArrays;

/*!
 * Returns the number of rows currently in the dataMatrix.
 * @return The number of rows currently in the dataMatrix.
 */
-(NSInteger)rowCount;

/*!
 * Returns the number of columns currently in the dataMatrix.
 * @return The number of columns currently in the dataMatrix.
 */
-(NSInteger)columnCount;

/*!
 * Returns the entire row array located at the sepcified index.
 * @param index An row index within the bounds of the dataMatrix.
 * @return The entire row array located at `index`.
 */
-(NSArray *)dataRowAtIndex:(NSInteger)index;

/*!
 * Returns a row array containing the objects located at the specified index from a subset of columns specified by an index set.
 * @param index An row index within the bounds of the dataMatrix.
 * @param columnIndexes An index set within the bounds of the dataMatrix that sepcifies the columns to include in the row array.
 * @return A row array containing the objects located at `index` in the columns specified by `columnIndexes`.
 */
-(NSArray *)dataRowAtIndex:(NSInteger)index ForColumnsWithIndexes:(NSIndexSet *)columnIndexes;

/*!
 * Returns a row array containing the objects located at the specified index from a subset of columns specified an array of names.
 * @param index An row index within the bounds of the dataMatrix.
 * @param nameArray An array of `NSString` objects specifying the names of the columns to include in the row array.
 * @return A row array containing the objects located at `index` in the columns specified by `nameArray`.
 */
-(NSArray *)dataRowAtIndex:(NSInteger)index ForColumnsWithNames:(NSArray *)nameArray;

/*!
 * Returns the index of the column with the specified name.
 * @param columnName A string object.
 * @return If a column with the specified name is found in the dataMatrix, its index is returned. Otherwise `NSNotFound` is returned.
 */
-(NSInteger)indexOfDataColumnWithName:(NSString *)columnName;

/*!
 * Returns the indexes of the columns with the specified names.
 * @param nameArray An array of string objects.
 * @return An index set containing the indexes of the columns with the names specified by `nameArray'.  If a specified name is not found that name is ignored.
 */
-(NSIndexSet *)indexesOfDataColumnsWithNames:(NSArray *)nameArray;


-(DRHDataColumn *)dataColumnAtIndex:(NSInteger)index;
-(DRHDataColumn *)dataColumnWithName:(NSString *)name;
-(DRHDataMatrix *)dataMatrixByAddingDataColumn:(DRHDataColumn *)dataColumn;
-(DRHDataMatrix *)dataMatrixByInsertingColumn:(DRHDataColumn *)dataColumn AtIndex:(NSInteger)index __attribute__((deprecated));
-(DRHDataMatrix *)dataMatrixByInsertingDataColumn:(DRHDataColumn *)dataColumn AtIndex:(NSInteger)index;
-(DRHDataMatrix *)dataMatrixByRemovingColumnWithName:(NSString *)columnName;
-(void)shuffleRows;

@end
