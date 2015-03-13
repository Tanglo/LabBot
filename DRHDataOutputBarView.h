//
//  DRHDataOutputBarView.h
//  LabBot
//
//  Created by Lee Walsh on 8/01/2015.
//  Copyright (c) 2015 Dead Rubber Hand. All rights reserved.
//

#import "DRHDataOutputView.h"

/*!
 * @memberof DRHDataOutputBarView
 * When the @c orientation property is set the bar will ber vertical and 1.0 represents the top.
 */
extern NSInteger const DRHDataOutputOrientationUp;
/*!
 * @memberof DRHDataOutputBarView
 * When the @c orientation property is set the bar will ber vertical and 1.0 represents the bottom.
 */
extern NSInteger const DRHDataOutputOrientationDown;
/*!
 * @memberof DRHDataOutputBarView
 * When the @c orientation property is set the bar will ber horizontal and 1.0 represents the left.
 */
extern NSInteger const DRHDataOutputOrientationLeft;
/*!
 * @memberof DRHDataOutputBarView
 * When the @c orientation property is set the bar will ber horizontal and 1.0 represents the right.
 */
extern NSInteger const DRHDataOutputOrientationRight;

/*!
 @brief A class for displaying data as a moving bar indicator.
 
 * This class draws a bar, and optionally a target line, that are specified by class properties.
 */
@interface DRHDataOutputBarView : DRHDataOutputView

/// @brief The value of the bar which relative to the frame.  E.g, 1.0 would specify the bar is full, 0.5 would specificy that the bar is half full.
@property CGFloat value;
/// @brief The position of the target line relative to the frame.  E.g, 0.75 would position the taget 3/4 of the way long the bar.  Set to zero or less to hide.  Default is @c 0.0.
@property CGFloat target;
/// @brief The width of the target line.  Default is @c 3.0.
@property CGFloat targetLineWidth;
/// @brief Indicates the orientation of the bar.  Values are set by @c DRHDataOutputOrientation constants.  The default is @c DRHDataOutputOrientationUp.
@property NSInteger orientation;
/// @brief Used to calibrate @c value and @c target if they are set using the @c setCalibratedValue: and @c setCalibratedTarget setter methods.  This property is set to @c 1.0 by default.
@property CGFloat gain;
/// @brief Used to calibrate @c value and @c target if they are set using the @c setCalibratedValue: and @c setCalibratedTarget setter methods.  This property is set to @c 0.0 by default.
@property CGFloat offset;

/*!
 * This methods sets the @c value property using the formula:
 @code
 value = gain*newValue +offset
 @endcode
 where @c value, @c gain, and @c offset are properties of the receiver and have been previoosuly set.
 * @param newValue A @c CGFloat that will be calibrated and set as the new @c value of the receiver.
 */
-(void)setCalibratedValue:(CGFloat)newValue;

/*!
 * This methods sets the @c target property using the formula:
 @code
 target = gain*newTarget +offset
 @endcode
 where @c target, @c gain, and @c offset are properties of the receiver.
 * @param newTarget A @c CGFloat that will be calibrated and set as the new @c target of the receiver
 */
-(void)setCalibratedTarget:(CGFloat)newTarget;

/*!
 * Sets the @c gain and @c offset properties of the receiver based on a two-point linear calibration between two @c NSPoint values.
 * @param firstPoint The x-value of this point is the raw uncalibrated value, the y-value is the calibrated output between @c 0.0 and @c 1.0.  The y-value of this point should be less than the y-value of @c secondPoint.
 * @param secondPoint The x-value of this point is the raw uncalibrated value, the y-value is the calibrated output between @c 0.0 and @c 1.0.  The y-value of this point should be more than the y-value of @c firstPoint.
 */
-(void)twoPointLinearcalibrationUsing:(NSPoint)firstPoint And:(NSPoint)secondPoint;

@end
