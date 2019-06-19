//
//  LoginCommandHandler.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 17/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation

protocol LoginCommandHandlerProtocol : class {
    
    var viewModel: LoginViewModel {get}
    
    func tryBiometricLogin()
    func didPressLogin(_ password: String)
    
}
