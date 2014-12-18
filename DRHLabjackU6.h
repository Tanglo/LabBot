//
//  DRHLabjackU6.h
//  LabBot
//
//  Created by Lee Walsh on 18/12/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import "DRHLabJack.h"

/*!
 @brief A class for controlling a LabJack U6 or U6-Pro data aquisition device.
    
    This class provides properties and methods to facilitate interacting with a LabJack U6 or U6-Pro device.  This class is specific to the U6 and U6-Pro.  If you have a different LabJack device you should be using a different subclass of @c DRHLabJack.  If your data aqusition hardware is not a LabJack device you should be using a different subclass of @c DRHDaqDevice.
 */
@interface DRHLabjackU6 : DRHLabJack

@end
