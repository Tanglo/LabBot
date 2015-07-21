//
//  DRHLabJack.h
//  LabBot
//
//  Created by Lee Walsh on 18/12/2014.
//  Copyright (c) 2014 Lee David Walsh. All rights reserved.
//  This sofware is licensed under the The MIT License (MIT)
//  See: https://github.com/Tanglo/LabBot/blob/master/LICENSE.md
//

#import "DRHDaqDevice.h"

extern NSString * const DRHLabJackU3DeviceKey;
extern NSString * const DRHLabJackU6DeviceKey;
extern NSString * const DRHLabJackUE9DeviceKey;

extern NSString * const DRHStreamedDataKey;
extern NSString * const DRHLabJackStreamBacklogKey;

/*!
 @brief The parent class used to interact with LabJack data aqusition hardware.
 
 This parent class implmements properties and methods that are common to LabJack hardware.  It is then subclassed for each specific devices.  Most of the time you should not be using an instance of this class but a subclass of it specific to your LabJack hardware.
 */
@interface DRHLabJack : DRHDaqDevice
//cat

/*!
 * Checks how many LabJack devices are connected and returns the number of devices and their type.  The number of devices are stored as @c NSNumber objects keyed to the @c DRHLabJackProductIDX where @c X is the device type.  Valid value for @c X are @c U3, @c U6 and @c UE9.
 * @return An @c NSDictionary object containing the number of each type of recognised LabJack device (U3, U6 and UE9).
 */
+(NSDictionary *)numberOfConnectedLabJackDevices;

/*!
 * As a subclass of @c DRHDaqDevice, it is compulsory for subclasses to override this method so that all @c DRHDaqDevice classes are compatible with @c DRHSamplingOperation.
 
 * Starts a configured data streaming session on the receiver's LabJack.
 * @return @c YES if successful, else @c NO.
 */
-(BOOL)startStream;

/*!
 * As a subclass of @c DRHDaqDevice, it is compulsory for subclasses to override this method so that all @c DRHDaqDevice classes are compatible with @c DRHSamplingOperation.
 
 * Stops a running data streaming session on the receiver's LabJack.
 * @return @c YES if successful, else @c NO.
 */
-(BOOL)stopStream;

/*!
 * As a subclass of @c DRHDaqDevice, it is compulsory for subclasses to override this method so that all @c DRHDaqDevice classes are compatible with @c DRHSamplingOperation.
 
 * Reads the buffered data from the receivers LabJack and returns it stored in an array.
 * @return An array of the data collected from the LabJack buffer.
 */
-(NSArray *)readStreamData;

/*!
 * As a subclass of @c DRHDaqDevice, it is compulsory for subclasses to override this method so that all @c DRHDaqDevice classes are compatible with @c DRHSamplingOperation.
 
 * Closes the connection to the LabJack device, typically by a call to closeUSBConnection
 */
-(void)closeConnection;

@end
