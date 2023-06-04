//
//  WGHelperProtocol.swift
//  wireguard-macos-client-demo
//
//  Created by Irek Khabibullin on 04.06.2023.
//

import Foundation

@objc(WGHelperProtocol)
public protocol WGHelperProtocol {
    
    @objc
    func wireguardShow(completion: @escaping (String?, Error?) -> Void)
    
}
