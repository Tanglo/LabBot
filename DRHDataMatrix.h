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


/*!
 @brief An object to store a table of experimental variables.
 
 A @c DRHDataMatrix object is an n by m matrix of variables.  Each variable is represeted as a column and then each row represets an observation, that is one value from each variable that is locked together.  An instance of the @c DRHDataMatrix class is intended to be used to hold all the data associated with an experiment in a single indexable object.  Treating rows as @a observations is intended to facilitate this use.  Because each column is identified by name the order of the columns can be arbitary and individual columns can be extracted by name.  This means this facilitates the writing of more general and reusable anaylsis or collation software, particularly if numbers or text data is simply being converted to UTF-8 or ASCII fo importation into an analysis package.
 
 Several methods exist to interact with the @c DRHDataColumn class.  For example @c DRHDataColumn objects can be added or inserted into an exisiting @c DRHDataMatrix object, or can be generated from a column of and exisiting @c DRHDataMatrix.
 */
__attribute__((deprecated))
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

/*!
 * Creates and returns dataColumns containing the objects in the column at the specified index.
 * @param index A column index within the bounds of the receiver.
 * @return A @c DRHDataColumn containng the objects currently in the column specified by @c index and with the same name.
 */
-(DRHDataColumn *)dataColumnAtIndex:(NSInteger)index;

/*!
 * Creates and returns dataColumns containg the objects in the column with the sepcified name.
 * @param name The name of a column in the receiver.
 * @return A @c DRHDataColumn containng the objects currently in the column specified by @c name and with that same name.  If a column with the specifieid name is not found @c nil is returned.
 */
-(DRHDataColumn *)dataColumnWithName:(NSString *)name;

/*!
 * Creates a new dataMatrix by adding the provided dataColumn to the receiver.  The data column being added should be the same length as the receiver which can be acheived using the @c dataColumnByFillingWithObject:ToLength: or @c dataColumnByCropingToLength:length instance methods from the @c DRHDataColumn class.
 * @param dataColumn A dataColumn object.
 * @return A @c DRHDataMatrix created by adding the provided @c dataColumn to the end of the receiver.
 */
-(DRHDataMatrix *)dataMatrixByAddingDataColumn:(DRHDataColumn *)dataColumn;

/*!
 * @deprecated Do not use this method it is here for short term backwards compatibility but is deprecated and will be removed in a future version of LabBot. Use @c dataMatrixByInsertingDataColumn:AtIndex instead; its function is identical.
 */
-(DRHDataMatrix *)dataMatrixByInsertingColumn:(DRHDataColumn *)dataColumn AtIndex:(NSInteger)index __attribute__((deprecated));

/*!
 * Creates a new dataMatrix by inserting the provided dataColumn into the receiver at the specified index.  The data column being added should be the same length as the receiver which can be acheived using the @c dataColumnByFillingWithObject:ToLength: or @c dataColumnByCropingToLength:length instance methods from the @c DRHDataColumn class.
 * @param dataColumn A dataColumn object.
 * @param index A column index witin the bounds of the receiver.
 * @return A @c DRHDataMatrix created by inserting the provided @c dataColumn into the receiver at @c index.
 */
-(DRHDataMatrix *)dataMatrixByInsertingDataColumn:(DRHDataColumn *)dataColumn AtIndex:(NSInteger)index;

/*!
 * Creates a new dataMatrix by removing the first column that has the specified name.
 * @param columnName The name of a column in the receiver.
 * @return A @c DRHDataMatrix created by removing the first data column found that has a name equal to @c name.  If the receiver does not contain a column with the specified name the receiver is returned.
 */
-(DRHDataMatrix *)dataMatrixByRemovingColumnWithName:(NSString *)columnName;

/*!
 * Shuffles the rows of the receiver.  Importantly this method maintains each row as an @a observation.  So the contents of a given dataMatrix row do not change but are moved as one in the shuffle.
 */
-(void)shuffleRows;

@end
