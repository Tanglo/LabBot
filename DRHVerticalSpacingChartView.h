//
//  DRHSpacingBarView.h
//  LabBot
//
//  Created by Lee Walsh on 16/07/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DRHChartView.h"

extern NSInteger const DRHLabBotAlignmentScatter;
extern NSInteger const DRHLabBotAlignmentTop;
extern NSInteger const DRHLabBotAlignmentCentre;
extern NSInteger const DRHLabBotAlignmentBottom;

typedef NSInteger DRHLabBotAlignment;

@interface DRHVerticalSpacingChartView : DRHChartView {
    NSArray *barLengths;
    NSArray *labels;
    
    CGFloat capWidth;
    CGFloat barPadding;
    
    DRHLabBotAlignment alignment;
    
    CGFloat monitorCalibration; //scaling factor applied to tick distances to make exact.  monitorCalibration = real mm distance / NSView mm distance;
}
@property NSArray *labels;

@property CGFloat capWidth;
@property CGFloat barPadding;

@property DRHLabBotAlignment alignment;

@property CGFloat monitorCalibration;

-(NSArray *)barLengths;
-(void)setBarLengths:(NSArray *)lengthsInMillimetres;

@end
