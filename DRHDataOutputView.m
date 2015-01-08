//
//  DRHDataOutputView.m
//  LabBot
//
//  Created by Lee Walsh on 8/01/2015.
//  Copyright (c) 2015 Dead Rubber Hand. All rights reserved.
//

#import "DRHDataOutputView.h"

@implementation DRHDataOutputView

-(void)awakeFromNib{
    _fgColour = [NSColor redColor];
    _bgColour = nil;
    _altColour = [NSColor blueColor];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    if (_bgColour) {
        NSBezierPath *bgPath = [NSBezierPath bezierPathWithRect:[self bounds]];
        [_bgColour setFill];
        [bgPath fill];
    }
}

@end
