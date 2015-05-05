//
//  DRHLabjackU6.h
//  LabBot
//
//  Created by Lee Walsh on 18/12/2014.
//  Copyright (c) 2014 Lee David Walsh. All rights reserved.
//  This sofware is licensed under the The MIT License (MIT)
//  See: https://github.com/Tanglo/LabBot/blob/master/LICENSE.md
//

#import "DRHLabJack.h"
//

/*!
 * @memberof DRHLabjackU6
 * Key for the number of analogue channels in the initialising setting dictionary.
 */
extern NSString * const DRHLabJackU6ConfigNumAnalogueChanKey;
/*!
 * @memberof DRHLabjackU6
 * Key for the scan rate in the initialising setting dictionary.  1 scan is 1 sample of each configured channel.
 */
extern NSString * const DRHLabJackU6ConfigScanRateKey;
/*!
 * @memberof DRHLabjackU6
 * Key for the samples per packet setting in the initialising setting dictionary.  At this stage this should be an integer multiple of the value set for DRHLabJackU6ConfigNumAnalogueChanKey.
 */
extern NSString * const DRHLabJackU6ConfigSamplesPerPacketKey;

/*!
 @brief A class for controlling a LabJack U6 or U6-Pro data aquisition device.
    
    This class provides properties and methods to facilitate interacting with a LabJack U6 or U6-Pro device.  This class is specific to the U6 and U6-Pro.  If you have a different LabJack device you should be using a different subclass of @c DRHLabJack.  If your data aqusition hardware is not a LabJack device you should be using a different subclass of @c DRHDaqDevice.
 */
@interface DRHLabjackU6 : DRHLabJack {
    /// @brief The number of sampling analogChannels
    NSInteger numAnalogueChan;
    /// @brief The number of samples received on each read stream loop.   At this stage this should be an integer multiple of the value set for numAnalogueChan.
    NSInteger samplesPerPacket;
    /// @brief The rate that scans are collected in Hz.  1 scan equals 1 sample from each configured channel.
    NSInteger scanRate;
}

#pragma mark Initialisers
/*!
 * Initialises the receiver with the specified device serial number.
 * @param serialNum The serial number of a LabJack U6 device that is connected to a USB port.
 * @return The receiver initialised with the specified handle.
 */
-(DRHLabjackU6 *)initWithSerialNum:(int)serialNum;

/*!
 * Creates a new instance of @c DRHLabJackU6 and initialises it with the the device with the specified serial number.
 * @param serialNum The serial number of a LabJack U6 device that is connected to a USB port.
 * @return The receiver initialised with the specified handle.
 */
+(DRHLabjackU6 *)u6WithSerialNum:(int)serialNum;

/*!
 * Initialises the receiver with the specified device handle.
 * @param serialNum The device handle of an exisiting LabJack U6 device.
 * @param settings An NSDictionary of the configuration settings.  Keys are defined under class constants.
 * @return The receiver initialised with the specified handle.
 */
-(DRHLabjackU6 *)initForStreamingWithSerialNum:(int)serialNum AndSettings:(NSDictionary *)settings;

/*!
 * Creates a new instance of @c DRHLabJackU6 and initialises it with the specified device handle.
 * @param serialNum The device handle of an exisiting LabJack U6 device.
 * @param settings An NSDictionary of the configuration settings.  Keys are defined under class constants.
 * @return The receiver initialised with the specified handle.
 */
+(DRHLabjackU6 *)u6ForStreamingWithSerialNum:(int)serialNum AndSettings:(NSDictionary *)settings;

#pragma mark Getters
/*!
 * Getter method for the device handle of this initialised LabJack U6 device ID.
 * @return Current @c HANDLE of the LabJack U6 device being controlled by the receiver.
 */
-(void *)handle;

/*!
 * Reads a single sample from a single analogue channel.  Intended for calibration routines.
 * @param channel The number of the analogue channel to read one sample from.
 * @return Returns the voltage read as a @c NSNumber.
 */
-(NSNumber *)readOneSampleFromAnalogueChannel:(uint8)channel;

/*!
 * Reads a single sample from a single analogue channel and then closes the device.  Intended for calibration routines.
 * @param channel The number of the analogue channel to read one sample from.
 * @param serialNum The serial number of the U6 device to sample from.
 * @return Returns the voltage read as a @c NSNumber.
 */
+(NSNumber *)readOneSampleFromAnalogueChannel:(uint8)channel AndDeviceWithSerialNum:(int)serialNum;

/*!
 * Sends a low-level command to configure the LabJack for analogue streaming.
 * @return @c 0 if successful, else @c -1.
 */
-(BOOL)configureStream;

/*!
 * Sends a low-level command to start the configured stream.
 * @return @c 0 if successful, else @c -1.
 */
-(BOOL)startStream;

/*!
 * Sends a low-level command to stop any exisiting streams.
 * @return @c 0 if successful, else @c -1.
 */
-(BOOL)stopStream;

/*!
 * Reads the StreamData low-level function response in a loop.
 * All voltages from the stream are stored in the voltages 2D array.
 * @return @c Nill if error, otherwise an array of arrays where each sub array represents a scan and contains NSNumbers of the sampled data from each streaming analogue channel.
 */
-(NSArray *)readStreamData;

/*!
 * Closes the LabJack U6
 */
-(void)close;

@end
