//
//  LBSize.swift
//  LabBot
//
//  Created by Lee Walsh on 9/04/2015.
//  Copyright (c) 2015 Lee David Walsh. All rights reserved.
//  This sofware is licensed under the The MIT License (MIT)
//  See: https://github.com/Tanglo/LabBot/blob/master/LICENSE.md
//

import Foundation

/// A class that stores a 2D size.
public class LBSize {
    /// The width.
    public var width = 0.0
    /// The height.
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