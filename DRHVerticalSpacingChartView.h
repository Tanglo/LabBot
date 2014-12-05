//
//  DRHSpacingBarView.h
//  LabBot
//
//  Created by Lee Walsh on 16/07/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DRHChartView.h"

/**
 @file DRHVerticalSpacingChartView.h
 @defgroup constants Constants
 */

/// Set vertical spacing bars to be vertically scattered.
/// @ingroup constants
extern NSInteger const DRHLabBotAlignmentScatter;
/// Set the tops of the vertical spacing bars to be vertically aligned.
/// @ingroup constants
extern NSInteger const DRHLabBotAlignmentTop;
/// Set the centres of the vertical spacing bars to be vertically aligned.
/// @ingroup constants
extern NSInteger const DRHLabBotAlignmentCentre;
/// Set the bottomes of the vertical spacing bars to be vertically aligned.
/// @ingroup constants
extern NSInteger const DRHLabBotAlignmentBottom;

/// @brief Used to define the vertical alignment style of a @c DRHVerticalSpacingChart
typedef NSInteger DRHLabBotAlignment;

/*!
 @brief A class to display vertical spacing judgement chart.
 
 A vertical spacing chart shows a series of calibrated "error bars" that are used for psychophysical judgements of vertical spacing or size.  This class facilitates the generation of randomised vertical spacing charts.
 */
@interface DRHVerticalSpacingChartView : DRHChartView {
    /// @brief An array of @c NSNumber objects that specify lengths of the spacing bars in millimetres.
    NSArray *barLengths;
    /// @brief An array of @c NSString objects that specify the tick labels.
    NSArray *labels;
    
    /// @brief The width of the spacing bar caps in points.  The default is @c 50.0.
    CGFloat capWidth;
    /// @brief The drawing space between the bars in points.  The default is @c 10.0.
    CGFloat barPadding;
    
    /// @brief Specifies the vertical alignment of the vertical spacing bars.  The default is @c DRHLabBotAlignmentTop.
    DRHLabBotAlignment alignment;
    
    /// @brief The scaling factor used to callibrate distances to mm on the monitor.  If your tick distances are not correct alter this value.  Default is @c 10.0/7.0 which represetns 10.0 mm divided by the distance that appears when I tell an @c DRHRulerChartView to display 10 mm spacing when @c monitorCalibration is set to 1.0 (i.e. uncalibrated).
    CGFloat monitorCalibration; //scaling factor applied to tick distances to make exact.  monitorCalibration = real mm distance / NSView mm distance;
}
@property NSArray *labels;

@property CGFloat capWidth;
@property CGFloat barPadding;

@property DRHLabBotAlignment alignment;

@property CGFloat monitorCalibration;

/*!
 * Returns and array of the lengths of the bars used to draw the receiver.
 * @return An array of @c NSNumber objects that specifies the length of the vertical spacing bars drawn by the receiver.
 */
-(NSArray *)barLengths;

/*!
 * Sets the length of the vertical spacing bars shown by the receiver.
 * @param lengthsInMillimetres An array of @c NSNumber objects that specifies the length, in millimetres, of the vertical spacing bars to be drawn.
 */
-(void)setBarLengths:(NSArray *)lengthsInMillimetres;

@end
