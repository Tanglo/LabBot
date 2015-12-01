//
//  DRHSubjectWindowController.m
//  LabBot
//
//  Created by Lee Walsh on 8/04/2014.
//  Copyright (c) 2014 Lee David Walsh. All rights reserved.
//  This sofware is licensed under the The MIT License (MIT)
//  See: https://github.com/Tanglo/LabBot/blob/master/LICENSE.md
//

#import "DRHSubjectWindowController.h"

@interface DRHSubjectWindowController ()

@end

@implementation DRHSubjectWindowController

@synthesize screenNumber, fullScreen;

- (id)init
{
    self = [super initWithWindowNibName:@"DRHSubjectWindow" owner:self];
    if (self) {
        // Add your subclass-specific initialization here.
        screenNumber = 0;
        fullScreen = YES;
    }
    return self;
}

-(DRHSubjectWindowController *)initWithScreenNumber:(NSInteger)newScreenNumber AndFullScreen:(BOOL)newFullScreen{
    if (self = [self init]){
        screenNumber = newScreenNumber;
        fullScreen = newFullScreen;
    }
    return self;
}

+(DRHSubjectWindowController *)subjectWindowControllerWithScreenNumber:(NSInteger)screenNumber AndFullScreen:(BOOL)fullScreen{
    return [[DRHSubjectWindowController alloc] initWithScreenNumber:screenNumber AndFullScreen:fullScreen];
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
    if (screenNumber < [[NSScreen screens] count]) {
        if (fullScreen) {
            [[self window] setStyleMask:NSBorderlessWindowMask];
            [[self window] setFrame:[[[NSScreen screens] objectAtIndex:screenNumber] frame] display:YES];
        } else {
            NSArray *screenArray = [NSScreen screens];
            NSRect screenRect = [[screenArray objectAtIndex:screenNumber] visibleRect];
            NSRect subjWinRect = [[self window] frame];
            subjWinRect.origin.x += screenRect.origin.x;
            subjWinRect.origin.y += screenRect.origin.y;
        }
    } else {
        NSAlert *alert = [NSAlert alertWithMessageText:@"Subject screen is not avaialble" defaultButton:@"Lame." alternateButton:nil otherButton:nil informativeTextWithFormat:@"You have asked for the subject window to be put on a screen that is not available"];
        [alert runModal];
    }
}

@end
