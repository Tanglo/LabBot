//
//  DRHDataOutputBarView.m
//  LabBot
//
//  Created by Lee Walsh on 8/01/2015.
//  Copyright (c) 2015 Dead Rubber Hand. All rights reserved.
//

#import "DRHDataOutputBarView.h"

NSInteger const DRHDataOutputOrientationUp = 0;
NSInteger const DRHDataOutputOrientationDown = 1;
NSInteger const DRHDataOutputOrientationLeft = 2;
NSInteger const DRHDataOutputOrientationRight = 3;

@implementation DRHDataOutputBarView

-(void)awakeFromNib{
    [super awakeFromNib];
    _value = 0.5;
    _target = 0.75;
    _orientation = DRHDataOutputOrientationUp;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];

    // Drawing code here.
    NSRect barRect = [self bounds];
    if (_orientation==DRHDataOutputOrientationUp || _orientation==DRHDataOutputOrientationDown)
        barRect.size.height *= _value;
    else if (_orientation==DRHDataOutputOrientationRight)
        barRect.size.width *= _value;
    else if (_orientation==DRHDataOutputOrientationLeft){
        barRect.origin.x += (1-_value) * barRect.size.width;
        barRect.size.width *= _value;
    }
    
    NSBezierPath *barPath = [NSBezierPath bezierPathWithRect:barRect];
    [[self fgColour] setFill];
    [barPath fill];
}

-(BOOL)isFlipped{
    if (_orientation==DRHDataOutputOrientationDown)
        return YES;
    else
        return NO;
}

@end
