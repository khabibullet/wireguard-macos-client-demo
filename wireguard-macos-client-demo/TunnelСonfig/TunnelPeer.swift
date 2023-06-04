//
//  TunnelPeer.swift
//  wireguard-macos-client-demo
//
//  Created by Irek Khabibullin on 03.06.2023.
//

import Foundation

struct TunnelPeer: Codable {
    
    var publicKey: String
    var presharedKey: String
    var allowedIPs: [String]
    var persistentKeepalive: Int
    var endpoint: String
    
}
