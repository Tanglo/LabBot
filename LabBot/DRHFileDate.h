//
//  DRHFileDate.h
//  LabBot
//
//  Created by Lee Walsh on 21/08/2014.
//  Copyright (c) 2014 Lee David Walsh. All rights reserved.
//  This sofware is licensed under the The MIT License (MIT)
//  See: https://github.com/Tanglo/LabBot/blob/master/LICENSE.md
//

#import <Foundation/Foundation.h>

/*!
 @brief Used to hold a date and it's display format.
 
 This class simply pairs an @c NSDate with an @c NSDateFormatter which can be useful for dates that need to be displayed or drawn in customised formats.
 */
@interface DRHFileDate : NSObject{
    /// @brief The date.
    NSDate *date;
    /// @brief The format that should be used to display or draw this date.
    NSDateFormatter *dateFormatter;
}

/*!
 * Initialises the receiver with the specified date object.
 * @param newDate The date object used to initialise the receiver.
 * @return The receiver initialised with the specified date object.
 */
-(DRHFileDate *)initWithDate:(NSDate *)newDate;

/*!
 * Creates a new @c DRHFileDate and initialises it with the specified date object.
 * @param newDate The date object used to initialise the newly created object.
 * @return A newly created @c DRHFileDate object initialised with the specified date object.
 */
+(DRHFileDate *)fileDateWithDate:(NSDate *)newDate;

/*!
 * Sets the date object of the receiver.
 * @param newDate The date object used to set the receiver.
 */
-(void)setDate:(NSDate *)newDate;

/*!
 * Returns the receivers date as a string in the receivers specified format.
 * @return An @c NSString object of the recevier's @c date in the format specified by the receiver's @c dateFormatter.
 */
-(NSString *)dateString;

@end
