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
#import "DRHFileDate.h"

@implementation DRHExperimentData

-(id)init{
    self = [super init];
    if (self) {
        _experimentName = @"";
        _experimentSubject = @"";
        _experimentSession = @"";
        _experimentDate = [NSDate date];
        _experimentFilenameStem = @"";
        _experimentPath = [@"~/Documents" stringByExpandingTildeInPath];
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
        _experimentPath = [aDecoder decodeObjectForKey:@"experimentPath"];
        if (!_experimentPath)
            _experimentPath = [@"~/Documents" stringByExpandingTildeInPath];
        _experimentDataMatrix = [aDecoder decodeObjectForKey:@"experimentDataMatrix"];
        if (!_experimentDataMatrix)
            _experimentDataMatrix = [LBDataMatrix dataMatrix];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_experimentName forKey:@"experimentName"];
    [aCoder encodeObject:_experimentSubject forKey:@"experimentSubject"];
    [aCoder encodeObject:_experimentSession forKey:@"experimentSession"];
    [aCoder encodeObject:_experimentDate forKey:@"experimentDate"];
    [aCoder encodeObject:_experimentFilenameStem forKey:@"experimentFilenameStem"];
    [aCoder encodeObject:_experimentPath forKey:@"experimentPath"];
    [aCoder encodeObject:_experimentDataMatrix forKey:@"experimentDataMatrix"];
}

-(BOOL)writeExperimentDataTo:(NSString *)path{
    NSMutableString *dataString = [NSMutableString stringWithFormat:@"Experiment: %@\n", _experimentName];
    [dataString appendFormat:@"Date: %@\n", [DRHFileDate fileDateWithDate:_experimentDate].dateString];
    [dataString appendFormat:@"Subject: %@\n", _experimentSubject];
    [dataString appendFormat:@"Session: %@\n", _experimentSession];
    NSError *writeError;
    if ([dataString writeToFile:path atomically:YES encoding:NSUnicodeStringEncoding error:&writeError]) {
        return YES;
    } else {
        NSAlert *errorAlert = [NSAlert alertWithError:writeError];
        [errorAlert runModal];
    }
    return NO;
}

-(BOOL)createExperimentSubdirectory:(NSString *)name{
    NSError *fileError;
    NSString *newPath = [_experimentPath stringByAppendingPathComponent:name];
    if ([[NSFileManager defaultManager] createDirectoryAtPath:newPath withIntermediateDirectories:NO attributes:nil error:&fileError]) {
        return YES;
    } else {
        NSAlert *errorAlert = [NSAlert alertWithError:fileError];
        [errorAlert runModal];
    }
    return NO;
}

@end
