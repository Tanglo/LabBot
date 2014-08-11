//
//  DRHExperiment.h
//  LandmarkContraction
//
//  Created by Lee Walsh on 8/04/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DRHTrialMatrix;

__attribute__((deprecated))
@interface DRHExperiment : NSObject <NSCoding>{
    NSString *experimentName;
    NSString *experimentSubject;
    NSString *experimentSession;
    NSDate *experimentDate;
    NSString *experimentFilenameStem;
    
    DRHTrialMatrix *trials;
    NSMutableArray *data;
}
@property NSString *experimentName;
@property NSString *experimentSubject;
@property NSString *experimentSession;
@property NSDate *experimentDate;
@property NSString *experimentFilenameStem;

-(DRHTrialMatrix *)trials;
-(NSMutableArray *)data;

@end
