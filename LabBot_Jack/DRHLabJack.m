//
//  DRHLabJack.m
//  LabBot
//
//  Created by Lee Walsh on 18/12/2014.
//  Copyright (c) 2014 Lee David Walsh. All rights reserved.
//  This sofware is licensed under the The MIT License (MIT)
//  See: https://github.com/Tanglo/LabBot/blob/master/LICENSE.md
//

#import "DRHLabJack.h"
#import "/usr/local/include/labjackusb.h"

NSString * const DRHLabJackU3DeviceKey = @"LJU3";
NSString * const DRHLabJackU6DeviceKey = @"LJU6";
NSString * const DRHLabJackUE9DeviceKey = @"LJUE9";

NSString * const DRHStreamedDataKey = @"DRHStreamedData";
NSString * const DRHLabJackStreamBacklogKey = @"DRHLabJackBacklog";

@implementation DRHLabJack

+(NSDictionary *)numberOfConnectedLabJackDevices{
    
    NSInteger numU3s = LJUSB_GetDevCount(U3_PRODUCT_ID);
    NSInteger numU6s = LJUSB_GetDevCount(U6_PRODUCT_ID);
    NSInteger numUE9s = LJUSB_GetDevCount(UE9_PRODUCT_ID);
    
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:numU3s],DRHLabJackU3DeviceKey,[NSNumber numberWithInteger:numU6s],DRHLabJackU6DeviceKey,[NSNumber numberWithInteger:numUE9s],DRHLabJackUE9DeviceKey, nil];
}

-(BOOL)startStream{
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return NO;
}

-(BOOL)stopStream{
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return NO;
}

-(NSArray *)readStreamData{
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return nil;
}

-(void)closeConnection{
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
}

@end
