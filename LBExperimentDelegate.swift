//
//  LBExperimentDelegate.swift
//  LabBot
//
//  Created by Lee Walsh on 11/05/2015.
//  Copyright (c) 2015 Lee David Walsh. All rights reserved.
//

import Cocoa

@objc public class LBExperimentDelegate: NSObject, NSApplicationDelegate {
    
    public func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
    }
    
    public func applicationShouldTerminate(sender: NSApplication) -> NSApplicationTerminateReply {
        if NSDocumentController.sharedDocumentController().documents.count > 0 {
            let alert = NSAlert()
            alert.messageText = "Close documents before quitting."
            alert.addButtonWithTitle("Ok")
            alert.runModal()
            return NSApplicationTerminateReply.TerminateCancel
        }
        return NSApplicationTerminateReply.TerminateNow
    }
    
    public func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
}