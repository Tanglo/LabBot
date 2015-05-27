//
//  LBCalibrationPair.swift
//  LabBot
//
//  Created by Lee Walsh on 26/05/2015.
//  Copyright (c) 2015 Lee David Walsh. All rights reserved.
//

import Foundation

public class LBCalibratedPair: NSObject, NSCoding {
    public var raw: AnyObject = 0.0
    public var calibrated: AnyObject = 0.0
    
    public init(raw: AnyObject, calibrated: AnyObject){
        self.raw = raw
        self.calibrated = calibrated
    }
    
    required public init(coder aDecoder: NSCoder) {
        self.raw = aDecoder.decodeObjectForKey("raw")!
        self.calibrated = aDecoder.decodeObjectForKey("calibrated")!
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(raw, forKey: "raw")
        aCoder.encodeObject(calibrated, forKey: "calibrated")
    }
    
}