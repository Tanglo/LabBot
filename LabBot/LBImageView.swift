//
//  LBImageView.swift
//  LabBot
//
//  Created by Lee Walsh on 9/04/2015.
//  Copyright (c) 2015 Lee David Walsh. All rights reserved.
//  This sofware is licensed under the The MIT License (MIT)
//  See: https://github.com/Tanglo/LabBot/blob/master/LICENSE.md
//

import Cocoa

/// An NSView subclass that displays and image and places a marker on the clicked location.
open class LBImageView: NSView {
    /// The image to be displayed by the receiver.
    open var image: NSImage?
    
    /// Determines if the marker feature is enabled.
    open var allowMarker = false
    
    fileprivate(set) open var markerLocation = LBPoint(x: -1.0, y: -1.0)
    
    /// The size of the marker when drawn on the image.
    open var markerSize = 20.0

    open override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
        if image != nil {
            self.frame = NSRect(origin: NSPoint(x: 0.0, y: 0.0), size: image!.size)
            image!.draw(in: self.frame)
        } else {
            self.frame = NSRect(x: 0.0, y: 0.0, width: 1000.0, height: 1000.0)
            DRHBlankImage.blankImage(of: frame.size).draw(in: frame)
        }
        
        if markerLocation.x >= 0 && markerLocation.y >= 0 {
            let markerPath = NSBezierPath()
            markerPath.move(to: NSPoint(x: markerLocation.x-markerSize, y: markerLocation.y-markerSize))
            markerPath.line(to: NSPoint(x: markerLocation.x+markerSize, y: markerLocation.y+markerSize))
            markerPath.move(to: NSPoint(x: markerLocation.x-markerSize, y: markerLocation.y+markerSize))
            markerPath.line(to: NSPoint(x: markerLocation.x+markerSize, y: markerLocation.y-markerSize))
            NSColor.red.setStroke()
            markerPath.stroke()
        }
    }
    
    open override func mouseDown(with theEvent: NSEvent) {
        markerLocation = LBPoint(point: self.convert(theEvent.locationInWindow, from: nil))
        self.needsDisplay = true
    }
    
    
    /// Delete the marker from the view.
    open func clearMarker(){
        markerLocation = LBPoint(x: -1.0, y: -1.0)
    }
    
}
