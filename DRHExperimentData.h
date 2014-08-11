//
//  DRHExperimentData.h
//  LabBot
//
//  Created by Lee Walsh on 11/08/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRHDataMatrix.h"

@interface DRHExperimentData : NSObject <NSCoding>

@property NSString *experimentName;
@property NSString *experimentSubject;
@property NSString *experimentSession;
@property NSDate *experimentDate;
@property NSString *experimentFilenameStem;
@property DRHDataMatrix *experimentDataMatrix;

@end
