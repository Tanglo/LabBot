//
//  DRHLabJack.m
//  LabBot
//
//  Created by Lee Walsh on 18/12/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
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
//    printf("How many LabJacks are connected?\n");
    
    NSInteger numU3s = LJUSB_GetDevCount(U3_PRODUCT_ID);
    NSInteger numU6s = LJUSB_GetDevCount(U6_PRODUCT_ID);
    NSInteger numUE9s = LJUSB_GetDevCount(UE9_PRODUCT_ID);
    
//    printf("U3s: %ld\n", numU3s);
//    printf("U6s: %ld\n", numU6s);
//    printf("UE9s: %ld\n", numUE9s);
    
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

@end
