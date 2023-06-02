//
//  PeerConfiguration + Mock.swift
//  wireguard-macos-client-demo
//
//  Created by Irek Khabibullin on 02.06.2023.
//

import Foundation
import WireGuardKit

extension PeerConfiguration {
    
    static func createMock() -> Result<PeerConfiguration, Error> {
        guard let publicKeyString = MockConfig.Peer.publicKey else {
            return .failure(NSError(
                domain: "WGMissingPeerPublicKey", code: 0, userInfo: [
                    NSLocalizedDescriptionKey : "Cannot specify peer public key."
                ]
            ))
        }
        guard let publicKey = PublicKey(base64Key: publicKeyString) else {
            return .failure(NSError(
                domain: "WGInvalidPeerPublicKey", code: 0, userInfo: [
                    NSLocalizedDescriptionKey : "Peer config has invalid public key."
                ]
            ))
        }
        let presharedKey = MockConfig.Peer.presharedKey == nil ?
            nil : PreSharedKey(base64Key: MockConfig.Peer.presharedKey!)
        
        guard let allowedIPStrings = MockConfig.Peer.allowedIPs else {
            return .failure(NSError(
                domain: "WGMissingPeerAllowedIPs", code: 0, userInfo: [
                    NSLocalizedDescriptionKey : "Cannot specify peer allowed IPs."
                ]
            ))
        }
        
        let allowedIPs = allowedIPStrings.compactMap({ IPAddressRange(from: $0) })
        
        guard !allowedIPs.isEmpty else {
            return .failure(NSError(
                domain: "WGInvalidPeerIPs", code: 0, userInfo: [
                    NSLocalizedDescriptionKey : "No valid allowed peer IPs."
                ]
            ))
        }
        guard let endpointString = MockConfig.Peer.endpoint else {
            return .failure(NSError(
                domain: "WGMissingPeerEndpoint", code: 0, userInfo: [
                    NSLocalizedDescriptionKey : "Cannot specify peer endpoint."
                ]
            ))
        }
        var peer = PeerConfiguration(publicKey: publicKey)
        peer.preSharedKey = presharedKey
        peer.allowedIPs.append(contentsOf: allowedIPs)
        peer.persistentKeepAlive = 0
        peer.endpoint = Endpoint(from: endpointString)
        return .success(peer)
    }
    
}
