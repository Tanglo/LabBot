//
//  DRHRulerView.h
//  LabBot
//
//  Created by Lee Walsh on 8/07/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DRHChartView.h"

@interface DRHRulerChartView : DRHChartView {
    NSArray *labels;
    
    CGFloat labelPadding;
    BOOL centreLabels;
    CGFloat rulerWidth;
    NSPoint rulerStartPosition; //x is centered
    CGFloat tickSpacing;    //in mm
    BOOL centreRuler;
    
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
