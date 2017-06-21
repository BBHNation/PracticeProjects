//
//  AppDelegate.swift
//  Tomato
//
//  Created by 白彬涵 on 2017/6/20.
//  Copyright © 2017年 MR White. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


    var statusItem : NSStatusItem?
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.statusItem = NSStatusBar.system().statusItem(withLength: 30)
        let image = NSImage.init(named: "番茄")
        self.statusItem?.button?.image = image
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

