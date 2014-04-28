//
//  DRHMeasureExperimentDocument.h
//  LabBot
//
//  Created by Lee Walsh on 16/04/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DRHExperiment;

@interface DRHMeasureExperimentDocument : NSDocument{
    DRHExperiment *experiment;
}
-(DRHExperiment *)experiment;

@end
