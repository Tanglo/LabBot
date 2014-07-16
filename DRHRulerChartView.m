//
//  DRHRulerView.m
//  LabBot
//
//  Created by Lee Walsh on 8/07/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import "DRHRulerChartView.h"

@implementation DRHRulerChartView

@synthesize labels;
@synthesize labelPadding,centreLabels,rulerWidth,rulerStartPosition,tickSpacing,centreRuler;
@synthesize monitorCalibration;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        labels = nil;
        
        labelPadding = 10.0;
        centreLabels = NO;
        rulerWidth = 200.0;
        rulerStartPosition = NSMakePoint(frame.size.width/2.0,2.0);
        tickSpacing = 10.0;   //10 mm.  1 point = 1/72 of an inch
        centreRuler = YES;
        
        monitorCalibration = 10.0 / 7.0;
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    if (centreRuler) {
        rulerStartPosition.x = [self frame].size.width/2.0;
    }
    NSRect drawRect = NSMakeRect(rulerStartPosition.x - rulerWidth/2.0, rulerStartPosition.y, rulerWidth, [labels count] * tickSpacing);
    
    NSBezierPath *bgPath = [NSBezierPath bezierPathWithRect:[self frame]];
    [[NSColor whiteColor] setFill];
    [bgPath fill];
    
    NSInteger numberOfTicks = [labels count];
    NSDictionary *attr = [NSDictionary dictionaryWithObject:[NSFont fontWithName:@"Times new roman" size:fontSize] forKey:NSFontAttributeName];
    NSSize labelSize = NSMakeSize(0.0, 0.0);
    for (NSString *currentLabel in labels) {
        NSSize currentSize = [currentLabel sizeWithAttributes:attr];
        if (currentSize.width > labelSize.width) {
            labelSize.width = currentSize.width;
        }
        if (currentSize.height > labelSize.height) {
            labelSize.height = currentSize.height;
        }
    }
    labelSize.width += labelPadding;
    CGFloat currentTickPos = drawRect.origin.y;
    CGFloat tickSpacingInPoints = 72.0/25.4 * tickSpacing * monitorCalibration;
    NSRect labelRect = NSMakeRect(drawRect.origin.x, currentTickPos, labelSize.width, labelSize.height);
    if (centreLabels) {
        labelRect.origin.y -= labelRect.size.height/2.0;
    }
    [[NSColor blackColor] setStroke];
    NSBezierPath *tickPath = [NSBezierPath bezierPath];
    [tickPath setLineWidth:lineWidth];
    
    for (NSInteger i=0; i<numberOfTicks; i++) {
        [tickPath removeAllPoints];
        [tickPath moveToPoint:NSMakePoint(drawRect.origin.x + labelSize.width, currentTickPos)];
        [tickPath lineToPoint:NSMakePoint(drawRect.origin.x + drawRect.size.width, currentTickPos)];
        [tickPath stroke];
        
        NSString *label = [labels objectAtIndex:i];
        [label drawInRect:labelRect withAttributes:attr];
        
        currentTickPos += tickSpacingInPoints;
        labelRect.origin.y += tickSpacingInPoints;
    }
}

@end
