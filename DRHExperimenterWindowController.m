//
//  DRHExperimenterWindowController.m
//  LandmarkContraction
//
//  Created by Lee Walsh on 8/04/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import "DRHExperimenterWindowController.h"
#import "DRHExperimentDocument.h"
#import "DRHExperiment.h"

@interface DRHExperimenterWindowController ()

@end

@implementation DRHExperimenterWindowController

- (id)init
{
    self = [super initWithWindowNibName:@"DRHExperimenterWindow" owner:self];
    if (self) {
        // Add your subclass-specific initialization here.
        //        NSLog(@"A new DRHLibrariumWindowController has been init");
    }
    return self;
}

-(id)initWithWindowNibName:(NSString *)windowNibName{
    NSLog(@"Error: Use init instead of initWithWindowNibName:");
    return nil;
}
-(id)initWithWindowNibName:(NSString *)windowNibName owner:(id)owner{
    NSLog(@"Error: Use init instead of initWithWindowNibName:owner:");
    return nil;
}
-(id)initWithWindowNibPath:(NSString *)windowNibPath owner:(id)owner{
    NSLog(@"Error: Use init instead of initWithWindowNibPath:owner:");
    return nil;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
//    [experimentNameField setStringValue:[NSString stringWithFormat:@"Experiment: %@",[[[self document] experiment] experimentName]]];
//    [experimentSubjectField setStringValue:[NSString stringWithFormat:@"Subject: %@",[[[self document] experiment] experimentSubject]]];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
//    [experimentDateField setStringValue:[NSString stringWithFormat:@"Date: %@",[dateFormatter stringFromDate:[[[self document] experiment] experimentDate]]]];
}

-(NSTextField *)experimentNameField{
    return experimentNameField;
}

-(NSTextField *)experimentSubjectField{
    return experimentSubjectField;
}

-(NSTextField *)experimentFilenameStemField{
    return experimentFilenameStemField;
}

-(NSDatePicker *)experimentDatePicker{
    return experimentDatePicker;
}

@end
