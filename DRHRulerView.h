//
//  DRHRulerView.h
//  LabBot
//
//  Created by Lee Walsh on 8/07/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DRHRulerView : NSView {
    CGFloat lowerLimit;
    CGFloat upperLimit;
    CGFloat increment;
    CGFloat tickSpacing;    //in mm
    NSRect drawRect;
    CGFloat tickWidth;
    CGFloat fontSize;
    BOOL integerLabels;
    
    CGFloat monitorCalibration; //scaling factor applied to tick distances to make exact.  monitorCalibration = real mm distance / NSView mm distance;
}
@property CGFloat lowerLimit;
@property CGFloat upperLimit;
@property CGFloat increment;
@property CGFloat tickSpacing;
@property NSRect drawRect;
@property CGFloat tickWidth;
@property CGFloat fontSize;
@property BOOL integerLabels;
@property CGFloat monitorCalibration;

@end
