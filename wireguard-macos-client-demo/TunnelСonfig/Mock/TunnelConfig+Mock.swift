//
//  Config.swift
//  wireguard-macos-client-demo
//
//  Created by Irek Khabibullin on 02.06.2023.
//

import Foundation

extension TunnelConfig {
    
    static let mock: TunnelConfig? = {
        guard
            let path = Bundle.main.path(forResource: "MockConfig", ofType: ".plist"),
            let dict = NSDictionary(contentsOfFile: path)
        else { return nil }
        
        let interface = TunnelInterface(
            privateKey: dict.object(forKey: "Interface private key") as! String,
            address: dict.object(forKey: "Interface address") as! String,
            dns: dict.object(forKey: "Interface dns") as! String
        )
        let peer = TunnelPeer(
            publicKey: dict.object(forKey: "Peer public key") as! String,
            presharedKey: dict.object(forKey: "Peer preshared key") as! String,
            allowedIPs: dict.object(forKey: "Peer allowed IPs") as! [String],
            persistentKeepalive: dict.object(forKey: "Peer persistent keep alive") as! Int,
            endpoint: dict.object(forKey: "Peer endpoint") as! String
        )
        return TunnelConfig(name: "Irek_mac", interface: interface, peers: [peer])
    }()
    
}
