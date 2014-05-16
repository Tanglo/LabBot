//
//  DRHBlankImage.m
//  LabBot
//
//  Created by Lee Walsh on 16/05/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import "DRHBlankImage.h"

@implementation DRHBlankImage

+(NSImage *)blankImageOfSize:(NSSize)imageSize{
    NSImage *blankImage = [[NSImage alloc] initWithSize:imageSize];
    NSBezierPath *blankPath = [NSBezierPath bezierPathWithRect:NSMakeRect(0.0, 0.0, imageSize.width, imageSize.height)];
    [[NSColor blackColor] setFill];
    [blankImage lockFocus];
    [blankPath fill];
    [blankImage unlockFocus];
    return blankImage;
}

@end
