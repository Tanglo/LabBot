//
//  DRHRulerView.m
//  LabBot
//
//  Created by Lee Walsh on 8/07/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import "DRHRulerView.h"

@implementation DRHRulerView

@synthesize lowerLimit,upperLimit,increment,tickSpacing,drawRect,tickWidth,fontSize,integerLabels,monitorCalibration;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        lowerLimit = 5.0;
        upperLimit = 18.0;
        increment = 1.0;
        tickSpacing = 10.0;   //10 mm.  1 point = 1/72 of an inch
        drawRect = NSMakeRect(frame.size.width / 2.0, tickSpacing/2.0, 200.0, 1000.0);
        tickWidth = 2.0;
        fontSize = 20.0;
        integerLabels = YES;
        
        monitorCalibration = 10.0 / 7.0;
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    NSBezierPath *bgPath = [NSBezierPath bezierPathWithRect:[self frame]];
    [[NSColor whiteColor] setFill];
    [bgPath fill];
    
    NSInteger numberOfTicks = (upperLimit - lowerLimit) / increment +1;
    NSInteger labelLength;
    if (integerLabels)
        labelLength = [[NSString stringWithFormat:@"%ld",[[NSNumber numberWithDouble:upperLimit]integerValue]] length];
    else
        labelLength = [[NSString stringWithFormat:@"%lf",upperLimit] length];
    NSDictionary *attr = [NSDictionary dictionaryWithObject:[NSFont fontWithName:@"Times new roman" size:fontSize] forKey:NSFontAttributeName];
    NSSize labelSize = [[NSString stringWithFormat:@"%ld",9*(long)pow(10,labelLength)] sizeWithAttributes:attr];
    CGFloat currentTickPos = drawRect.origin.y;
    CGFloat tickSpacingInPoints = 72.0/25.4 * tickSpacing * monitorCalibration;
    CGFloat currentLabelValue = lowerLimit;
    NSRect labelRect = NSMakeRect(drawRect.origin.x, currentTickPos-labelSize.height/2.0, labelSize.width, labelSize.height);
    [[NSColor blackColor] setStroke];
    NSBezierPath *tickPath = [NSBezierPath bezierPath];
    [tickPath setLineWidth:tickWidth];
    
    for (NSInteger i=0; i<numberOfTicks; i++) {
        [tickPath removeAllPoints];
        [tickPath moveToPoint:NSMakePoint(drawRect.origin.x + labelSize.width, currentTickPos)];
        [tickPath lineToPoint:NSMakePoint(drawRect.origin.x + drawRect.size.width, currentTickPos)];
        [tickPath stroke];
        
        NSString *label;
        if (integerLabels)
            label = [NSString stringWithFormat:@"%ld",[[NSNumber numberWithDouble:currentLabelValue] integerValue]];
        else
            label = [NSString stringWithFormat:@"%lf",currentLabelValue];
        [label drawInRect:labelRect withAttributes:attr];
        
        currentTickPos += tickSpacingInPoints;
        currentLabelValue += increment;
        labelRect.origin.y += tickSpacingInPoints;
    }
//    NSLog(@"%ld",9*(long)pow(10,labelLength - 1));
}

@end
