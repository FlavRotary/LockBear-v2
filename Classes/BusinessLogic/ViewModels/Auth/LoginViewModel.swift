//
//  LAuthViewModel.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 17/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation
import LocalAuthentication

class AuthViewModel: AuthViewModelProtocol {
    
    var settings: Settings?
    
    required init() {
        
    }
    
    func getBiometryType() -> LABiometryType {
        let context = LAContext()
        return context.biometryType
    }
}
