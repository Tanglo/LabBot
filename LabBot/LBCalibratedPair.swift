//
//  LBCalibrationPair.swift
//  LabBot
//
//  Created by Lee Walsh on 9/04/2015.
//  Copyright (c) 2015 Lee David Walsh. All rights reserved.
//  This sofware is licensed under the The MIT License (MIT)
//  See: https://github.com/Tanglo/LabBot/blob/master/LICENSE.md
//

import Foundation

/// A class that stores a pair of objects where one represents the calibrated version of the other.
open class LBCalibratedPair: NSObject, NSCoding {
    /// The uncalibrated object.
    open var raw: AnyObject = 0.0 as AnyObject
    /// An object that represents the calibrated version of raw.
    open var calibrated: AnyObject = 0.0 as AnyObject
    
    public init(raw: AnyObject, calibrated: AnyObject){
        self.raw = raw
        self.calibrated = calibrated
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.raw = aDecoder.decodeObject(forKey: "raw")! as AnyObject
        self.calibrated = aDecoder.decodeObject(forKey: "calibrated")! as AnyObject
    }
    
    open func encode(with aCoder: NSCoder) {
        aCoder.encode(raw, forKey: "raw")
        aCoder.encode(calibrated, forKey: "calibrated")
    }
    
}
