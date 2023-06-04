//
//  WGHelperError.swift
//  wireguard-macos-client-demo
//
//  Created by Irek Khabibullin on 04.06.2023.
//

import Foundation

enum WGHelperError {
    
    static let decodeError = NSError(
        domain: "WGHelperDecodeError", code: 0,
        userInfo: [NSLocalizedDescriptionKey : "Cannot decode pipe output."]
    )
    
}
