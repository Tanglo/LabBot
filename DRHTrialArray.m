//
//  DRHTrialArray.m
//  LabBot
//
//  Created by Lee Walsh on 23/07/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import "DRHTrialArray.h"

@implementation DRHTrialArray

@synthesize trialsArrayName;

-(id)init{
    if (self = [super init]) {
        trialsArrayName = nil;
        trialData = nil;
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        trialsArrayName = [aDecoder decodeObjectForKey:@"trialsArrayName"];
        if (!trialsArrayName) {
            trialsArrayName = nil;
        }
        trialData = [aDecoder decodeObjectForKey:@"trialData"];
        if (!trialData) {
            trialData = nil;
        }
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:trialsArrayName forKey:@"trialsArrayName"];
    [aCoder encodeObject:trialData forKey:@"trialData"];
}

-(DRHTrialArray *)initWithName:(NSString *)name AndArray:(NSArray *)array{
    if (self = [super init]) {
        trialsArrayName = name;
        trialData = array;
    }
    return self;
}

-(NSArray *)trials{
    return trialData;
}

-(NSInteger)count{
    return [trialData count];
}

-(id)trialAtIndex:(NSInteger)index{
    return [trialData objectAtIndex:index];
}

/*+(DRHTrialArray *)trialArrayWithName:(NSString *)name{
    return [[self alloc] initWithName:name];
}*/

+(DRHTrialArray *)trialArrayWithName:(NSString *)name AndArray:(NSArray *)array{
    DRHTrialArray *newArray = [[self alloc] initWithName:name AndArray:array];
    [newArray setTrialsArrayName:name];
    return newArray;
}

+(DRHTrialArray *)trialArrayWithName:(NSString *)name OfNanWithLength:(NSInteger)length{
    NSMutableArray *newArray = [NSMutableArray array];
    for (NSInteger i=0; i<length; i++) {
        [newArray addObject:[NSDecimalNumber notANumber]];
    }
    return [DRHTrialArray trialArrayWithName:name AndArray:newArray];
}

+(DRHTrialArray *)linearTrialArrayWithName:(NSString *)name OfIntegersFrom:(NSInteger)start To:(NSInteger)end WithIncrement:(NSInteger)increment AndRepetitions:(NSInteger)repetitions{
    NSMutableArray *newArray = [NSMutableArray array];
    for (NSInteger i=start; i<=end; i+=increment) {
        for (NSInteger j=0; j<repetitions; j++) {
            [newArray addObject:[NSDecimalNumber numberWithInteger:i]];
        }
    }
    return [DRHTrialArray trialArrayWithName:name AndArray:newArray];
}

+(DRHTrialArray *)linearTrialArrayWithName:(NSString *)name OfDoublesFrom:(CGFloat)start To:(CGFloat)end WithIncrement:(CGFloat)increment AndRepetitions:(NSInteger)repetitions{
    NSMutableArray *newArray = [NSMutableArray array];
    CGFloat currentDouble = start;
    do {
        for (NSInteger j=0; j<repetitions; j++) {
            [newArray addObject:[NSDecimalNumber numberWithDouble:currentDouble]];
        }
        currentDouble += increment;
    } while (currentDouble < end);
    return [DRHTrialArray trialArrayWithName:name AndArray:newArray];
}

+(DRHTrialArray *)trialArrayWithName:(NSString *)name ByRepeatingArray:(NSArray *)array WithRepetitions:(NSInteger)repetitions{
    NSMutableArray *newArray = [NSMutableArray array];
    for (NSInteger i=0; i<repetitions; i++) {
        [newArray addObjectsFromArray:array];
    }
    return [DRHTrialArray trialArrayWithName:name AndArray:newArray];
}

+(DRHTrialArray *)shuffledTrialArrayWithName:(NSString *)name And:(NSArray *)array{
    NSMutableArray *temp = [[NSMutableArray alloc] initWithArray:array];
    
    for(NSUInteger i = [array count]; i > 1; i--) {
        NSUInteger j = arc4random_uniform((uint32)i);
        [temp exchangeObjectAtIndex:i-1 withObjectAtIndex:j];
    }
    
    return [DRHTrialArray trialArrayWithName:name AndArray:temp];
}


@end
