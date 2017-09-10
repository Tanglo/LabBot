//
//  LBExperimentDelegate.swift
//  LabBot
//
//  Created by Lee Walsh on 9/04/2015.
//  Copyright (c) 2015 Lee David Walsh. All rights reserved.
//  This sofware is licensed under the The MIT License (MIT)
//  See: https://github.com/Tanglo/LabBot/blob/master/LICENSE.md
//

import Cocoa

/**
    A class to use as adelgate for experiment applciations.

    Currently its main role is to override applicationShouldTerminate so that the applcation is not closed before all documents (which might contain unsaved experimental data) are closed.

*/
@objc open class LBExperimentDelegate: NSObject, NSApplicationDelegate {
    
    open func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }
    
    open func applicationShouldTerminate(_ sender: NSApplication) -> NSApplicationTerminateReply {
        if NSDocumentController.shared().documents.count > 0 {
            let alert = NSAlert()
            alert.messageText = "Close documents before quitting."
            alert.addButton(withTitle: "Ok")
            alert.runModal()
            return NSApplicationTerminateReply.terminateCancel
        }
        return NSApplicationTerminateReply.terminateNow
    }
    
    open func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
}
