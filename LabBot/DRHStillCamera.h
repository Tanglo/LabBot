//
//  DRHStillCamera.h
//  LandmarkContraction
//
//  Created by Lee Walsh on 9/04/2014.
//  Copyright (c) 2014 Lee David Walsh. All rights reserved.
//  This sofware is licensed under the The MIT License (MIT)
//  See: https://github.com/Tanglo/LabBot/blob/master/LICENSE.md
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

/*!
 @brief A class for selecting, setting up, starting and stopping a usb camera to take still images.
 
 This class simplifies the setting up of camera devices for still image capture.  It has methods to that provide a list of available hardware and selecting a device from that list.  Setup of the @c AVCaptureSession and @c AVCaptureOutput are done in the @c startCameraSession before the capture session is started.  Using this class a USB webcam can be ready to capture still images in few method calls.
 
 Use of this class will typically involve getting the array of available devices using the @c availableDevices method and then selecting one of those devices to be used for still image capture using @c selectDeviceAtIndex:.  After a camera device is selected it should be started using @c startCameraSession.  If the session is sucessfully started images can be captured by sending the @c captureStillImageAsynchronouslyFromConnection: method to the @c stillImageOutput of the @c DRHStillCamera using an initialised @c AVCaptureConnection.  For example:
 @code
 //Setup and start a camera device
 DRHStillCamera *camera = [[DRHStillCamera alloc] init];
 NSArray *cameras = [camera availableDevices];
 [camera selectDeviceAtIndex:1];
 if (![[[self document] camera] startCameraSession]){
    NSAlert *anAlert = [NSAlert alertWithMessageText:@"Could not start the camera" defaultButton:@"Bugger" alternateButton:nil otherButton:nil informativeTextWithFormat:@"Something is wrong with the camera, it couldn't be started."];
    [anAlert runModal];
 }
 
 //Setup a video connection to capture still images
 AVCaptureConnection *videoConnection = nil;
 for (AVCaptureConnection *connection in [[[self document] camera] stillImageOutput].connections) {
    for (AVCaptureInputPort *port in [connection inputPorts]) {
        if ([[port mediaType] isEqual:AVMediaTypeVideo] ) {
            videoConnection = connection;
            break;
        }
    }
    if (videoConnection) { break; }
 }
 
 //Capture still images
 [[camera stillImageOutput] captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:
    ^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
        CFDictionaryRef exifAttachments =
        CMGetAttachment(imageSampleBuffer, kCGImagePropertyExifDictionary, NULL);
        if (exifAttachments) {
            // Do something with the attachments.
        }
        // So something with the captured image, such as convert it to NSData
        NSData *capturedImageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
 
        //Do other things.
 
 }];
 @endcode
 
 */
@interface DRHStillCamera : NSObject {
    /// @brief An array of @c AVCaptureDevice objects that are capable of caputre the media type @c AVMediaTypeVideo.
    NSArray *availableDevices;
    
    /// @brief The currently selected @c AVCaptureDevice from the array of @c availableDevices.
    AVCaptureDevice *device;
    
    /// @brief The @c AVCaptureSession used to run the selected camera device.
    AVCaptureSession *cameraSession;
    
    /// @brief The @c AVCaptureOutput used to run the selected camera device as a still cammera.
    AVCaptureStillImageOutput *stillImageOutput;
}

/*!
 * A getter method for the array of @c AVCaptureDevice available to use as a still camera.
 * @return An array of @c AVCaptureDevice objects that are capable of @c AVMediaTypeVideo.
 */
-(NSArray *)availableDevices;

/*!
 * A getter for the still image output steam used to retrieve still images from the selected camera device.
 * @return The @c AVCaptureStillImageOutput object for the currently selected camera device.
 */
-(AVCaptureStillImageOutput *)stillImageOutput;

/*!
 * Selects one of the camera devices in the @c availableDevices array.  The selected device will be acted upon by future calls to @c startCameraSession, @c stopCameraSession and @c isRunning.
 * @param index The index of a @c AVCaptureDevice currently in @c availableDevices.
 */
-(void)selectDeviceAtIndex:(NSInteger)index;

/*!
 * Checks that a camera device has been selected then initialises the input and output of the selected camera device before starting the device.
 * @return Returns @c YES if all initialisation was sucessfully completed and the camera session was successfully started.  Otherwise returns @c NO.
 */
-(BOOL)startCameraSession;

/*!
 * Stops the current session of the selected camera device.
 */
-(void)stopCameraSession;

/*!
 * Used to check if the currently selected camera device is currently running, that is has an active @c AVCaptureSession.
 * @return @c YES if the selected camera device is currently running an @c AVCaptureSession, otherwise @c NO.
 */
-(BOOL)isRunning;

/*!
 * Returns the current focusMode of the receiver.
 * @return The current @c AVCaptureFocusMode of the camera.
 */
-(AVCaptureFocusMode)focusMode;

/*!
 * Sets the focusMode of the receiver if it is available.
 * @param focusMode The focusMode to set on the receiver.
 * @return @c YES if the new focusMode was sucessfully set, otherwise @c NO.
 */
-(BOOL)setFocusMode:(AVCaptureFocusMode)focusMode;

@end
