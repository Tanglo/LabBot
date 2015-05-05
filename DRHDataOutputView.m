//
//  DRHDataOutputView.m
//  LabBot
//
//  Created by Lee Walsh on 8/01/2015.
//  Copyright (c) 2014 Lee David Walsh. All rights reserved.
//  This sofware is licensed under the The MIT License (MIT)
//  See: https://github.com/Tanglo/LabBot/blob/master/LICENSE.md
//

#import "DRHDataOutputView.h"

@implementation DRHDataOutputView

-(void)awakeFromNib{
    _fgColour = [NSColor redColor];
    _bgColour = nil;
    _altColour = [NSColor blueColor];
    _alternate = NO;
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
