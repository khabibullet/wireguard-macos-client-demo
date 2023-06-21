//
//  ViewController.swift
//  wireguard-macos-client-demo
//
//  Created by Irek Khabibullin on 18.05.2023.
//

import AppKit
import com_khabibullet_wg_cli_helper

class MainViewController: NSViewController, NSWindowDelegate {
    
    var isVpnEnabled: Bool = false

    private lazy var mainView = NSView(frame: NSMakeRect(0.0, 0.0, 300, 300))
    
    private lazy var statusLabel: NSTextField = {
        let label = NSTextField()
        label.isEditable = false
        label.stringValue = "Status"
        label.font = .systemFont(ofSize: 24)
        label.drawsBackground = true
        label.backgroundColor = .clear
        label.textColor = .black
        label.alignment = .center
        label.isBordered = false
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        labelContainer.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: labelContainer.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: labelContainer.centerYAnchor)
        ])
        return label
    }()
    
    private lazy var labelContainer: NSView = {
        let view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.systemGreen.cgColor
        view.layer?.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 50),
            view.widthAnchor.constraint(equalToConstant: 150)
        ])
        return view
    }()
    
    private lazy var buttonTitle = NSMutableAttributedString(
        string: "Enable",
        attributes: [
            .font : NSFont.systemFont(ofSize: 24),
            .foregroundColor : NSColor.white,
            .backgroundColor : NSColor.clear
        ]
    )
    
    private lazy var connectButton: NSButton = {
        let button = NSButton()
        button.wantsLayer = true
        button.layer?.backgroundColor = NSColor.systemGray.cgColor
        button.layer?.cornerRadius = 20
        button.isBordered = false
        button.alignment = .center
        button.attributedTitle = buttonTitle
        button.bezelStyle = .rounded
        button.sendAction(on: .leftMouseDown)
        button.action = #selector(setupConnection)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 150)
        ])
        return button
    }()
    
    private lazy var spinner: NSProgressIndicator = {
        let spinner = NSProgressIndicator()
        spinner.style = .spinning
        spinner.isHidden = true
        return spinner
    }()
    
    private lazy var stack: NSStackView = {
        let stack = NSStackView(views: [labelContainer, connectButton, spinner])
        statusLabel.isHidden = false
        stack.spacing = 20
        stack.orientation = .vertical
        stack.alignment = .centerX
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        return stack
    }()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.white.cgColor
        
        stack.isHidden = false
        
        setupConnectionStatus()
        updateUi()
    }
    
    private func prepareUiToUpdate() {
        connectButton.isEnabled = false
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 0.1
            connectButton.animator().alphaValue = 0.5
        })
        spinner.startAnimation(nil)
        spinner.isHidden = false
    }
    
    private func updateUi() {
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 0.1
            connectButton.animator().alphaValue = 1
        })
        if isVpnEnabled {
            statusLabel.stringValue = "Enabled"
            labelContainer.layer?.backgroundColor = NSColor.green.cgColor
            buttonTitle.mutableString.setString("Disable")
            connectButton.attributedStringValue = buttonTitle
            connectButton.attributedTitle = buttonTitle
        } else {
            statusLabel.stringValue = "Disabled"
            labelContainer.layer?.backgroundColor = NSColor.red.cgColor
            buttonTitle.mutableString.setString("Enable")
            connectButton.attributedStringValue = buttonTitle
            connectButton.attributedTitle = buttonTitle
        }
        connectButton.isEnabled = true
        spinner.isHidden = true
        spinner.stopAnimation(nil)
    }
    
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        return true
    }

    @objc
    private func setupConnection() {
        if isVpnEnabled {
            disableVpn()
        } else {
            enableVpn()
        }
    }
    
    private func enableVpn() {
        prepareUiToUpdate()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: { [unowned self] in
            isVpnEnabled = true
            updateUi()
        })
        
    }
    
    private func disableVpn() {
        prepareUiToUpdate()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: { [unowned self] in
            isVpnEnabled = false
            updateUi()
        })
    }
    
    func setupConnectionStatus() {
        do {
            NSLog("setting up connection")
            let remote = try WGHelperRemote().getRemote()
            print("remote: \(remote)")
            remote.wireguardShow(completion: { output, error in
                print("wireguard show completion")
                guard let output = output else {
                    print(error!.localizedDescription)
                    return
                }
                print("here is wireguard show output: \(output)")
            })
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
