//
//  File.swift
//  LabBot
//
//  Created by Lee Walsh on 9/04/2015.
//  Copyright (c) 2015 Lee David Walsh. All rights reserved.
//  This sofware is licensed under the The MIT License (MIT)
//  See: https://github.com/Tanglo/LabBot/blob/master/LICENSE.md
//

import Foundation

/// A class that stores a 2D catesian point.
public class LBPoint: NSObject, NSCoding {
    /// The hozizontal coordinate.
    public var x = 0.0
    /// The vertical coordinate.
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
    
    public init(point: NSPoint){
        self.x = Double(point.x)
        self.y = Double(point.y)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.x = aDecoder.decodeDoubleForKey("x")
        self.y = aDecoder.decodeDoubleForKey("y")
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeDouble(self.x, forKey: "x")
        aCoder.encodeDouble(self.y, forKey: "y")
    }
    
}