//
//  TunnelInterface.swift
//  wireguard-macos-client-demo
//
//  Created by Irek Khabibullin on 03.06.2023.
//

import Foundation

struct TunnelInterface: Codable {
    
    var privateKey: String
    var address: String
    var dns: String
    
}
