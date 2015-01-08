//
//  DRHDataOutputView.h
//  LabBot
//
//  Created by Lee Walsh on 8/01/2015.
//  Copyright (c) 2015 Dead Rubber Hand. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/*!
 @brief A class to specify the properties and methods that are common to all dataOutputView classes.
 
 This class exisits to be a parent for other @c DRHDataOutputView classes and so it contains the properties and methods that are common to all dataOutputViews.
 */
@interface DRHDataOutputView : NSView

/// @brief The draw colour of the data output.  Deafult is red.
@property NSColor *fgColour;
/// @brief The draw colour of the data output's background.  Deafult is nil.
@property NSColor *bgColour;
/// @brief The alternate colour of drawing the data used by some subclasses.  Deafult is blue.
@property NSColor *altColour;

@end
