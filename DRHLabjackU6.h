//
//  DRHLabjackU6.h
//  LabBot
//
//  Created by Lee Walsh on 18/12/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import "DRHLabJack.h"
#import "u6.h"

/*!
 @brief A class for controlling a LabJack U6 or U6-Pro data aquisition device.
    
    This class provides properties and methods to facilitate interacting with a LabJack U6 or U6-Pro device.  This class is specific to the U6 and U6-Pro.  If you have a different LabJack device you should be using a different subclass of @c DRHLabJack.  If your data aqusition hardware is not a LabJack device you should be using a different subclass of @c DRHDaqDevice.
 */
@interface DRHLabjackU6 : DRHLabJack {
    /// @brief The LabJack U6 device's handle.  Details by LabJack in @c u6.h file.
    HANDLE handle;
    /// @brief A structure for storing calibration constants.  Details by LabJack in @c u6.h file.
    u6CalibrationInfo caliInfo;
    /// @brief The number of sampling analogChannels
    NSInteger numChan;
    /// @brief The number of samples received on each read stream loop;
    NSInteger samplesPerPacket;
}

#pragma mark Initialisers
/*!
 * Initialises the receiver with the specified device handle.
 * @param newHandle The device handle of an exisiting LabJack U6 device.
 * @return The receiver initialised with the specified handle.
 */
-(DRHLabjackU6 *)initWithU6Handle:(HANDLE)newHandle;

/*!
 * Creates a new isntance of @c DRHLabJackU6 and initialises it with the specified device handle.
 * @param newHandle The device handle of an exisiting LabJack U6 device.
 * @return The receiver initialised with the specified handle.
 */
+(DRHLabjackU6 *)deviceWithU6Handle:(HANDLE)newHandle;

#pragma mark Getters
/*!
 * Getter method for the device handle of this initialised LabJack U6 device ID.
 * @return Current @c HANDLE of the LabJack U6 device being controlled by the receiver.
 */
-(HANDLE)handle;

/*!
 * Sends a low-level command to configure the LabJack for analogue streaming.
 * @param scanRate The rate the tha LabJack will scan.  1 scan = 1 measurement from all configured channels.
 * @return @c 0 if successful, else @c -1.
 */
-(NSInteger)configureStreamWithScanRate:(uint16)scanRate;

/*!
 * Sends a low-level command to start the configured stream.
 * @return @c 0 if successful, else @c -1.
 */
-(NSInteger)startStream;

/*!
 * Sends a low-level command to stop any exisiting streams.
 * @return @c 0 if successful, else @c -1.
 */
-(NSInteger)stopStream;

/*!
 * Reads the StreamData low-level function response in a loop.
 * All voltages from the stream are stored in the voltages 2D array.
 * @return @c 0 if successful, else @c -1.
 */
-(NSInteger)readStreamData;

@end
