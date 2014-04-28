//
//  DRHContractingLandmarkData.h
//  ContractingLandmarks
//
//  Created by Lee Walsh on 14/04/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRHLandmarkData : NSObject <NSCoding> {
    NSDictionary *trialMatrix;
//    NSInteger numberOfTrials;
    NSInteger currentTrial;
    NSMutableArray *data;
    NSMutableArray *actualPositionImages;
    NSImage *lowerTableCalibationImage;
    NSImage *upperTableCalibrationImage;
}
@property NSImage *lowerTableCalibationImage;
@property NSImage *upperTableCalibrationImage;

-(BOOL)nextTrial;
-(NSInteger)numberOfTrials;
-(NSInteger)currentTrial;
-(NSArray *)currentTrialArray;
-(NSArray *)variableNamesArray;
-(NSArray *)imageData;
-(NSArray *)actualPositionImages;
-(void)setImageForCurrentTrial:(NSImage *)image;
-(void)addActualPositionImage:(NSImage *)image;

@end
