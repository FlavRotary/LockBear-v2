//
//  AuthViewModelProtocol.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 17/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation
import LocalAuthentication

protocol AuthViewModelProtocol: class {
    
    var settings: Settings? {get set}
    func getBiometryType() -> LABiometryType
    
}
