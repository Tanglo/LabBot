//
//  DRHDocument.h
//  LandmarkContraction
//
//  Created by Lee Walsh on 8/04/2014.
//  Copyright (c) 2014 Lee David Walsh. All rights reserved.
//  This sofware is licensed under the The MIT License (MIT)
//  See: https://github.com/Tanglo/LabBot/blob/master/LICENSE.md
//

#import <Cocoa/Cocoa.h>

@class DRHExperimenterWindowController;
@class DRHSubjectWindowController;


/*!
 @brief A document object to handle the saving and opening of experiment data files.
 
 A @c DRHExperimentDocument object can be used to control the saving of LabBot experiment data files in the usual @c NSDocument way.  Similar to the @c NSDocument class, it is intended that @c DRHExperimentDocument be subclassed rather than using it out right.  As for @c NSDocument, when you subclass @c DRHExperimentDocument you must override one reading and one writing method. In the simplest case, you can override the data-based reading and writing methods, @c readFromData:ofType:error: and @c dataOfType:error:.  In addition you must also override @c newExperimenterWindowController to create and return an @c DRHExperimenterWindowController object to control the main document window.  If you don't want to use a @c DRHExperimenterWindowController as you main window controller or you want to avoid the use of window controllers altogether you should subclass @c NSDocument instead.
 
 @note This class is in its infancy and as of version 0.2 of the LabBot framework the functionality of @c DRHExperimentDocument is basic.  The only features it adds to the standard @c NSDocument funcationality is to store instances of @c DRHExperimenterWindowController and @c DRHSubjectWindowController and enforce and manage the creation of a single @c DRHExperimenterWindowController object.  In many cases it will be easier to use a subclass of @c NSDocument.
 */
@interface DRHExperimentDocument : NSDocument {
    /// @brief The controller for the main window of the experiment application.
    DRHExperimenterWindowController *experimenterWindowController;
    
    /// @brief A window controller to control the window that the experimental subject sees.
    DRHSubjectWindowController *subjectWindowController;
}
@property DRHExperimenterWindowController *experimenterWindowController;
@property DRHSubjectWindowController *subjectWindowController;

#pragma mark Getters
/*!
 It is compulsory to override this function.  It should return an instance of a @c DRHExperimenterWindowController object that is used to control the receiver's main window.
 
 This method is called by @c makeWindowControllers and the returned object is added to the receivers window controllers and set as the value for the receiver's @c experimentWindowController property.
 @return An instance of @c DRHExperimenterWindowController that will become the window controller for the reciever's main window.
 */
-(id)newExperimenterWindowController;

@end
