//
//  LAuthViewModel.swift
//  Lock Bear
//
//  Created by Flavian Rotaru on 17/04/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation
import LocalAuthentication

class AuthViewModel: AuthViewModelProtocol {
    
    var settings: Settings?
    
    required init() {
        
        settings = UserDefaultsManager.shared.retrieveSettings()
        
    }
    
    func getBiometryType() -> LABiometryType {
        let context = LAContext()
        
        var policy: LAPolicy?
        policy = .deviceOwnerAuthenticationWithBiometrics
        var err: NSError?
        guard context.canEvaluatePolicy(policy!, error: &err) else
        {
            if #available(iOS 11.2, *) {
                return .none
            } else {
                return .LABiometryNone
            }
        }
        
        return context.biometryType
    }
}
