//
//  LBCalibrationPair.swift
//  LabBot
//
//  Created by Lee Walsh on 26/05/2015.
//  Copyright (c) 2015 Lee David Walsh. All rights reserved.
//

import Foundation

/// A class that stores a pair of objects where one represents the calibrated version of the other.
public class LBCalibratedPair: NSObject, NSCoding {
    /// The uncalibrated object.
    public var raw: AnyObject = 0.0
    /// An object that represents the calibrated version of raw.
    public var calibrated: AnyObject = 0.0
    
    public init(raw: AnyObject, calibrated: AnyObject){
        self.raw = raw
        self.calibrated = calibrated
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.raw = aDecoder.decodeObjectForKey("raw")!
        self.calibrated = aDecoder.decodeObjectForKey("calibrated")!
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(raw, forKey: "raw")
        aCoder.encodeObject(calibrated, forKey: "calibrated")
    }
    
}