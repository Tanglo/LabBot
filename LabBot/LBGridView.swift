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

/**
    A view class for displaying grids with coordinate systems.

    This class is a subclass of NSView and is used to display grids that have coordinate systems.  The coordinate system is similar to a chess board where rows are labelled with a number and columns are labelled with a letter.  The grid size and cell size are set by the appropriate class properties, as is the starting values of the coordinate system.
*/
open class LBGridView: LBSubjectView {
    open var gridRect = NSRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0)
    open var cellSize = LBSize(width: 100.0, height: 100.0)
    open var firstRowLabel = 0
    open var firstColumnLabel = "A"
    open var viewSize: LBSize {
        get {
            return LBSize(width: Double(frame.size.width), height: Double(frame.size.height))
        }
    }
    open var labelSize = 45.0
    open var lineWidth = 1.0
    open var flipVertically = false
    open var flipHorizontally = false
    open var centreVertically = true
    open var centreHorizontally = true
    open var labelCells = false
    open var shuffleLabels = false
    open var hexLabels = false
    var cellLabels = Array<Array<Int>>()
    var cellLabelRows = Array<Int>()
    var cellLabelColumns = Array<Int>()

    override open func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        if blank {
            let bgPath = NSBezierPath(rect: frame)
            NSColor.black.setFill()
            bgPath.fill()
        } else {
            // Draw background
            let bgPath = NSBezierPath(rect: frame)
            NSColor.white.setFill()
            bgPath.fill()
            
            if flipVertically {
                var flipTransform = AffineTransform.identity
                flipTransform.scale(x: 1.0, y: -1.0)
                flipTransform.translate(x: 0.0, y: -frame.size.height)
                (flipTransform as NSAffineTransform).concat()
            }
            if flipHorizontally {
                var flipTransform = AffineTransform.identity
                flipTransform.scale(x: -1.0, y: 1.0)
                flipTransform.translate(x: -frame.size.width, y: 0.0)
                (flipTransform as NSAffineTransform).concat()
            }
            
            //Calculate the number of whole cells that will fit in the padded space
            let numCols = Int(Double(gridRect.size.width) / cellSize.width)
            let numRows = Int(Double(gridRect.size.height) / cellSize.height)
            
            //Draw grid and coordinate labels
            if numCols>0 && numRows>0{
                let maxWidth = Double(numCols) * cellSize.width     //+ xPadding
                let maxHeight = Double(numRows) * cellSize.height   //+ yPadding
                let gridPath = NSBezierPath()
                if centreHorizontally {
                    gridRect.origin.x = (frame.size.width - CGFloat(maxWidth)) / 2.0
                }
                if centreVertically {
                    gridRect.origin.y = (frame.size.height - CGFloat(maxHeight)) / 2.0
                }
                
                var currentWidth = Double(gridRect.origin.x)
                var colLabel: NSString
                var labelRect: NSRect
//                var currentColumnLabel = firstColumnLabel
                let labelFont = NSFont(name: "Helvetica", size: CGFloat(labelSize))
                let labelAttr = [
                    NSFontAttributeName: labelFont!,
                    NSForegroundColorAttributeName: NSColor.black
                ]
                for i in 0...numCols {
                    gridPath.move(to: NSPoint(x: currentWidth, y: Double(gridRect.origin.y)))
                    gridPath.line(to: NSPoint(x: currentWidth, y: Double(gridRect.origin.y)+maxHeight))
                    if i < numCols && labelCells==false {
                        colLabel = firstColumnLabel.incrementBy(i, floor: "A", ceiling: "Z") as NSString
                        labelRect = NSRect(origin: NSPoint(x: currentWidth, y: 0.0), size: colLabel.size(withAttributes: labelAttr))
                        labelRect = NSOffsetRect(labelRect, 0.5*(CGFloat(cellSize.width) - labelRect.size.width), gridRect.origin.y - labelRect.size.height)
                        colLabel.draw(in: labelRect, withAttributes: labelAttr)
                    }
                    currentWidth += cellSize.width
                }
                var currentHeight = Double(gridRect.origin.y)
                var rowLabel: NSString
                for i in 0...numRows {
                    gridPath.move(to: NSPoint(x: Double(gridRect.origin.x), y: currentHeight))
                    gridPath.line(to: NSPoint(x: Double(gridRect.origin.x)+maxWidth, y: currentHeight))
                    if i < numRows  && labelCells==false {
                        rowLabel = "\(firstRowLabel+i)" as NSString
                        labelRect = NSRect(origin: NSPoint(x: 0.0, y: currentHeight), size: rowLabel.size(withAttributes: labelAttr))
                        labelRect = NSOffsetRect(labelRect, 0.0, 0.5*(CGFloat(cellSize.height) - labelRect.size.height))
                        rowLabel.draw(in: labelRect, withAttributes: labelAttr)
                    }
                    currentHeight += cellSize.height
                }
                NSColor.black.setStroke()
                gridPath.lineWidth = CGFloat(self.lineWidth)
                gridPath.stroke()
                
                if labelCells {
                    cellLabels = [[Int]](repeating: [Int](repeating: Int(), count: numCols), count: numRows)
                    cellLabelRows = [Int](repeating: Int(), count: numRows*numCols+1)
                    cellLabelColumns = [Int](repeating: Int(), count: numRows*numCols+1)
                    var newLabels = [Int]()
                    var count = 1
                    for _ in 0..<numRows {
                        for _ in 0..<numCols {
                            newLabels.append(count)
                            count += 1
                        }
                    }
                    if shuffleLabels {
                        newLabels = newLabels.shuffle()
                    }
                    for i in 0..<numRows {
                        for j in 0..<numCols {
                            cellLabels[i][j] = newLabels[i*numCols+j]
                            cellLabelRows[cellLabels[i][j]] = j
                            cellLabelColumns[cellLabels[i][j]] = i
                            
                            var cellLabel = ""
                            if hexLabels {
                                cellLabel = String(cellLabels[i][j], radix: 16).uppercased()
                            } else {
                                cellLabel = "\(cellLabels[i][j])"
                            }
                            let xLabelPos = CGFloat(cellSize.width*Double(j)) + gridRect.origin.x + (CGFloat(cellSize.width) - cellLabel.size(withAttributes: labelAttr).width)/2.0
                            let yLabelPos = CGFloat(cellSize.height*Double(i)) + gridRect.origin.y + (CGFloat(cellSize.height) - cellLabel.size(withAttributes: labelAttr).height)/2.0
                            labelRect = NSRect(origin: NSPoint(x: xLabelPos, y: yLabelPos), size: cellLabel.size(withAttributes: labelAttr))
                            cellLabel.draw(in: labelRect, withAttributes: labelAttr)
                        }
                    }
                }
            }
        }
    }
    
    /**
        Retrieves the cartesian grid reference (row,column) of the specified label within the drawn grid.

        - parameter label: The label to retrieve the grid refference for.
        - returns: A tuple containing the cartesian coordinate (row,column) of the specified lab in the drawn grid, or a tuple containing (nil,nil) if the label is not in the current grid.
    */
    open func gridReferenceOfLabel(_ label: String) -> (Int?, Int?){
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
