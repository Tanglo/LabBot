//
//  DRHDaqDevice.h
//  LabBot
//
//  Created by Lee Walsh on 18/12/2014.
//  Copyright (c) 2014 Lee David Walsh. All rights reserved.
//  This sofware is licensed under the The MIT License (MIT)
//  See: https://github.com/Tanglo/LabBot/blob/master/LICENSE.md
//

#import <Foundation/Foundation.h>

/*!
 @brief A top level class for interacting with data aqusition hardware.
 
 This is a top level class that implements properties and methods common to using data aquisition devices.  Generally this class will be subclassed to add properties and methods spepcific to you device or class of device.  For example, @c DRHLabJack is a subclass of @c DRHDaqDevice and adds properties and methods specific to LabJack devices.  @c DRHLabJackU6 is a subclass of @c DRHLabJack and adds the properties and methods specific to the LabJack U6 device.
 */
@interface DRHDaqDevice : NSObject

/*!
 * It is compulsory for subclasses to override this method so that all @c DRHDaqDevice classes are compatible with @c DRHSamplingOperation.
 
 * Starts a configured data streaming session on the receiver's device.
 * @return @c YES if successful, else @c NO.
 */
-(BOOL)startStream;

/*!
 * It is compulsory for subclasses to override this method so that all @c DRHDaqDevice classes are compatible with @c DRHSamplingOperation.
 
 * Stops a running data streaming session on the receiver's device.
 * @return @c YES if successful, else @c NO.
 */
-(BOOL)stopStream;

/*!
 * It is compulsory for subclasses to override this method so that all @c DRHDaqDevice classes are compatible with @c DRHSamplingOperation.
 
 * Reads the buffered data from the receivers device and returns it stored in an array.
 * @return An array of the data collected from the device buffer.
 */
-(NSArray *)readStreamData;

/*!
 * It is compulsory for subclasses to override this method so that all @c DRHDaqDevice classes are compatible with @c DRHSamplingOperation.
 
 * Closes the connection to the daqDevice.
 */
-(void)closeConnection;



@end
