//
//  DRHSubjectWindowController.m
//  LandmarkContraction
//
//  Created by Lee Walsh on 8/04/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import "DRHSubjectWindowController.h"

@interface DRHSubjectWindowController ()

@end

@implementation DRHSubjectWindowController

- (id)init
{
    self = [super initWithWindowNibName:@"DRHSubjectWindow" owner:self];
    if (self) {
        // Add your subclass-specific initialization here.
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
}

@end
