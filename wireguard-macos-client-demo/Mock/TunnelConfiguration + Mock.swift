//
//  TunnelConfiguration + Mock.swift
//  wireguard-macos-client-demo
//
//  Created by Irek Khabibullin on 02.06.2023.
//

import Foundation
import WireGuardKit

extension TunnelConfiguration {
    
    static func createMock() ->  Result<TunnelConfiguration, Error> {
        
        var interface: InterfaceConfiguration!
        switch InterfaceConfiguration.createMock() {
        case .success(let new):
            interface = new
        case .failure(let error):
            return .failure(error)
        }
        
        var peer: PeerConfiguration!
        switch PeerConfiguration.createMock() {
        case .success(let new):
            peer = new
        case .failure(let error):
            return .failure(error)
        }
        guard
            let name = MockConfig.propertiesDict?.object(forKey: "Tunnel name") as? String
        else {
            return .failure(NSError(
                domain: "WGInvalidTunnelName", code: 0, userInfo: [
                    NSLocalizedDescriptionKey : "Cannot specify tunnel name."
                ]
            ))
        }
        return .success(TunnelConfiguration(
            name: name, interface: interface, peers: [peer]
        ))
    }
    
}
