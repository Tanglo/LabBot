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
    _target = 0.0;
    _targetLineWidth = 3.0;
    _orientation = DRHDataOutputOrientationUp;
    _gain = 1.0;
    _offset = 0.0;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];

    // Drawing code here.
    NSRect barViewBounds = [self bounds];
    NSRect barRect = barViewBounds;
    if (_orientation==DRHDataOutputOrientationUp || _orientation==DRHDataOutputOrientationDown)
        barRect.size.height *= _value;
    else if (_orientation==DRHDataOutputOrientationRight)
        barRect.size.width *= _value;
    else if (_orientation==DRHDataOutputOrientationLeft){
        barRect.origin.x += (1-_value) * barRect.size.width;
        barRect.size.width *= _value;
    }
    
    NSBezierPath *barPath = [NSBezierPath bezierPathWithRect:barRect];
    if (![self alternate])
        [[self fgColour] setFill];
    else
        [[self altColour] setFill];
    [barPath fill];
    
    if (_target > 0) {
        NSBezierPath *targetPath = [NSBezierPath bezierPath];
        NSPoint startPt, endPt;
        if (_orientation==DRHDataOutputOrientationUp || _orientation==DRHDataOutputOrientationDown){
            startPt.x = barViewBounds.origin.x;
            startPt.y = endPt.y = barViewBounds.size.height * _target;
            endPt.x = barViewBounds.size.width;
        } else if (_orientation==DRHDataOutputOrientationRight){
            startPt.x = endPt.x = barViewBounds.size.width * _target;
            startPt.y = barViewBounds.origin.y;
            endPt.y = barViewBounds.size.height;
        } else if (_orientation==DRHDataOutputOrientationLeft){
            startPt.x = endPt.x = barViewBounds.size.width * (1-_target);
            startPt.y = barViewBounds.origin.y;
            endPt.y = barViewBounds.size.height;
        }
        [[NSColor blackColor] setStroke];
        [targetPath setLineWidth:_targetLineWidth];
        [targetPath moveToPoint:startPt];
        [targetPath lineToPoint:endPt];
        [targetPath stroke];
    }
}

-(BOOL)isFlipped{
    if (_orientation==DRHDataOutputOrientationDown)
        return YES;
    else
        return NO;
}

-(void)setCalibratedValue:(CGFloat)newValue{
    [self willChangeValueForKey:@"value"];
    _value = _gain*newValue +_offset;
    [self didChangeValueForKey:@"value"];
}

-(void)setCalibratedTarget:(CGFloat)newTarget{
    [self willChangeValueForKey:@"target"];
    _target = _gain*newTarget +_offset;
    [self didChangeValueForKey:@"target"];
}

-(void)twoPointLinearcalibrationUsing:(NSPoint)firstPoint And:(NSPoint)secondPoint{
    [self willChangeValueForKey:@"gain"];
    _gain = (secondPoint.y-firstPoint.y) / (secondPoint.x-firstPoint.x);
    [self didChangeValueForKey:@"gain"];
    [self willChangeValueForKey:@"offset"];
    _offset = secondPoint.y - _gain*secondPoint.x;
    [self didChangeValueForKey:@"offset"];
}

@end
