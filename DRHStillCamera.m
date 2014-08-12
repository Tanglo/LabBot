//
//  DRHStillCamera.m
//  LandmarkContraction
//
//  Created by Lee Walsh on 9/04/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import "DRHStillCamera.h"

@implementation DRHStillCamera

-(id)init{
    self = [super init];
    if (self) {
        NSArray *devices = [AVCaptureDevice devices];
        NSMutableIndexSet *cameraIndexes = [NSMutableIndexSet indexSet];
        for (AVCaptureDevice *currentDevice in devices) {
            if ([currentDevice hasMediaType:AVMediaTypeVideo]) {
                [cameraIndexes addIndex:[devices indexOfObject:currentDevice]];
            }
        }
        availableDevices = [devices objectsAtIndexes:cameraIndexes];
        device = nil;
        stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
        [stillImageOutput setOutputSettings:@{ AVVideoCodecKey : AVVideoCodecJPEG}];
        cameraSession = [[AVCaptureSession alloc] init];
    }
    return self;
}

-(NSArray *)availableDevices{
    return availableDevices;
}

-(AVCaptureStillImageOutput *)stillImageOutput{
    return stillImageOutput;
}

-(void)selectDeviceAtIndex:(NSInteger)index{
    if ([cameraSession isRunning]) {
        [cameraSession stopRunning];
    }
    device = [availableDevices objectAtIndex:index];
}

-(BOOL)startCameraSession{
    NSError *anError;
    if (!device) {
        anError = [NSError errorWithDomain:@"No camera device is selected." code:0 userInfo:nil];
        NSAlert *theAlert = [NSAlert alertWithError:anError];
        [theAlert runModal];
        return NO;
    }
    if ([device isFocusModeSupported:AVCaptureFocusModeAutoFocus])
        [device setFocusMode:AVCaptureFocusModeAutoFocus];
    
    AVCaptureDeviceInput *cameraInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:&anError];
    if (!cameraInput) {
        NSLog(@"Camera input: %@",cameraInput);
        NSAlert *theAlert = [NSAlert alertWithError:anError];
        [theAlert runModal];
        return NO;
    }
    if ([cameraSession canAddInput:cameraInput]) {
        [cameraSession addInput:cameraInput];
    }
    if ([cameraSession canAddOutput:stillImageOutput]) {
        [cameraSession addOutput:stillImageOutput];
    }
    [cameraSession startRunning];
    if ([cameraSession isRunning]) {
        return YES;
    }
    return NO;
}

-(void)stopCameraSession{
    [cameraSession stopRunning];
}

-(BOOL)isRunning{
    if ([cameraSession isRunning]) {
        return YES;
    }
    return NO;
}

@end
