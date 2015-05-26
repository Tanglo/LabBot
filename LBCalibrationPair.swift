//
//  LBCalibrationPair.swift
//  LabBot
//
//  Created by Lee Walsh on 26/05/2015.
//  Copyright (c) 2015 Lee David Walsh. All rights reserved.
//

import Foundation

public class LBCalibrationPair: NSObject, NSCoding {
    public var raw = LBPoint(x: 0.0, y: 0.0)
    public var calibrated = LBPoint(x: 0.0, y: 0.0)
    
    public init(raw: LBPoint, calibrated: LBPoint){
        self.raw = raw
        self.calibrated = calibrated
    }
    
    required public init(coder aDecoder: NSCoder) {
        self.raw = aDecoder.decodeObjectForKey("raw") as! LBPoint
        self.calibrated = aDecoder.decodeObjectForKey("calibrated") as! LBPoint
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(raw, forKey: "raw")
        aCoder.encodeObject(calibrated, forKey: "calibrated")
    }
    
}