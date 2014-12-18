//
//  DRHDaqDevice.h
//  LabBot
//
//  Created by Lee Walsh on 18/12/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @brief A top level class for interacting with data aqusition hardware.
 
 This is a top level class that implements properties and methods common to using data aquisition devices.  Generally this class will be subclassed to add properties and methods spepcific to you device or class of device.  For example, @c DRHLabJack is a subclass of @c DRHDaqDevice and adds properties and methods specific to LabJack devices.  @c DRHLabJackU6 is a subclass of @c DRHLabJack and adds the properties and methods specific to the LabJack U6 device.
 */
@interface DRHDaqDevice : NSObject

@end
