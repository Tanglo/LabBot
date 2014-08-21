//
//  DRHFileDate.h
//  LabBot
//
//  Created by Lee Walsh on 21/08/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRHFileDate : NSObject{
    NSDate *date;
    NSDateFormatter *dateFormatter;
}

-(DRHFileDate *)initWithDate:(NSDate *)newDate;
+(DRHFileDate *)fileDateWithDate:(NSDate *)newDate;
-(void)setDate:(NSDate *)newDate;
-(NSString *)dateString;

@end
