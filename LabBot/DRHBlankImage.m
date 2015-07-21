//
//  DRHBlankImage.m
//  LabBot
//
//  Created by Lee Walsh on 16/05/2014.
//  Copyright (c) 2014 Lee David Walsh. All rights reserved.
//  This sofware is licensed under the The MIT License (MIT)
//  See: https://github.com/Tanglo/LabBot/blob/master/LICENSE.md
//

#import "DRHBlankImage.h"

@implementation DRHBlankImage

+(NSImage *)blankImageOfSize:(NSSize)imageSize{
    if (imageSize.height > 0 && imageSize.width > 0) {
        NSImage *blankImage = [[NSImage alloc] initWithSize:imageSize];
        NSBezierPath *blankPath = [NSBezierPath bezierPathWithRect:NSMakeRect(0.0, 0.0, imageSize.width, imageSize.height)];
        NSString *label = [NSString stringWithFormat:@"blank\nimage"];
        CGFloat fontSize;
        if (imageSize.height > imageSize.width) {
            fontSize = imageSize.width;
        } else {
            fontSize = imageSize.height;
        }
        fontSize /= 5.0;
        NSDictionary *attr = [NSDictionary dictionaryWithObjectsAndKeys:[NSFont fontWithName:@"Arial" size:fontSize], NSFontAttributeName, [NSColor whiteColor], NSForegroundColorAttributeName, nil];
        NSRect labelDrawRect;
        labelDrawRect.size = [label sizeWithAttributes:attr];
        labelDrawRect.origin.x = (imageSize.width - labelDrawRect.size.width) / 2.0;
        labelDrawRect.origin.y = (imageSize.height - labelDrawRect.size.height) / 2.0;
        [[NSColor blackColor] setFill];
        [blankImage lockFocus];
        [blankPath fill];
        [label drawInRect:labelDrawRect withAttributes:attr];
        [blankImage unlockFocus];
        return blankImage;
    }
    return nil;
}

@end
