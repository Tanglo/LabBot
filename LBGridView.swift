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
//    let xPadding = 75.0
//    let yPadding = 50.0
    
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
    public var lineWidth = 1.0
    public var flipVertically = false
    public var flipHorizontally = false
    public var centreVertically = true
    public var centreHorizontally = true
    public var labelCells = false
    public var shuffleLabels = false
    public var hexLabels = false
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
        var numCols = Int(gridSize.width / cellSize.width)
        var numRows = Int(gridSize.height / cellSize.height)
        
        //Draw grid and coordinate labels
        if numCols>0 && numRows>0{
            let maxWidth = Double(numCols) * cellSize.width     //+ xPadding
            let maxHeight = Double(numRows) * cellSize.height   //+ yPadding
            var gridPath = NSBezierPath()
            var gridRect = frame
            var gridOrigin = LBPoint(point: frame.origin)
//            gridOrigin.x += xPadding
//            gridOrigin.y += yPadding
            if centreHorizontally {
                gridOrigin.x += (Double(frame.size.width) - maxWidth) / 2.0
            }
            if centreVertically {
                gridOrigin.y += (Double(frame.size.height) - maxHeight) / 2.0
            }
            
            var currentWidth = gridOrigin.x
            var colLabel: NSString
            var labelRect: NSRect
            var currentColumnLabel = firstColumnLabel
            let labelFont = NSFont(name: "Helvetica", size: CGFloat(labelSize))
            let labelAttr = [
                NSFontAttributeName: labelFont!,
                NSForegroundColorAttributeName: NSColor.blackColor()
            ]
            for i in 0...numCols {
                gridPath.moveToPoint(NSPoint(x: currentWidth, y: gridOrigin.y))
                gridPath.lineToPoint(NSPoint(x: currentWidth, y: gridOrigin.y+maxHeight))
                if i < numCols && labelCells==false {
                    colLabel = firstColumnLabel.incrementBy(i, floor: "A", ceiling: "Z")
                    labelRect = NSRect(origin: NSPoint(x: currentWidth, y: 0.0), size: colLabel.sizeWithAttributes(labelAttr))
                    labelRect = NSOffsetRect(labelRect, 0.5*(CGFloat(cellSize.width) - labelRect.size.width), CGFloat(gridOrigin.y) - labelRect.size.height)
                    colLabel.drawInRect(labelRect, withAttributes: labelAttr)
                }
                currentWidth += cellSize.width
            }
            var currentHeight = gridOrigin.y
            var rowLabel: NSString
            for i in 0...numRows {
                gridPath.moveToPoint(NSPoint(x: gridOrigin.x, y: currentHeight))
                gridPath.lineToPoint(NSPoint(x: gridOrigin.x+maxWidth, y: currentHeight))
                if i < numRows  && labelCells==false {
                    rowLabel = "\(firstRowLabel+i)"
                    labelRect = NSRect(origin: NSPoint(x: 0.0, y: currentHeight), size: rowLabel.sizeWithAttributes(labelAttr))
                    labelRect = NSOffsetRect(labelRect, 0.0, 0.5*(CGFloat(cellSize.height) - labelRect.size.height))
//                    if CGFloat(0.9*gridOrigin.x) > labelRect.size.width {
//                        labelRect.origin.x += CGFloat(0.9*gridOrigin.x) - labelRect.size.width
//                    }
                    rowLabel.drawInRect(labelRect, withAttributes: labelAttr)
                }
                currentHeight += cellSize.height
            }
            NSColor.blackColor().setStroke()
            gridPath.lineWidth = CGFloat(self.lineWidth)
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
                        
                        var cellLabel = ""
                        if hexLabels {
                            cellLabel = String(cellLabels[i][j], radix: 16).uppercaseString
                        } else {
                            cellLabel = "\(cellLabels[i][j])"
                        }
                        var xLabelPos = CGFloat(cellSize.width*Double(j)) + CGFloat(gridOrigin.x) + (CGFloat(cellSize.width) - cellLabel.sizeWithAttributes(labelAttr).width)/2.0
                        var yLabelPos = CGFloat(cellSize.height*Double(i)) + CGFloat(gridOrigin.y) + (CGFloat(cellSize.height) - cellLabel.sizeWithAttributes(labelAttr).height)/2.0
                        labelRect = NSRect(origin: NSPoint(x: xLabelPos, y: yLabelPos), size: cellLabel.sizeWithAttributes(labelAttr))
                        cellLabel.drawInRect(labelRect, withAttributes: labelAttr)
                    }
                }
            }
        }
    }
    
    public func gridReferenceOfLabel(label: String) -> (Int?, Int?){
        if cellLabelRows.count > 0 && cellLabelColumns.count > 0 {
            var labelInt: UInt?
            if hexLabels {
                labelInt = UInt(label, radix:16)
            } else {
                labelInt = UInt(label, radix:10)
            }
            if labelInt != nil {
                if Int(labelInt!) < cellLabelRows.count && Int(labelInt!) < cellLabelColumns.count {
                    let row = cellLabelRows[Int(labelInt!)]
                    let column = cellLabelColumns[Int(labelInt!)]
                    return (row, column)
                }
            }
        }
        return (nil,nil)
    }
}
