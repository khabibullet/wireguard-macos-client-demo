//
//  TunnelConfig.swift
//  wireguard-macos-client-demo
//
//  Created by Irek Khabibullin on 03.06.2023.
//

import Foundation

struct TunnelConfig: Codable {
    
    var name: String
    var interface: TunnelInterface
    var peers: [TunnelPeer]
    
}
