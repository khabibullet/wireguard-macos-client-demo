//
//  main.swift
//  wireguard-macos-client-demo
//
//  Created by Irek Khabibullin on 18.05.2023.
//

import AppKit

var app = NSApplication.shared
NSApp.setActivationPolicy(.regular)

let delegate = AppDelegate()
app.delegate = delegate

app.run()
