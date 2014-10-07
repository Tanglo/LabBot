//
//  DRHDataColumn.h
//  LabBot
//
//  Created by Lee Walsh on 11/08/2014.
//  Copyright (c) 2014 Lee David Walsh. All rights reserved.
//  This sofware is licensed under the The MIT License (MIT)
//  See: https://github.com/Tanglo/LabBot/blob/master/LICENSE.md
//

#import <Foundation/Foundation.h>


/*!
 @class DRHDataColumn
 @brief A @c DRHDataColumn object holds one column of data objects for an experiment.
 
 A @c DRHDataColumn object has a name and an array of objects.  It is intended to be used as a column representing one variable in an experimental design.  One could use this class to hold a independant variable that is used to control an experiment or create an empty dataColumn to store data objects as they are collected. Note that the `DRHDataMatrix` class has methods that append or insert `DRHDataColumn` objects and to create `DRHDataColumn` objects from it's own columns.
 */
@interface DRHDataColumn : NSObject <NSCoding>

/*!
 * @brief The name of this DRHDataColumn
 */
@property NSString *columnName;

/*!
 * @brief Contains the data content of this DRHDataColumn
 */
@property NSArray *columnData;

/*!
 * Initialises a DRHDataColumn object with the specified name and data array.
 * @param name An NSString specifying the name of the DRHDataColumn
 * @param array An array of objects to initialise the dataColumn with.
 * @return A DRHDataColumn with name set to name and content from array.
 */
-(DRHDataColumn *)initWithName:(NSString *)name AndArray:(NSArray *)array;

/*!
 * Returns the an array of the objects currently in the dataColumn.
 * @return An NSArray of the objects currently in the dataColumn.
 */
-(NSArray *)data;

/*!
 * Returns the number of objects currently in the dataColumn.
 * @return The number of objects currently in the dataColumn.
 */
-(NSInteger)count;

/*!
 * Returns the object located at the specified index.
 * @param index The index of the object to be returned.
 * @return The object located at index.
 */
-(id)rowAtIndex:(NSInteger)index;

/*!
 * Creates a new DRHDataColumn and initialises it with the specified name and array.
 * @param name A name.
 * @param array An array.
 * @return A new DRHDataColumn with the name specified by and containgin the objects in array
 */
+(DRHDataColumn *)dataColumnWithName:(NSString *)name AndArray:(NSArray *)array;

/*!
 * Creates a new DRHDataColumn with the specified name and length.  Each object of the new dataColumn is set to: @code [NSDecimalNumber notANumber] @endcode.
 * @param name A name.
 * @param length The length of the new dataColumn.
 * @return A new DRHDataColumn with the name specified by name and containing length number of NaN `NSDecimalNumber` objects.
 */
+(DRHDataColumn *)dataColumnWithName:(NSString *)name OfNanWithLength:(NSInteger)length;

/*!
 * Creates a new `DRHDataColumn` with the specified name.  The objects in the new dataColumn are `NSNumbers` set to be integers that linearly increasing from the specificed start to the sepcified end in the specified increments.  The values can be repeated by specifying repetitions to be greater than one.  For example:
 * @code aDataColumn = [DRHDataColumn linearDataColumnWithName:@"newDatColumn" OfIntegersFrom:1 To:5 WithIncrement:2 AndRepetitions:2] @endcode
 * will create a new dataColumn containing the objects:
 * @code [1, 1, 3, 3, 5, 5] @endcode
 * This method is intended for creating independant variables for a `DRHDataMatrix` object. Note that the length of this dataColumn is determined by the combinations of parameters.
 * @param name A name.
 * @param start The starting integer value.
 * @param end The ending integer value.
 * @param increment The increment.
 * @param repetitions How many times to repeat each value.
 * @return A new `DRHDataColumn` with the specified name and containing integer `NSNumbers` specificed by start, end, increment and repetitions.
*/
+(DRHDataColumn *)linearDataColumnWithName:(NSString *)name OfIntegersFrom:(NSInteger)start To:(NSInteger)end WithIncrement:(NSInteger)increment AndRepetitions:(NSInteger)repetitions;

