//
//  MainMenu.swift
//  wireguard-macos-client-demo
//
//  Created by Irek Khabibullin on 22.05.2023.
//

import AppKit

class MainMenu: NSMenu {
    
    init() {
        super.init(title: "")
        autoenablesItems = false
        
        let mainBarItem = NSMenuItem()
        addItem(mainBarItem)
        
        let appMenu = NSMenu()
        appMenu.autoenablesItems = false
        mainBarItem.submenu = appMenu
        
        let quitItem = NSMenuItem(
            title: "Quit",
            action: #selector(terminate),
            keyEquivalent: "q"
        )
        quitItem.target = self
        quitItem.isEnabled = true
        
        appMenu.addItem(quitItem)
    }
    
    @objc
    private func terminate() {
        NSApp.terminate(nil)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
