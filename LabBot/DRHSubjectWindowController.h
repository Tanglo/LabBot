//
//  DRHSubjectWindowController.h
//  LabBot
//
//  Created by Lee Walsh on 8/04/2014.
//  Copyright (c) 2014 Lee David Walsh. All rights reserved.
//  This sofware is licensed under the The MIT License (MIT)
//  See: https://github.com/Tanglo/LabBot/blob/master/LICENSE.md
//

#import <Cocoa/Cocoa.h>

/*!
 @brief A class for controlling the window that is shown to the experiemntal subject.
 
 A @c DRHSubjectWindowController is intended to be used to control a window to presents visual stimulii to the experimental subject.  The subject window will often need to be placed on a secondary display so this class has methods to faciliate that situation.
 */
@interface DRHSubjectWindowController : NSWindowController

///@brief The screen number on which to display this window. Default is @c 0.
@property (readonly) NSInteger screenNumber;

///@brief Should this controllers window be displayed full screen?  Default is @c YES.
@property (readonly) BOOL fullScreen;

/*! Initiates a new subjectWindowController with a specified screenNumber and fullScreen setting.
 * @param newScreenNumber The integer number of the screen to draw this window controllers window on.
 * @param newFullScreen A boolean that determines whether this window controller's window will be drawn full screen.
 * @return A @c DRHSubjectWindowController that has been initiatlised with the specified @c screenNumber and @c fullScreen values.
 */
-(DRHSubjectWindowController *)initWithScreenNumber:(NSInteger)newScreenNumber AndFullScreen:(BOOL)newFullScreen;

/*! Creates and initialised a new subjectWindowController with a specified screenNumber and fullScreen setting.
 * @param screenNumber The integer number of the screen to draw this window controllers window on.
 * @param fullScreen A boolean that determines whether this window controller's window will be drawn full screen.
 * @return A newly created @c DRHSubjectWindowController that has been initiatlised with the specified @c screenNumber and @c fullScreen values.
 */
+(DRHSubjectWindowController *)subjectWindowControllerWithScreenNumber:(NSInteger)screenNumber AndFullScreen:(BOOL)fullScreen;

@end
