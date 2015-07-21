//
//  DRHFileDate.m
//  LabBot
//
//  Created by Lee Walsh on 21/08/2014.
//  Copyright (c) 2014 Lee David Walsh. All rights reserved.
//  This sofware is licensed under the The MIT License (MIT)
//  See: https://github.com/Tanglo/LabBot/blob/master/LICENSE.md
//

#import "DRHFileDate.h"

@implementation DRHFileDate

-(id)init{
    if (self = [super init]){
        date = [NSDate date];
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyyMMdd"];
    }
    return self;
}

-(DRHFileDate *)initWithDate:(NSDate *)newDate{
    if (self = [super init]){
        date = newDate;
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyyMMdd"];
    }
    return self;
}

+(DRHFileDate *)fileDateWithDate:(NSDate *)newDate{
    return [[DRHFileDate alloc] initWithDate:newDate];
}

-(void)setDate:(NSDate *)newDate{
    date = newDate;
}

-(NSString *)dateString{
    return [dateFormatter stringFromDate:date];
}

@end
