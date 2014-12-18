//
//  DRHLabJack.h
//  LabBot
//
//  Created by Lee Walsh on 18/12/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import "DRHDaqDevice.h"
#import "/usr/local/include/labjackusb.h"

extern NSString * const DRHLabJackU3DeviceKey;
extern NSString * const DRHLabJackU6DeviceKey;
extern NSString * const DRHLabJackUE9DeviceKey;

/*!
 @brief The parent class used to interact with LabJack data aqusition hardware.
 
 This parent class implmements properties and methods that are common to LabJack hardware.  It is then subclassed for each specific devices.  Most of the time you should not be using an instance of this class but a subclass of it specific to your LabJack hardware.
 */
@interface DRHLabJack : DRHDaqDevice

/*!
 * Checks how many LabJack devices are connected and returns the number of devices and their type.  The number of devices are stored as @c NSNumber objects keyed to the @c DRHLabJackProductIDX where @c X is the device type.  Valid value for @c X are @c U3, @c U6 and @c UE9.
 * @return An @c NSDictionary object containing the number of each type of recognised LabJack device (U3, U6 and UE9).
 */
+(NSDictionary *)numberOfConnectedLabJackDevices;

@end
