//
//  DRHDocument.h
//  LandmarkContraction
//
//  Created by Lee Walsh on 8/04/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DRHExperimenterWindowController;
@class DRHSubjectWindowController;

@interface DRHExperimentDocument : NSDocument {
    DRHExperimenterWindowController *experimenterWindowController;
    DRHSubjectWindowController *subjectWindowController;
}
@property DRHExperimenterWindowController *experimenterWindowController;
@property DRHSubjectWindowController *subjectWindowController;

#pragma mark Getters
-(id)newExperimenterWindowController;

@end
