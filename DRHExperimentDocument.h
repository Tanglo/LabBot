//
//  DRHDocument.h
//  LandmarkContraction
//
//  Created by Lee Walsh on 8/04/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import <Cocoa/Cocoa.h>

//@class DRHExperiment;
@class DRHExperimenterWindowController;
@class DRHSubjectWindowController;

@interface DRHExperimentDocument : NSDocument {
//    DRHExperiment *experiment;
    DRHExperimenterWindowController *experimenterWindowController;
    DRHSubjectWindowController *subjectWindowController;
    
//    BOOL isNew;
}
@property DRHExperimenterWindowController *experimenterWindowController;
@property DRHSubjectWindowController *subjectWindowController;

#pragma mark Getters
//-(DRHExperiment *)experiment;
-(id)newExperimenterWindowController;

@end
