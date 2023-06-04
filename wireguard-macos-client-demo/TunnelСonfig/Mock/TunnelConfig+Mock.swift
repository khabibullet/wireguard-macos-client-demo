//
//  Config.swift
//  wireguard-macos-client-demo
//
//  Created by Irek Khabibullin on 02.06.2023.
//

import Foundation

extension TunnelConfig {
    
    private static let propertiesDict: NSDictionary? = {
        if let path = Bundle.main.path(forResource: "MockConfig", ofType: ".plist") {
            return NSDictionary(contentsOfFile: path)
        } else {
            return nil
        }
    }()
    
    static let mock: TunnelConfig? = {
        guard let dict = propertiesDict else { return nil }
        
        let interface = TunnelInterface(
            privateKey: dict.object(forKey: "Interface private key") as! String,
            address: dict.object(forKey: "Interface address") as! String,
            dns: dict.object(forKey: "Interface dns") as! String
        )
        let peer = TunnelPeer(
            publicKey: dict.object(forKey: "Interface dns") as! String,
            endpoint: dict.object(forKey: "Interface dns") as! String,
            allowedIPs: dict.object(forKey: "Interface dns") as! [String]
        )
        return TunnelConfig(name: "Irek_mac", interface: interface, peers: [peer])
    }()
    
}

struct MockConfig {
    
    static let propertiesDict: NSDictionary? = {
        guard
            let path = Bundle.main.path(forResource: "MockConfig", ofType: ".plist")
        else { return nil }
        return NSDictionary(contentsOfFile: path)
    }()
    
    static let tunnelName = propertiesDict?.object(forKey: "Tunnel name") as? String
    
    struct Interface {
        
        static let privateKey = propertiesDict?.object(forKey: "Interface private key") as? String
        static let address = propertiesDict?.object(forKey: "Interface address") as? String
        static let dns = propertiesDict?.object(forKey: "Interface dns") as? String
        
    }
    
    struct Peer {
        
        static let publicKey = propertiesDict?.object(forKey: "Peer public key") as? String
        static let allowedIPs = propertiesDict?.object(forKey: "Peer allowed IPs") as? [String]
        static let persistentKeepAlive = propertiesDict?.object(forKey: "Peer persistent keep alive") as? UInt16
        static let endpoint = propertiesDict?.object(forKey: "Peer endpoint") as? String
        static let presharedKey = propertiesDict?.object(forKey: "Peer preshared key") as? String
        
    }
    
}