/*!
 * Creates a new `DRHDataColumn` with the specified name.  The objects in the new dataColumn are `NSNumbers` set to be doubles that linearly increasing from the specificed start to the sepcified end in the specified increments.  The values can be repeated by specifying repetitions to be greater than one.  For example:
 * @code aDataColumn = [DRHDataColumn linearDataColumnWithName:@"newDatColumn" OfDoublesFrom:1.0 To:3.0 WithIncrement:0.5 AndRepetitions:2] @endcode
 * will create a new dataColumn containing the objects:
 * @code [1.0, 1.0, 1.5, 1.5, 2.0, 2.0, 2.5, 2.5, 3.0, 3.0] @endcode
 * This method is intended for creating independant variables for a `DRHDataMatrix` object. Note that the length of this dataColumn is determined by the combinations of parameters.
 * @param name A name.
 * @param start The starting double value.
 * @param end The ending double value.
 * @param increment The increment.
 * @param repetitions How many times to repeat each value.
 * @return A new `DRHDataColumn` with the specified name and containing double `NSNumbers` specificed by start, end, increment and repetitions.
 */
+(DRHDataColumn *)linearDataColumnWithName:(NSString *)name OfDoublesFrom:(CGFloat)start To:(CGFloat)end WithIncrement:(CGFloat)increment AndRepetitions:(NSInteger)repetitions;

/*!
 * Creates a new `DRHDataColumn` with the specified name.  The objects in the new dataColumn are set by repeating the sepcified array the specified number of times.  So the following code:
 * @code NSArray *factorArray = @[@"rest", @"push", @"pull"];
    aDataColumn = [DRHDataColumn linearDataColumnWithName:@"factorColumn" ByRepeatingArray:factorArray WithRepetitions:3]; @endcode
 * will create a new dataColumn containing the objects:
 * @code [@"rest", @"push", @"pull", @"rest", @"push", @"pull", @"rest", @"push", @"pull"] @endcode
 * This method is intended for creating independant variables for a `DRHDataMatrix` object. Note that the length of this dataColumn is determined by the combinations of parameters.
 * @param name A name.
 * @param array The array to repeat.
 * @param repetitions The number of times to repeat `array`..
 * @return A new `DRHDataColumn` with the specified name and containing an array of objects produced by concatenating `array` a `repetitions` number of times.
 */
+(DRHDataColumn *)dataColumnWithName:(NSString *)name ByRepeatingArray:(NSArray *)array WithRepetitions:(NSInteger)repetitions;

/*!
 * Creates and returns a dataColumn containing the objects in the given array and with the specified name.  The new dataColumn is shuffled before returing.
 * @param name A name.
 * @param array An array of objects.
 * @return A new `DRHDataColumn` with the specified `name` and containing the objects in `array` in a shuffled order.
 */
+(DRHDataColumn *)shuffledDataColumnWithName:(NSString *)name And:(NSArray *)array;

/*!
 * Returns a new dataColum that is a copy of the receiver that has been filled to the specified length with the specified object.
 * @param object The object used to fill the new dataColumn.
 * @param length The length of the new dataColumn.
 * @return A new `DRHDataColumn` the same as the receiver but filled up with `object` to be `length` long.
 */
-(DRHDataColumn *)dataColumnByFillingWithObject:(id)object ToLength:(NSInteger)length;

/*!
 * Returns a new dataColumn that is a copy of the receiver cropped to the specified length.
 * @param length The length of the new dataColumn.
 * @return A new `DRHDataColumn` the same as the receiver but cropped down to be `length` long.
 */
-(DRHDataColumn *)dataColumnByCropingToLength:(NSInteger)length;

@end
