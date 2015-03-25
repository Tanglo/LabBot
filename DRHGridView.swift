//
//  DRHGridView.swift
//  LabBot
//
//  Created by Lee Walsh on 13/03/2015.
//  Copyright (c) 2015 Dead Rubber Hand. All rights reserved.
//

import Cocoa
import AppKit

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

/*!
@brief A class that defines a size as a width and height.

* This class defines a size as a width and a height.  It is analogous to the @c NSSize structure of the Cocoa framework, but it works natively with @c Double types.
*/
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

/*!
@brief A view class for displaying grids with coordinate systems.

* This class is a subclass of NSView and is used to display grids that have coordinate systems.  The coordinate system is similar to a chess board where rows are labelled with a number and columns are labelled with a letter.  The grid size and cell size are set by the appropriate class properties, as is the starting values of the coordinate system.
*/
public class DRHGridView: NSView {
    let xPadding = 75.0
    let yPadding = 50.0
    
    public var gridSize = Size()
    public var cellSize = Size(width: 100.0, height: 100.0)
    public var firstRowLabel = 0
    public var firstColumnLabel = "A"
    public var viewSize: Size {
        get {
            return Size(width: Double(frame.size.width), height: Double(frame.size.height))
        }
    }
    public var labelSize = 45.0
    public var flipVertically = false;
    public var flipHorizontally = false;

    override public func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Draw background
        let bgPath = NSBezierPath(rect: frame)
        NSColor.whiteColor().setFill()
        bgPath.fill()
        
        if flipVertically {
            var flipTransform = NSAffineTransform()
            flipTransform.scaleXBy(1.0, yBy: -1.0)
            flipTransform.translateXBy(0.0, yBy: -frame.size.height)
            flipTransform.concat()
        }
        if flipHorizontally {
            var flipTransform = NSAffineTransform()
            flipTransform.scaleXBy(-1.0, yBy: 1.0)
            flipTransform.translateXBy(-frame.size.width, yBy: 0.0)
            flipTransform.concat()
        }
        
        //Calculate the number of whole cells that will fit in the padded space
        var numCols = Int((gridSize.width - 2*xPadding) / cellSize.width)
        var numRows = Int((gridSize.height - 2*yPadding) / cellSize.height)
        
        //Draw grid and coordinate labels
        if numCols>0 && numRows>0{
            let maxWidth = Double(numCols) * cellSize.width + xPadding
            let maxHeight = Double(numRows) * cellSize.height + yPadding
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
                    labelRect = NSOffsetRect(labelRect, 0.5*(CGFloat(cellSize.width) - labelRect.size.width), CGFloat(yPadding) - labelRect.size.height)
                    colLabel.drawInRect(labelRect, withAttributes: labelAttr)
                }
                currentWidth += cellSize.width
            }
            var currentHeight = yPadding
            var rowLabel: NSString
            for i in 0...numRows {
                gridPath.moveToPoint(NSPoint(x: xPadding, y: currentHeight))
                gridPath.lineToPoint(NSPoint(x: maxWidth, y: currentHeight))
                if i < numRows {
                    rowLabel = "\(firstRowLabel+i)"
                    labelRect = NSRect(origin: NSPoint(x: 0.0, y: currentHeight), size: rowLabel.sizeWithAttributes(labelAttr))
                    labelRect = NSOffsetRect(labelRect, 0.0, 0.5*(CGFloat(cellSize.height) - labelRect.size.height))
                    if CGFloat(0.9*xPadding) > labelRect.size.width {
                        labelRect.origin.x += CGFloat(0.9*xPadding) - labelRect.size.width
                    }
                    rowLabel.drawInRect(labelRect, withAttributes: labelAttr)
                }
                currentHeight += cellSize.height
            }
            NSColor.blackColor().setStroke()
            gridPath.stroke()
        }
    }
}
