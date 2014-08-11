//
//  DRHExperimenterWindowController.h
//  LandmarkContraction
//
//  Created by Lee Walsh on 8/04/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DRHExperimenterWindowController : NSWindowController {
    IBOutlet NSTextField *experimentNameField;
    IBOutlet NSTextField *experimentSubjectField;
    IBOutlet NSTextField *experimentSessionField;
    IBOutlet NSTextField *experimentFilenameStemField;
    IBOutlet NSDatePicker *experimentDatePicker;
}
-(NSTextField *)experimentNameField;
-(NSTextField *)experimentSubjectField;
-(NSTextField *)experimentSessionField;
-(NSTextField *)experimentFilenameStemField;
-(NSDatePicker *)experimentDatePicker;

@end
