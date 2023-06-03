//
//  Config.swift
//  wireguard-macos-client-demo
//
//  Created by Irek Khabibullin on 02.06.2023.
//

import Foundation

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
