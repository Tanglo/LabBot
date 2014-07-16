//
//  DRHChartView.m
//  LabBot
//
//  Created by Lee Walsh on 16/07/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import "DRHChartView.h"

@implementation DRHChartView

@synthesize fontSize,lineWidth;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        fontSize = 20.0;
        lineWidth = 2.0;
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
