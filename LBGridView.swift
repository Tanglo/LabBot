//
//  DRHGridView.swift
//  LabBot
//
//  Created by Lee Walsh on 13/03/2015.
//  Copyright (c) 2014 Lee David Walsh. All rights reserved.
//  This sofware is licensed under the The MIT License (MIT)
//  See: https://github.com/Tanglo/LabBot/blob/master/LICENSE.md
//

import Cocoa
import AppKit

/*!
@brief A view class for displaying grids with coordinate systems.

* This class is a subclass of NSView and is used to display grids that have coordinate systems.  The coordinate system is similar to a chess board where rows are labelled with a number and columns are labelled with a letter.  The grid size and cell size are set by the appropriate class properties, as is the starting values of the coordinate system.
*/
public class LBGridView: NSView {
    let xPadding = 75.0
    let yPadding = 50.0
    
    public var gridSize = LBSize()
    public var cellSize = LBSize(width: 100.0, height: 100.0)
    public var firstRowLabel = 0
    public var firstColumnLabel = "A"
    public var viewSize: LBSize {
        get {
            return LBSize(width: Double(frame.size.width), height: Double(frame.size.height))
        }
    }
    public var labelSize = 45.0
    public var flipVertically = false
    public var flipHorizontally = false
    public var labelCells = false
    public var shuffleLabels = false
    var cellLabels = Array<Array<Int>>()
    var cellLabelRows = Array<Int>()
    var cellLabelColumns = Array<Int>()

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
                if i < numCols && labelCells==false {
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
                if i < numRows  && labelCells==false {
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
            
            if labelCells {
                cellLabels = [[Int]](count: numRows, repeatedValue: [Int](count: numCols, repeatedValue: Int()))
                cellLabelRows = [Int](count: numRows*numCols+1, repeatedValue: Int())
                cellLabelColumns = [Int](count: numRows*numCols+1, repeatedValue: Int())
                var newLabels = [Int]()
                var count = 1
                for i in 0..<numRows {
                    for j in 0..<numCols {
                        newLabels.append(count++)
                    }
                }
                if shuffleLabels {
                    newLabels = newLabels.shuffle()
                }
                for i in 0..<numRows {
                    for j in 0..<numCols {
                        cellLabels[i][j] = newLabels[i*numCols+j]
                        cellLabelRows[cellLabels[i][j]] = i
                        cellLabelColumns[cellLabels[i][j]] = j
                       
                        let cellLabel: NSString = "\(cellLabels[i][j])"
                        var xLabelPos = CGFloat(cellSize.width*Double(j)) + CGFloat(xPadding) + (CGFloat(cellSize.width) - cellLabel.sizeWithAttributes(labelAttr).width)/2.0
                        var yLabelPos = CGFloat(cellSize.height*Double(i)) + CGFloat(yPadding) + (CGFloat(cellSize.height) - cellLabel.sizeWithAttributes(labelAttr).height)/2.0
                        labelRect = NSRect(origin: NSPoint(x: xLabelPos, y: yLabelPos), size: cellLabel.sizeWithAttributes(labelAttr))
                        cellLabel.drawInRect(labelRect, withAttributes: labelAttr)
                    }
                }
            }
        }
    }
    
    public func gridReferenceOfLabel(label: Int) -> (Int?, Int?){
        if cellLabelRows.count > 0 && cellLabelColumns.count > 0 {
            if label < cellLabelRows.count && label < cellLabelColumns.count {
                let row = cellLabelRows[label]
                let column = cellLabelColumns[label]
                return (row, column)
            }
        }
        return (nil,nil)
    }
}
