//
//  DRHExperiment.m
//  LandmarkContraction
//
//  Created by Lee Walsh on 8/04/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import "DRHExperiment.h"
#import "DRHTrialMatrix.h"

@implementation DRHExperiment

@synthesize experimentName,experimentSubject,experimentSession,experimentDate,experimentFilenameStem;

-(id)init{
    self = [super init];
    if (self) {
        experimentName = @"";
        experimentSubject = @"";
        experimentSession = @"";
        experimentDate = [NSDate date];
        experimentFilenameStem = @"";
        
        trials = [[DRHTrialMatrix alloc] init];
        data = [NSMutableArray array];
    }
    return self;
}

-(DRHTrialMatrix *)trials{
    return trials;
}

-(NSMutableArray *)data{
    return data;
}

#pragma mark NSCoding
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        experimentName = [aDecoder decodeObjectForKey:@"experimentName"];
        experimentSubject = [aDecoder decodeObjectForKey:@"experimentSubject"];
        experimentSession = [aDecoder decodeObjectForKey:@"experimentSession"];
        experimentDate = [aDecoder decodeObjectForKey:@"experimentDate"];
        experimentFilenameStem = [aDecoder decodeObjectForKey:@"experimentFilenameStem"];
        
        trials = [aDecoder decodeObjectForKey:@"trials"];
        data = [aDecoder decodeObjectForKey:@"data"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:experimentName forKey:@"experimentName"];
    [aCoder encodeObject:experimentSubject forKey:@"experimentSubject"];
    [aCoder encodeObject:experimentSession forKey:@"experimentSession"];
    [aCoder encodeObject:experimentDate forKey:@"experimentDate"];
    [aCoder encodeObject:experimentFilenameStem forKey:@"experimentFilenameStem"];
    
    [aCoder encodeObject:trials forKey:@"trials"];
    [aCoder encodeObject:data forKey:@"data"];
}

@end
