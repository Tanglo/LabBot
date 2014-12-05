//
//  DRHRulerView.h
//  LabBot
//
//  Created by Lee Walsh on 8/07/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DRHChartView.h"

/*!
 @brief A class to display an experimental ruler with specified size and labels.
 
 A @c DRHRulerChartView is a NSView class to facilitate displaying expeirmental rulers, which often need to have variable sizes and different, often random, starting points for each trail.  The labels are specified as an array so that they can be easily generated externally.
 */
@interface DRHRulerChartView : DRHChartView {
    /// @brief An array of @c NSString objects that specify the tick labels.
    NSArray *labels;
    
    /// @brief The ammount of spacing between the ticks and labels in points.  Default is @c 10.0.
    CGFloat labelPadding;
    /// @brief Should labels be vertically centred on their tick.  Default is @c NO.
    BOOL centreLabels;
    /// @brief The width of the ruler in points.  The default is @c 200.0.
    CGFloat rulerWidth;
    /// @brief Specifies the position of the bottom left corner of the ruler in points.  The default is @c (frame.size.width/2.0, 2.0).
    NSPoint rulerStartPosition; //x is centered
    /// @brief The distance between the ruler ticks in millimetres.  The default is @c 10.0 mm.
    CGFloat tickSpacing;    //in mm
    /// @brief specifies if the ruler should be horizontally centred within the view.  Setting this to @c YES means that the value of @c rulerStartPosition.x is ignored.  Default is @c YES.
    BOOL centreRuler;
    
    /// @brief The scaling factor used to callibrate distances to mm on the monitor.  If your tick distances are not correct alter this value.  Default is @c 10.0/7.0 which represetns 10.0 mm divided by the distance that appears when I tell an @c DRHRulerChartView to display 10 mm spacing when @c monitorCalibration is set to 1.0 (i.e. uncalibrated).
    CGFloat monitorCalibration; //scaling factor applied to tick distances to make exact.  monitorCalibration = real mm distance / NSView mm distance;
}
@property NSArray *labels;

@property CGFloat labelPadding;
@property BOOL centreLabels;
@property CGFloat rulerWidth;
@property NSPoint rulerStartPosition;
@property CGFloat tickSpacing;
@property BOOL centreRuler;

@property CGFloat monitorCalibration;

@end
