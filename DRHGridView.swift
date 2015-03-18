//
//  DRHGridView.swift
//  LabBot
//
//  Created by Lee Walsh on 13/03/2015.
//  Copyright (c) 2015 Dead Rubber Hand. All rights reserved.
//

import Cocoa

extension String {
    public func incrementBy(increment: Int, floor: Character, ceiling: Character) -> String {
        let lastChar = self.substringFromIndex(self.endIndex.predecessor())
        var remString = self.substringToIndex(self.endIndex.predecessor())
        let lastCharUnicode = lastChar.unicodeScalars[lastChar.unicodeScalars.startIndex].value
        let newUnicode = lastCharUnicode + increment
        var newLastChar = Character(UnicodeScalar(newUnicode))
        let ceilingUnicode = String(ceiling).unicodeScalars[lastChar.unicodeScalars.startIndex].value
        if newUnicode > ceilingUnicode {
            var charOverflow = newUnicode-ceilingUnicode
            let floorUnicode = String(floor).unicodeScalars[lastChar.unicodeScalars.startIndex].value
            let unicodeRange = (ceilingUnicode + 1) - floorUnicode
            var numOverflows = 1
            while charOverflow > unicodeRange {
                numOverflows++
                charOverflow -= unicodeRange
            }
            newLastChar = Character(UnicodeScalar(floorUnicode+charOverflow-1))
            remString = remString.incrementBy(numOverflows, floor: floor, ceiling: ceiling)
        }
        return remString+String(newLastChar)
    }
}

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
    let xPadding = 75.0
    let yPadding = 50.0
    
    public var gridSize = Size()
    public var cellWidth = 100.0
    public var cellHeight = 100.0
    public var firstRowLabel = 0
    public var firstColumnLabel = "A"
    public var viewSize: Size {
        get {
            return Size(width: Double(frame.size.width), height: Double(frame.size.height))
        }
    }
    public var labelSize = 45.0

    override public func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Draw background
        let bgPath = NSBezierPath(rect: frame)
        NSColor.whiteColor().setFill()
        bgPath.fill()
        
        //Calculate the number of whole cells that will fit in the padded space
        var numCols = Int((gridSize.width - 2*xPadding) / cellWidth)
        var numRows = Int((gridSize.height - 2*yPadding) / cellHeight)
        
        //Draw grid and coordinate labels
        if numCols>0 && numRows>0{
            let maxWidth = Double(numCols) * cellWidth + xPadding
            let maxHeight = Double(numRows) * cellHeight + yPadding
            var gridPath = NSBezierPath()
            var currentWidth = xPadding
            var colLabel: NSString
            var labelRect: NSRect
            var currentColumnLabel = firstColumnLabel
            let labelFont = NSFont(name: "Helvetica", size: CGFloat(labelSize))
            let labelAttr = [
                NSFontAttributeName: labelFont!,
                NSForegroundColorAttributeName: NSColor.blackColor()
            ]
            for i in 0...numCols {
                gridPath.moveToPoint(NSPoint(x: currentWidth, y: yPadding))
                gridPath.lineToPoint(NSPoint(x: currentWidth, y: maxHeight))
                if i < numCols {
                    colLabel = firstColumnLabel.incrementBy(i, floor: "A", ceiling: "Z")
                    labelRect = NSRect(origin: NSPoint(x: currentWidth, y: 0.0), size: colLabel.sizeWithAttributes(labelAttr))
                    labelRect = NSOffsetRect(labelRect, 0.5*(CGFloat(cellWidth) - labelRect.size.width), 0.0)
                    colLabel.drawInRect(labelRect, withAttributes: labelAttr)
                }
                currentWidth += cellWidth
            }
            var currentHeight = yPadding
            var rowLabel: NSString
            for i in 0...numRows {
                gridPath.moveToPoint(NSPoint(x: xPadding, y: currentHeight))
                gridPath.lineToPoint(NSPoint(x: maxWidth, y: currentHeight))
                if i < numRows {
                    rowLabel = "\(firstRowLabel+i)"
                    labelRect = NSRect(origin: NSPoint(x: 0.0, y: currentHeight), size: rowLabel.sizeWithAttributes(labelAttr))
                    labelRect = NSOffsetRect(labelRect, 0.0, 0.5*(CGFloat(cellHeight) - labelRect.size.height))
                    if CGFloat(0.9*xPadding) > labelRect.size.width {
                        labelRect.origin.x += CGFloat(0.9*xPadding) - labelRect.size.width
                    }
                    rowLabel.drawInRect(labelRect, withAttributes: labelAttr)
                }
                currentHeight += cellHeight
            }
            NSColor.blackColor().setStroke()
            gridPath.stroke()
        }
    }
    
}
