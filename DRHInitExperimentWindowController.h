//
//  DRHInitExperimentWindowController.h
//  LandmarkContraction
//
//  Created by Lee Walsh on 8/04/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DRHInitExperimentWindowController : NSWindowController

-(IBAction)startExperiment:(id)sender;
-(void)document:(NSDocument *)doc didSave:(BOOL)didSave contextInfo:(void  *)contextInfo;

@end
