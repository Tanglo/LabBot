//
//  LBSize.swift
//  LabBot
//
//  Created by Lee Walsh on 14/05/2015.
//  Copyright (c) 2015 Lee David Walsh. All rights reserved.
//

import Foundation

/*!
@brief A class that defines a size as a width and height.

* This class defines a size as a width and a height.  It is analogous to the @c NSSize structure of the Cocoa framework, but it works natively with @c Double types.
*/
public class LBSize {
    public var width = 0.0
    public var height = 0.0
    
    init(){
        width = 0.0
        height = 0.0
    }
    
    public init(width: Double, height: Double){
        self.width = width
        self.height = height
    }
}