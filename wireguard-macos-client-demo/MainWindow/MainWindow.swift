//
//  MainWindow.swift
//  wireguard-macos-client-demo
//
//  Created by Irek Khabibullin on 22.05.2023.
//

import AppKit

class MainWindow: NSWindow {

    init() {
        super.init(
            contentRect: .zero,
            styleMask: [.titled, .closable, .miniaturizable],
            backing: .buffered,
            defer: false
        )
        title = "WireGuard client demo"
        backgroundColor = .white
        center()
        isReleasedWhenClosed = true
    }
    
}
