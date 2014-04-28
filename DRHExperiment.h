//
//  DRHExperiment.h
//  LandmarkContraction
//
//  Created by Lee Walsh on 8/04/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRHExperiment : NSObject <NSCoding>{
    NSString *experimentName;
    NSString *experimentFilenameStem;
    NSString *experimentSubject;
    NSDate *experimentDate;
//    id experimentData;
}
@property NSString *experimentName;
@property NSString *experimentFilenameStem;
@property NSString *experimentSubject;
@property NSDate *experimentDate;
//@property id experimentData;

@end
