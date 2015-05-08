//
//  DRHExperimenterWindowController.h
//  LandmarkContraction
//
//  Created by Lee Walsh on 8/04/2014.
//  Copyright (c) 2014 Lee David Walsh. All rights reserved.
//  This sofware is licensed under the The MIT License (MIT)
//  See: https://github.com/Tanglo/LabBot/blob/master/LICENSE.md
//

#import <Cocoa/Cocoa.h>

/*!
 @brief A class for controlling the main window of an experiment.
 
 A @c DRHExperimenterWindowController is intended to be used to control the main window of an experiment.  The class is intended to the viewController class in an MVC setup that uses @c DRHExperimentData and so it includes @c IBOutlet instances that match the instance variables of the @c DRHExperimentData class.  It is compulsory to use this class if you use the @c DRHExperimentDocument class.
 
    If subclassing @c DRHExperimentWindowController in Swift it can be easier to override @c windowNibName instead of overriding initailisers.  For example:
 * @code
 * override var windowNibName : String! {
 * return "MyWindowControllerNib"
 * }
 * @endcode
 */
@interface DRHExperimenterWindowController : NSWindowController {
    ///@brief An @c IBOutlet to the @c NSTextField instance that edits the experiment name.
    IBOutlet NSTextField *experimentNameField;
    
    ///@brief An @c IBOutlet to the @c NSTextField instance that edits the experimental subject's identifier.
    IBOutlet NSTextField *experimentSubjectField;
    
    ///@brief An @c IBOutlet to the @c NSTextField instance that edits the name of the experimental session.
    IBOutlet NSTextField *experimentSessionField;
    
    ///@brief An @c IBOutlet to the @c NSTextField instance that edits the filename stem used for creating new data files.
    IBOutlet NSTextField *experimentFilenameStemField;
    
    ///@brief An @c IBOutlet to the @c NSTextField instance that edits the experiment date.
    IBOutlet NSDatePicker *experimentDatePicker;
}
///@brief An @c IBOutlet to the @c NSButton that will start the experiment.
@property (readonly) IBOutlet NSButton *startButton;

///@brief An @c IBOutlet to the @c NSButton that will stop the experiment.
@property (readonly) IBOutlet NSButton *stopButton;

///@brief An @c IBOutlet to the @c NSButton that will finish the experiment so that it cannot be restarted.
@property (readonly) IBOutlet NSButton *finishButton;


/*!
 * A getter method for the @c NSTextField that edits the experiment name.
 * @return The @c NSTextField from the receiver's window that is currently linked to @c experimentNameField.
 */
-(NSTextField *)experimentNameField;

/*!
 * A getter method for the @c NSTextField that edits the experimental subject's.
 * @return The @c NSTextField from the receiver's window that is currently linked to @c experimentSubjectField.
 */
-(NSTextField *)experimentSubjectField;

/*!
 * A getter method for the @c NSTextField that edits the name of the experimental session.
 * @return The @c NSTextField from the receiver's window that is currently linked to @c experimentSessionField.
 */
-(NSTextField *)experimentSessionField;

/*!
 * A getter method for the @c NSTextField that edits the filename stem used for creating new data files.
 * @return The @c NSTextField from the receiver's window that is currently linked to @c experimentFilenameStemField.
 */
-(NSTextField *)experimentFilenameStemField;

/*!
 * A getter method for the @c NSTextField that edits experiment date.
 * @return The @c NSTextField from the receiver's window that is currently linked to @c experimentSessionField.
 */
-(NSDatePicker *)experimentDatePicker;

@end
