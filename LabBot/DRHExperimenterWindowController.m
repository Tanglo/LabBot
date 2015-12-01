//
//  DRHExperimenterWindowController.m
//  LabBot
//
//  Created by Lee Walsh on 8/04/2014.
//  Copyright (c) 2014 Lee David Walsh. All rights reserved.
//  This sofware is licensed under the The MIT License (MIT)
//  See: https://github.com/Tanglo/LabBot/blob/master/LICENSE.md
//

#import "DRHExperimenterWindowController.h"
#import "DRHExperimentDocument.h"

@interface DRHExperimenterWindowController ()

@end

@implementation DRHExperimenterWindowController

@synthesize startButton, stopButton, finishButton;

- (id)init
{
    self = [super initWithWindowNibName:@"DRHExperimenterWindow" owner:self];
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
    [[[[self document] experimenterWindowController] experimentDatePicker] setDateValue:[NSDate date]];
}

-(NSTextField *)experimentNameField{
    return experimentNameField;
}

-(NSTextField *)experimentSubjectField{
    return experimentSubjectField;
}

-(NSTextField *)experimentSessionField{
    return experimentSessionField;
}

-(NSTextField *)experimentFilenameStemField{
    return experimentFilenameStemField;
}

-(NSDatePicker *)experimentDatePicker{
    return experimentDatePicker;
}

-(BOOL)experimentIsFinished{
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return NO;
}

@end
