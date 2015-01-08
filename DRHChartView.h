//
//  DRHChartView.h
//  LabBot
//
//  Created by Lee Walsh on 16/07/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/*!
 @brief A class to specify the properties and methods that are common to all chart classes.
 
 This class exisits to be a parent for other @c DRHChart classes and so it contains the properties and methods that are common to all charts.
 */
@interface DRHChartView : NSView {
    /// @brief The size of the lables used on the chart.
    CGFloat fontSize;
    /// @brief The thickness of the lines used to draw the chart graphics.
    CGFloat lineWidth;
}
@property CGFloat fontSize;
@property CGFloat lineWidth;

@end
