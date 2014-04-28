//
//  DRHInitExperimentWindowController.m
//  LandmarkContraction
//
//  Created by Lee Walsh on 8/04/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import "DRHInitExperimentWindowController.h"
#import "DRHExperimenterWindowController.h"
#import "DRHExperimentDocument.h"
#import "DRHExperiment.h"

@interface DRHInitExperimentWindowController ()

@end

@implementation DRHInitExperimentWindowController

- (id)init
{
    self = [super initWithWindowNibName:@"DRHInitExperimentWindow" owner:self];
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
}

-(IBAction)startExperiment:(id)sender{
/*    [[sender window] makeFirstResponder:nil];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
//    NSString *filename = [NSString stringWithFormat:@"%@ %@ %@.experiment",[[[self document] experiment] experimentFilenameStem],[[[self document] experiment] experimentSubject],[dateFormatter stringFromDate:[[[self document] experiment] experimentDate]]];
//    [[self document] setFileURL:[NSURL fileURLWithPath:[[NSString stringWithFormat:@"~/%@",filename] stringByExpandingTildeInPath]]];
//    [[self document] setFileType:@"com.DRH.experiment"];
//    NSURL *fileURL = [NSURL fileURLWithPath:[[NSString stringWithFormat:@"~/%@",filename] stringByExpandingTildeInPath]];
//    [[self document] saveDocumentWithDelegate:self didSaveSelector:@selector(document:didSave:contextInfo:) contextInfo:nil];
    NSSavePanel *savePanel = [NSSavePanel savePanel];
    [savePanel setNameFieldStringValue:filename];
    [savePanel setExtensionHidden:NO];
    [savePanel beginSheetModalForWindow:[self window] completionHandler:^(NSInteger result){
        if (result) {
            [[self document] saveToURL:[savePanel URL] ofType:@"com.DRH.experiment" forSaveOperation:NSSaveOperation delegate:self didSaveSelector:@selector(document:didSave:contextInfo:) contextInfo:nil];
        }
    }];
//    [[self document] saveToURL:[savePanel URL] ofType:@"com.DRH.experiment" forSaveOperation:NSSaveOperation delegate:self didSaveSelector:@selector(document:didSave:contextInfo:) contextInfo:nil];*/
}

-(void)document:(NSDocument *)doc didSave:(BOOL)didSave contextInfo:(void  *)contextInfo{
    if (didSave) {
//        DRHExperimenterWindowController *newWindowController = [[DRHExperimenterWindowController alloc] init];
        [[self document] setExperimenterWindowController:[[self document] newExperimenterWindowController]];
        [[self document] addWindowController:[[self document] experimenterWindowController]];
        [[self document] showWindows];
        [self close];
    } else {
        NSError *anError = [NSError errorWithDomain:@"Experiment could not be saved" code:0 userInfo:nil];
        NSAlert *theAlert = [NSAlert alertWithError:anError];
        [theAlert runModal];
    }
    
}

@end
