//
//  InterfaceConfiguration + Mock.swift
//  wireguard-macos-client-demo
//
//  Created by Irek Khabibullin on 02.06.2023.
//

import Foundation
import WireGuardKit

extension InterfaceConfiguration {
    
    static func createMock() -> Result<InterfaceConfiguration, Error> {
        guard let privateKeyString = MockConfig.Interface.privateKey else {
            return .failure(NSError(
                domain: "WGMissingInterfacePrivateKey", code: 0, userInfo: [
                    NSLocalizedDescriptionKey : "Cannot specify interface private key."
                ]
            ))
        }
        guard let privateKey = PrivateKey(base64Key: privateKeyString) else {
            return .failure(NSError(
                domain: "WGInvalidInterfacePrivateKey", code: 0, userInfo: [
                    NSLocalizedDescriptionKey : "Interface config has invalid private key."
                ]
            ))
        }
        guard let interfaceAddressString = MockConfig.Interface.address else {
            return .failure(NSError(
                domain: "WGMissingInterfaceAddress", code: 0, userInfo: [
                    NSLocalizedDescriptionKey : "Cannot specify interface address."
                ]
            ))
        }
        guard let adress = IPAddressRange(from: interfaceAddressString) else {
            return .failure(NSError(
                domain: "WGInvalidInterfaceAddress", code: 0, userInfo: [
                    NSLocalizedDescriptionKey : "Interface config has invalid address."
                ]
            ))
        }
        guard let interfaceDnsString = MockConfig.Interface.dns else {
            return .failure(NSError(
                domain: "WGMissingInterfaceDns", code: 0, userInfo: [
                    NSLocalizedDescriptionKey : "Cannot specify interface DNS."
                ]
            ))
        }
        guard let dns = DNSServer(from: interfaceDnsString) else {
            return .failure(NSError(
                domain: "WGInvalidInterfaceDns", code: 0, userInfo: [
                    NSLocalizedDescriptionKey : "Interface config has invalid DNS."
                ]
            ))
        }
        
        var interface = InterfaceConfiguration(privateKey: privateKey)
        interface.addresses.append(adress)
        interface.dns.append(dns)
        return .success(interface)
    }
    
}
