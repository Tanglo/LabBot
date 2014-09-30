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

@interface DRHDataColumn : NSObject <NSCoding>

/*!
 * @brief The name of this @c DRHDataColumn
 */
@property NSString *columnName;
/*!
 * @brief Contains the data content of this @c DRHDataColumn
 */
@property NSArray *columnData;

/*!
 * @discussion Initialises a DRHDataColumn object with the specified name and data array.
 * @param name An @c NSString specifying the name of the @c DRHDataColumn
 * @param array An array of objects to initialise the dataColumn with.
 * @return A @c DRHDataColumn with name set to @c name and content from @c array.
 */
-(DRHDataColumn *)initWithName:(NSString *)name AndArray:(NSArray *)array;

/*!
 * @discussion Returns the an array of the objects currently in the dataColumn.
 * @return An @c NSArray of the objects currently in the dataColumn.
 */
-(NSArray *)data;

/*!
 * @discussion Returns the number of objects currently in the dataColumn.
 * @return The number of objects currently in the dataColumn.
 */
-(NSInteger)count;

/*!
 * @discussion Returns the object located at the specified index.
 * @param index The index of the object to be returned.
 * @return The object located at @c index.
 */
-(id)rowAtIndex:(NSInteger)index;

/*!
 * @discussion Creates a new @c DRHDataColumn and initialises it with the specified name and array.
 * @param name A name.
 * @param array An array.
 * @return A new @c DRHDataColumn with the name specified by @c and containgin the objects in @c array
 */
+(DRHDataColumn *)dataColumnWithName:(NSString *)name AndArray:(NSArray *)array;

/*!
 * @discussion Creates a new @c DRHDataColumn with the specified name and length.  Each object of the new dataColumn is set to: @code [NSDecimalNumber notANumber] @endcode.
 * @param name A name.
 * @param length The length of the new dataColumn.
 * @return A new @c DRHDataColumn with the name specified by @c name and containing @c length number of NaN @c NSDecimalNumber objects.
 */
+(DRHDataColumn *)dataColumnWithName:(NSString *)name OfNanWithLength:(NSInteger)length;


+(DRHDataColumn *)linearDataColumnWithName:(NSString *)name OfIntegersFrom:(NSInteger)start To:(NSInteger)end WithIncrement:(NSInteger)increment AndRepetitions:(NSInteger)repetitions;
+(DRHDataColumn *)linearDataColumnWithName:(NSString *)name OfDoublesFrom:(CGFloat)start To:(CGFloat)end WithIncrement:(CGFloat)increment AndRepetitions:(NSInteger)repetitions;
+(DRHDataColumn *)dataColumnWithName:(NSString *)name ByRepeatingArray:(NSArray *)array WithRepetitions:(NSInteger)repetitions;
+(DRHDataColumn *)shuffledDataColumnWithName:(NSString *)name And:(NSArray *)array;
-(DRHDataColumn *)dataColumnByFillingWithObject:(id)object ToLength:(NSInteger)length;
-(DRHDataColumn *)dataColumnByCropingToLength:(NSInteger)length;

@end
