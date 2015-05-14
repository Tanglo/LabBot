//
//  File.swift
//  LabBot
//
//  Created by Lee Walsh on 14/05/2015.
//  Copyright (c) 2015 Lee David Walsh. All rights reserved.
//

import Foundation

public class LBPoint: NSObject, NSCoding {
    public var x = 0.0
    public var y = 0.0
    
    override init(){
        x = 0.0
        y = 0.0
    }
    
    public init(x: Double, y: Double){
        self.x = x
        self.y = y
    }
    
    public init(point: (Double, Double)){
        self.x = point.0
        self.y = point.1
    }
    
    public init(point: (Int, Int)){
        self.x = Double(point.0)
        self.y = Double(point.1)
    }
    
    required public init(coder aDecoder: NSCoder) {
        self.x = aDecoder.decodeDoubleForKey("x")
        self.y = aDecoder.decodeDoubleForKey("y")
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeDouble(self.x, forKey: "x")
        aCoder.encodeDouble(self.y, forKey: "y")
    }
    
}