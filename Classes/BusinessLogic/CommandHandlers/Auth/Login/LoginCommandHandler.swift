//
//  LoginCommandHandler.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 17/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation
import UIKit

class LoginCommandHandler: LoginCommandHandlerProtocol, RegisterCommnadHandlerDelegate {
    
    //MARK: - Vars
    
    weak var mainViewController: UIViewController?
    private var navigationController: UINavigationController
    private var loginViewController: LoginViewController?
    var viewModel: AuthViewModelProtocol
    private var registerCommandHandler: RegisterCommandHandler?
    
    //MARK: - Initializer
    
    required init() {
        
        viewModel = AuthViewModel()
        
        loginViewController = LoginViewController(with: nil)
        navigationController = UINavigationController(rootViewController: loginViewController!)
        mainViewController = navigationController
        
        loginViewController?.commandHandler = self
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            self.checkIfRegisterNeeded()
        }
    }
    
    //MARK: - Register Navigation
    
    private func checkIfRegisterNeeded() {
        if viewModel.settings == nil || viewModel.settings?.vaultPassword == nil {
            //show register alert
            
            UIAlertController.showNoticeAlert("Please Register", "The bear welcomes you, brave warrior. There is no password set up yet for your vault, so please set it up.", self.navigationController) {
                self.showRegister()
            }
        }
    }
    
    private func showRegister() {
        
        if registerCommandHandler != nil {
            registerCommandHandler = nil
        }
        
        registerCommandHandler = RegisterCommandHandler()
        registerCommandHandler?.delegate = self
        registerCommandHandler?.viewModel = self.viewModel
        registerCommandHandler?.navigationController = self.navigationController
        if let registerMainViewController = registerCommandHandler?.mainViewController {
            self.navigationController.pushViewController(registerMainViewController, animated: true)
        }
        
    }
    
    //MARK: - RegisterCommandHandlerDelegate
    
    func didDismissRegister() {
        registerCommandHandler?.delegate = nil
        registerCommandHandler = nil
    }
    
    //MARK: - Protocol Functions
    
    func tryBiometricLogin() {
        
    }
    
    func didPressLogin(_ password: String) {
        
    }
    
}
