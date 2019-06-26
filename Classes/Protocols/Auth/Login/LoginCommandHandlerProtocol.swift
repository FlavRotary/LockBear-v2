//
//  LoginCommandHandler.swift
//  Lock Bear
//
//  Created by Flavian Rotaru on 17/04/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation

protocol LoginCommandHandlerProtocol : class {
    
    var viewModel: AuthViewModelProtocol {get}
    var usingBiometricLogin: Bool {get}
    
    func tryBiometricLogin()
    func didPressLogin(_ password: String)
    
}
