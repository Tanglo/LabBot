//
//  DRHGridView.swift
//  LabBot
//
//  Created by Lee Walsh on 13/03/2015.
//  Copyright (c) 2015 Dead Rubber Hand. All rights reserved.
//

import Cocoa

public class Size {
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

public class DRHGridView: NSView {
    let padding = 20.0
    
    public var gridSize = Size()
    public var cellWidth = 20.0
    public var cellHeight = 20.0
    public var firstRowRef = 0
    public var firstColRef: Character = "A"
    public var viewSize: Size {
        get {
            return Size(width: Double(frame.size.width), height: Double(frame.size.height))
        }
    }

    override public func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Draw background
        let bgPath = NSBezierPath(rect: frame)
        NSColor.whiteColor().setFill()
        bgPath.fill()
        
        //Calculate the number of whole cells that will fit in the padded space
        var currentWidth = padding
        var numCols = 0
        while (currentWidth + cellWidth) < (gridSize.width - padding){
            currentWidth += cellWidth
            numCols++
        }
        var currentHeight = padding
        var numRows = 0
        while (currentHeight + cellHeight) < (gridSize.height - padding){
            currentHeight += cellHeight
            numRows++
        }
        
        //Draw grid
        var gridPath = NSBezierPath()
        currentWidth = padding
        for i in 0...numCols+1 {
            gridPath.moveToPoint(NSPoint(x: currentWidth, y: padding))
            gridPath.lineToPoint(NSPoint(x: currentWidth, y: gridSize.height - padding))
            currentWidth += cellWidth
        }
        currentHeight = padding
        for i in 0...numRows+1 {
            gridPath.moveToPoint(NSPoint(x: padding, y: currentHeight))
            gridPath.lineToPoint(NSPoint(x: gridSize.width - padding, y: currentHeight))
            currentHeight += cellWidth
        }
        NSColor.blackColor().setStroke()
        gridPath.stroke()
    }
    
}
