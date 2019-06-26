//
//  LoginCommandHandler.swift
//  Lock Bear
//
//  Created by Flavian Rotaru on 17/04/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation
import UIKit
import LocalAuthentication

class LoginCommandHandler: LoginCommandHandlerProtocol, RegisterCommnadHandlerDelegate {
    
    //MARK: - Vars
    
    weak var mainViewController: UIViewController?
    weak var delegate: LoginCommandHandlerDelegate?
    private var navigationController: UINavigationController
    private var loginViewController: LoginViewController?
    var viewModel: AuthViewModelProtocol
    private var registerCommandHandler: RegisterCommandHandler?
    var usingBiometricLogin: Bool = false
    var biometricLoggedIn: Bool = false
    
    
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
        if viewModel.settings == nil || viewModel.settings?.getVaultPassword() == nil {
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
        
        if usingBiometricLogin || biometricLoggedIn {
            return
        }
        
        usingBiometricLogin = true
        
        var bioTypeString = "biometric authentication method"
        switch self.viewModel.getBiometryType() {
        case .faceID:
            bioTypeString = "Face ID"
            break
        case .touchID:
            bioTypeString = "Touch ID"
            break
        default:
            break
        }
        let reason = "The Bear wants to use your \(bioTypeString) to login."
        let context = LAContext()
        context.localizedFallbackTitle = "Use Password"
        context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { success, error in
            
            self.usingBiometricLogin = false
            
            if success {
                
                self.biometricLoggedIn = true
                
                // Move to the main thread because a state update triggers UI changes.
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) { [unowned self] in
                    self.loginSuccessfull()
                }
                
            } else {
                print(error?.localizedDescription ?? "Failed to authenticate")
                
                // Fall back to a asking for username and password.
                
                let alert = UIAlertController(title: "Failed", message: "\(bioTypeString.capitalizingFirstLetter()) failed.", preferredStyle: .alert)
                let tryAgain = UIAlertAction(title: "Try again", style: .default, handler: { (action) in

                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
                        self.tryBiometricLogin()
                    }

                })
                alert.addAction(tryAgain)
                let cancel = UIAlertAction(title: "Use password", style: .cancel, handler: { (alert) in

                })
                alert.addAction(cancel)
                self.mainViewController?.present(alert, animated: true, completion: {

                })
                
            }
        }
        
    }
    
    func didPressLogin(_ password: String) {
        
        if self.viewModel.settings?.getVaultPassword() != password.md5() {
            
            UIAlertController.showErrorAlert("The password is incorrect. Did you forget it boss?", self.navigationController)
            
            return
            
        }
        
        self.loginSuccessfull()
        
    }
    
    //MARK: - Successfull login method
    
    func loginSuccessfull() {
        self.mainViewController?.dismiss(animated: true, completion: {
            self.delegate?.didDismissLogin()
        })
    }
    
}
