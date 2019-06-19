//
//  LoginCommandHandler.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 17/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation
import UIKit

class LoginCommandHandler: LoginCommandHandlerProtocol {
    
    var mainViewController: UIViewController
    private var navigationController: UINavigationController
    private var loginViewController: LoginViewController?
    var viewModel: LoginViewModel
    
    required init() {
        
        viewModel = LoginViewModel()
        
        loginViewController = LoginViewController(with: nil)
        navigationController = UINavigationController(rootViewController: loginViewController!)
        mainViewController = navigationController
        
        loginViewController?.commandHandler = self
    }
    
    func tryBiometricLogin() {
        
    }
    
    func didPressLogin(_ password: String) {
        
    }
    
}
