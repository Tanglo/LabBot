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
/// @brief The position of the target line relative to the frame.  E.g, 0.75 would position the taget 3/4 of the way long the bar.
@property CGFloat target;
/// @brief Indicates the orientation of the bar.  Values are set by @c DRHDataOutputOrientation constants.
@property NSInteger orientation;

@end
