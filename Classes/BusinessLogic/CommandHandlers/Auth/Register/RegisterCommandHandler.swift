//
//  RegisterCommandHandler.swift
//  Lock Bear
//
//  Created by Flavian Rotaru on 17/04/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation
import UIKit

class RegisterCommandHandler: RegisterCommandHandlerProtocol {
    
    //MARK: - Vars
    
    weak var mainViewController: UIViewController?
    weak var navigationController: UINavigationController?
    private var registerViewController: RegisterViewController?
    weak var viewModel: AuthViewModelProtocol?
    weak var delegate: RegisterCommnadHandlerDelegate?
    
    //MARK: - Init
    
    required init() {
        
        registerViewController = RegisterViewController(with: nil)
        mainViewController = registerViewController
        registerViewController?.commandHandler = self
        
    }
    
    //MARK: - Protocol functions
    
    func register(with password: String!) {
        
        if let viewModel = viewModel {
            
            if viewModel.settings == nil {
                viewModel.settings = Settings()
                viewModel.settings?.useBioAuth = true
            }
            
            do {
                try viewModel.settings?.setNewPassword(password: password)
            } catch {
                viewModel.settings = nil
                if let mainViewController = self.mainViewController {
                    UIAlertController.showErrorAlert(error.localizedDescription, mainViewController)
                }
                return
            }
            
            
            UserDefaultsManager.shared.saveSettings(settings: viewModel.settings)
        }
        
        self.navigationController?.popViewController(animated: true)
        self.delegate?.didDismissRegister()
        
    }
    
}
