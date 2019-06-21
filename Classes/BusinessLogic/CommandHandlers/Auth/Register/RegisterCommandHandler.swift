//
//  RegisterCommandHandler.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 17/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation
import UIKit

class RegisterCommandHandler: RegisterCommandHandlerProtocol {
    
    weak var mainViewController: UIViewController?
    weak var navigationController: UINavigationController?
    private var registerViewController: RegisterViewController?
    weak var viewModel: AuthViewModelProtocol?
    
    required init() {
        
        registerViewController = RegisterViewController(with: nil)
        mainViewController = registerViewController
        registerViewController?.commandHandler = self
        
    }
    
    func register(with password: String!) {
        
        if let viewModel = viewModel {
            
            if viewModel.settings == nil {
                viewModel.settings = Settings()
                viewModel.settings?.vaultPassword = password
                viewModel.settings?.useBioAuth = true
                
                //TODO: save settings
            }
        }
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
