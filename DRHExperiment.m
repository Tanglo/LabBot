//
//  DRHExperiment.m
//  LandmarkContraction
//
//  Created by Lee Walsh on 8/04/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import "DRHExperiment.h"

@implementation DRHExperiment

@synthesize experimentName,experimentFilenameStem,experimentSubject,experimentDate; //,experimentData;

-(id)init{
    self = [super init];
    if (self) {
        experimentName = @"";
        experimentFilenameStem = @"";
        experimentSubject = @"";
        experimentDate = [NSDate date];
    }
    return self;
}

#pragma mark NSCoding
-(id)initWithCoder:(NSCoder *)aDecoder{
//    NSLog(@"Decoding DRHExperiment");
    self = [super init];
    if (self) {
        experimentName = [aDecoder decodeObjectForKey:@"experimentName"];
        experimentFilenameStem = [aDecoder decodeObjectForKey:@"experimentFilenameStem"];
        experimentSubject = [aDecoder decodeObjectForKey:@"experimentSubject"];
        experimentDate = [aDecoder decodeObjectForKey:@"experimentDate"];
//        experimentData = [aDecoder decodeObjectForKey:@"experimentData"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
//    NSLog(@"Encoding DRHExperiment");
    [aCoder encodeObject:experimentName forKey:@"experimentName"];
    [aCoder encodeObject:experimentFilenameStem forKey:@"experimentFilenameStem"];
    [aCoder encodeObject:experimentSubject forKey:@"experimentSubject"];
    [aCoder encodeObject:experimentDate forKey:@"experimentDate"];
//    [aCoder encodeObject:experimentData forKey:@"experimentData"];
}

@end
