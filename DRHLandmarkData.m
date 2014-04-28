//
//  DRHContractingLandmarkData.m
//  ContractingLandmarks
//
//  Created by Lee Walsh on 14/04/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import "DRHLandmarkData.h"
#import "DRHTrialMatrix.h"

@implementation DRHLandmarkData

@synthesize lowerTableCalibationImage,upperTableCalibrationImage;

-(id)init{
    self = [super init];
    if (self) {
        trialMatrix = [NSDictionary dictionaryWithObjectsAndKeys:nil,DRHTrialMatrixFactorsKey,nil,DRHTrialMatrixFactorNamesKey, nil];
//        numberOfTrials = 0;
        currentTrial = -1;
        data = [NSMutableArray arrayWithCapacity:[self numberOfTrials]];
        actualPositionImages = [NSMutableArray array];;
        lowerTableCalibationImage = nil;
        upperTableCalibrationImage = nil;
//        NSLog(@"Number of images: %ld",[data count]);
    }
    return self;
}

-(BOOL)nextTrial{
    if (currentTrial < [self numberOfTrials]-1) {
        currentTrial++;
        return YES;
    }
    return NO;
}

-(NSInteger)numberOfTrials{
    return [[trialMatrix objectForKey:DRHTrialMatrixFactorsKey] count];
}

-(NSInteger)currentTrial{
    return currentTrial;
}

-(NSArray *)currentTrialArray{
    return [[trialMatrix objectForKey:DRHTrialMatrixFactorsKey] objectAtIndex:currentTrial];
}

-(NSArray *)variableNamesArray{
    return [trialMatrix objectForKey:DRHTrialMatrixFactorNamesKey];
}

-(NSArray *)imageData{
    return [NSArray arrayWithArray:data];
}

-(NSArray *)actualPositionImages{
    return [NSArray arrayWithArray:actualPositionImages];
}

-(void)setImageForCurrentTrial:(NSImage *)image{
    if (!image){
        image = [[NSImage alloc] initWithSize:NSMakeSize(50.0, 50.0)];
        NSBezierPath *blankImagePath = [NSBezierPath bezierPathWithRect:NSMakeRect(0.0, 0.0, 50, 50)];
        [[NSColor blackColor] setFill];
        [image lockFocus];
        [blankImagePath fill];
        [image unlockFocus];
    }
    [data insertObject:image atIndex:currentTrial];
}

-(void)addActualPositionImage:(NSImage *)image{
    if (image) {
        [actualPositionImages addObject:image];
    }
}


#pragma mark NSCoding
-(id)initWithCoder:(NSCoder *)aDecoder{
//    NSLog(@"Decoding DRHLandmarkData");
    self = [super init];
    if (self) {
        trialMatrix = [aDecoder decodeObjectForKey:@"trialMatrix"];
        data = [aDecoder decodeObjectForKey:@"data"];
        actualPositionImages = [aDecoder decodeObjectForKey:@"actualPositionImages"];
        lowerTableCalibationImage = [aDecoder decodeObjectForKey:@"lowerTableCalibationImage"];
        upperTableCalibrationImage = [aDecoder decodeObjectForKey:@"upperTableCalibrationImage"];
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
//    NSLog(@"Encoding DRHLandmarkData");
    [aCoder encodeObject:trialMatrix forKey:@"trialMatrix"];
    [aCoder encodeObject:data forKey:@"data"];
    [aCoder encodeObject:actualPositionImages forKey:@"actualPositionImages"];
    [aCoder encodeObject:lowerTableCalibationImage forKey:@"lowerTableCalibationImage"];
    [aCoder encodeObject:upperTableCalibrationImage forKey:@"upperTableCalibrationImage"];
    
}

@end
