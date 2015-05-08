//
//  DRHExperimentData.m
//  LabBot
//
//  Created by Lee Walsh on 11/08/2014.
//  Copyright (c) 2014 Lee David Walsh. All rights reserved.
//  This sofware is licensed under the The MIT License (MIT)
//  See: https://github.com/Tanglo/LabBot/blob/master/LICENSE.md
//

#import "DRHExperimentData.h"

@implementation DRHExperimentData

-(id)init{
    self = [super init];
    if (self) {
        _experimentName = @"";
        _experimentSubject = @"";
        _experimentSession = @"";
        _experimentDate = [NSDate date];
        _experimentFilenameStem = @"";
        _experimentDataMatrix = [LBDataMatrix dataMatrix];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        _experimentName = [aDecoder decodeObjectForKey:@"experimentName"];
        if (!_experimentName)
            _experimentName = @"";
        _experimentSubject = [aDecoder decodeObjectForKey:@"experimentSubject"];
        if (!_experimentSubject)
            _experimentSubject = @"";
        _experimentSession = [aDecoder decodeObjectForKey:@"experimentSession"];
        if (!_experimentSession)
            _experimentSession = @"";
        _experimentDate = [aDecoder decodeObjectForKey:@"experimentDate"];
        if (!_experimentDate)
            _experimentDate = [NSDate date];
        _experimentFilenameStem = [aDecoder decodeObjectForKey:@"experimentFilenameStem"];
        if (!_experimentFilenameStem)
            _experimentFilenameStem = @"";
        _experimentDataMatrix = [aDecoder decodeObjectForKey:@"experimentDataMatrix"];
        if (!_experimentDataMatrix)
            _experimentDataMatrix = nil;
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_experimentName forKey:@"experimentName"];
    [aCoder encodeObject:_experimentSubject forKey:@"experimentSubject"];
    [aCoder encodeObject:_experimentSession forKey:@"experimentSession"];
    [aCoder encodeObject:_experimentDate forKey:@"experimentDate"];
    [aCoder encodeObject:_experimentFilenameStem forKey:@"experimentFilenameStem"];
    [aCoder encodeObject:_experimentDataMatrix forKey:@"experimentDataMatrix"];
}

@end
