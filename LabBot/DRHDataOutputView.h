//
//  DRHDataOutputView.h
//  LabBot
//
//  Created by Lee Walsh on 8/01/2015.
//  Copyright (c) 2014 Lee David Walsh. All rights reserved.
//  This sofware is licensed under the The MIT License (MIT)
//  See: https://github.com/Tanglo/LabBot/blob/master/LICENSE.md
//

#import <Cocoa/Cocoa.h>

/*!
 @brief A class to specify the properties and methods that are common to all dataOutputView classes.
 
 This class exisits to be a parent for other @c DRHDataOutputView classes and so it contains the properties and methods that are common to all dataOutputViews.
 */
@interface DRHDataOutputView : NSView

/// @brief The draw colour of the data output.  Deafult is @code [NSColor redColor] @endcode.
@property NSColor *fgColour;
/// @brief The draw colour of the data output's background.  Deafult is @c nil.
@property NSColor *bgColour;
/// @brief The alternate colour of drawing the data used by some subclasses.  Deafult is @code [NSColor blueColor] @endcode.
@property NSColor *altColour;
/// @brief If YES uses @c altColour instead of @c fgColour.  Default is @c NO.
@property BOOL alternate;

@end
