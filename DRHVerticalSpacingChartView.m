//
//  DRHSpacingBarView.m
//  LabBot
//
//  Created by Lee Walsh on 16/07/2014.
//  Copyright (c) 2014 Lee David Walsh. All rights reserved.
//  This sofware is licensed under the The MIT License (MIT)
//  See: https://github.com/Tanglo/LabBot/blob/master/LICENSE.md
//

#import "DRHVerticalSpacingChartView.h"
#import "DRHTrialMatrix.h"

NSInteger const DRHLabBotAlignmentScatter = -1;
NSInteger const DRHLabBotAlignmentTop = 0;
NSInteger const DRHLabBotAlignmentCentre = 1;
NSInteger const DRHLabBotAlignmentBottom = 2;

@implementation DRHVerticalSpacingChartView

@synthesize labels;
@synthesize capWidth,barPadding;
@synthesize alignment;
@synthesize monitorCalibration;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        barLengths = nil;
        labels = nil;
        
        capWidth = 50.0;        //cap width should be greater than label width
        barPadding = 10.0;
        
        alignment = DRHLabBotAlignmentTop;
        
        monitorCalibration = 10.0 / 7.0;
    }
    return self;
}

-(NSArray *)barLengths{
    return barLengths;
}

-(void)setBarLengths:(NSArray *)lengthsInMillimetres{
    NSMutableArray *barLengthsInPoints = [NSMutableArray array];
    for (NSNumber *currentLength in lengthsInMillimetres) {
        [barLengthsInPoints addObject:[NSNumber numberWithDouble:[currentLength doubleValue] * 72.0/25.4 * monitorCalibration]];
    }
    barLengths = barLengthsInPoints;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    NSDictionary *attr = [NSDictionary dictionaryWithObject:[NSFont fontWithName:@"Times new roman" size:fontSize] forKey:NSFontAttributeName];
    NSRect drawRect = [self frame];
    //if bars won't take up the whole screen (or more) centre them in the screen
    CGFloat maxBarHeight = 0.0;
    for (NSNumber *currentLength in barLengths){
        if ([currentLength doubleValue] > maxBarHeight) {
            maxBarHeight = [currentLength doubleValue];
        }
    }
    if (drawRect.size.height > maxBarHeight) {
        drawRect.origin.y += (drawRect.size.height - maxBarHeight) / 2.0;
        drawRect.size.height = maxBarHeight;
    }
    CGFloat barDrawWidth = (capWidth + barPadding) * [barLengths count] + barPadding;
    if (drawRect.size.width > barDrawWidth) {
        drawRect.origin.x += (drawRect.size.width - barDrawWidth) / 2.0;
        drawRect.size.width = barDrawWidth;
    }
    
    NSString *currentLabel = nil;
    NSRect labelDrawRect;
    NSRect barDrawRect;
    barDrawRect.origin.x = drawRect.origin.x + barPadding;
    barDrawRect.size.width = capWidth;
    for (NSInteger i=0; i<[labels count]; i++){
        currentLabel = [labels objectAtIndex:i];
        labelDrawRect.size = [currentLabel sizeWithAttributes:attr];
        barDrawRect.size.height = [[barLengths objectAtIndex:i] doubleValue];
        labelDrawRect.origin.x = barDrawRect.origin.x + (barDrawRect.size.width - labelDrawRect.size.width) / 2.0;
        
        if (alignment == DRHLabBotAlignmentTop) {
            labelDrawRect.origin.y = drawRect.origin.y + drawRect.size.height - barPadding - labelDrawRect.size.height;
            barDrawRect.origin.y = labelDrawRect.origin.y - barPadding - barDrawRect.size.height;
        } else if (alignment == DRHLabBotAlignmentBottom) {
            labelDrawRect.origin.y = drawRect.origin.y + barPadding;
            barDrawRect.origin.y = drawRect.origin.y + labelDrawRect.size.height + 2.0*barPadding;
        } else if (alignment == DRHLabBotAlignmentCentre) {
            CGFloat totalHeight = labelDrawRect.size.height + barDrawRect.size.height + barPadding;
            labelDrawRect.origin.y = drawRect.origin.y + drawRect.size.height/2.0 + totalHeight/2.0 - labelDrawRect.size.height - barPadding;
            barDrawRect.origin.y = labelDrawRect.origin.y - barPadding - barDrawRect.size.height;
        }
        
        [[NSColor blackColor] setStroke];
        [currentLabel drawInRect:labelDrawRect withAttributes:attr];
        NSBezierPath *barPath = [NSBezierPath bezierPath];
        [barPath setLineWidth:lineWidth];
        [barPath moveToPoint:barDrawRect.origin];
        [barPath lineToPoint:NSMakePoint(barDrawRect.origin.x + barDrawRect.size.width,barDrawRect.origin.y)];
        [barPath moveToPoint:NSMakePoint(barDrawRect.origin.x, barDrawRect.origin.y + barDrawRect.size.height)];
        [barPath lineToPoint:NSMakePoint(barDrawRect.origin.x + barDrawRect.size.width, barDrawRect.origin.y + barDrawRect.size.height)];
        [barPath moveToPoint:NSMakePoint(barDrawRect.origin.x + barDrawRect.size.width/2.0, barDrawRect.origin.y)];
        [barPath lineToPoint:NSMakePoint(barDrawRect.origin.x + barDrawRect.size.width/2.0, barDrawRect.origin.y + barDrawRect.size.height)];
        [barPath stroke];
        
        barDrawRect.origin.x += (barDrawRect.size.width + barPadding);
    }
}

@end
