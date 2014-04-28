//
//  DRHStillCamera.h
//  LandmarkContraction
//
//  Created by Lee Walsh on 9/04/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface DRHStillCamera : NSObject {
    NSArray *availableDevices;
    AVCaptureDevice *device;
    AVCaptureSession *cameraSession;
    AVCaptureStillImageOutput *stillImageOutput;
}
-(NSArray *)availableDevices;
-(AVCaptureStillImageOutput *)stillImageOutput;
-(void)selectDeviceAtIndex:(NSInteger)index;
-(BOOL)startCameraSession;
-(void)stopCameraSession;
-(BOOL)isRunning;

@end
