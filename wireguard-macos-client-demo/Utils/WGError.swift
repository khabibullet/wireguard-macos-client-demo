//
//  WGError.swift
//  wireguard-macos-client-demo
//
//  Created by Irek Khabibullin on 14.06.2023.
//

import Foundation

enum WGError {
    
    struct HelperInstallation {
        
        static let emptyAuthCreation = NSError(
            domain: "WGHelperEmptyAuthError", code: 0,
            userInfo: [NSLocalizedDescriptionKey :"Unable to get a valid empty authorization reference to load Helper daemon"]
        )
        
        static let loadingAuthCreation = NSError(
            domain: "WGHelperLoadingAuthError", code: 0,
            userInfo: [NSLocalizedDescriptionKey :"Unable to get a valid loading authorization reference to load Helper daemon"]
        )
        
    }
    
    static let helperRemoteUnknown = NSError(
        domain: "WGHelperRemoteUnknown", code: 0,
        userInfo: [NSLocalizedDescriptionKey :"Unknown helper remote error"]
    )
    
}
