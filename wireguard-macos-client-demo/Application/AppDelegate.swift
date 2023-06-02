//
//  AppDelegate.swift
//  wireguard-macos-client-demo
//
//  Created by Irek Khabibullin on 18.05.2023.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    var windowController: NSWindowController!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let window = MainWindow()
        windowController = NSWindowController(window: window)
        
        let rootVC = MainViewController(nibName: nil, bundle: nil)
        window.delegate = rootVC
        window.contentViewController = rootVC

        window.orderFrontRegardless()
        
        let menuBar = MainMenu()
        NSApp.mainMenu = menuBar
        
        NSApp.activate(ignoringOtherApps: true)
    }
    
    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        return NSApplication.TerminateReply.terminateNow
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }
    
}

