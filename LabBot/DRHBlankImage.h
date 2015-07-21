//
//  DRHBlankImage.h
//  LabBot
//
//  Created by Lee Walsh on 16/05/2014.
//  Copyright (c) 2014 Lee David Walsh. All rights reserved.
//  This sofware is licensed under the The MIT License (MIT)
//  See: https://github.com/Tanglo/LabBot/blob/master/LICENSE.md
//

#import <Foundation/Foundation.h>

/*!
 @brief A class for generating easily repeatable blank images.
 
 This is a simple utility class used to generate a quickly reproducable and easily recognisable blank image.  It is used in experiments that use still images as data to represtent a zero, missing or NotANumber value.
 */
@interface DRHBlankImage : NSObject

/*!
 * Creates a new NSImage of the specified size containing only a black background and the words "blank image" written in white.
 * @param imageSize An @c NSSize structure containing the width and height of the new blank image.
 * @return An new blank @c NSImage object
 */
+(NSImage *)blankImageOfSize:(NSSize)imageSize;

@end
