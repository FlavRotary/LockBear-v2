//
//  UpdateSettingCommandHandler.swift
//  Lock Bear
//
//  Created by Flavian Rotaru on 17/04/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation
import UIKit

class ChangePassCommandHandler: ChangePassCommandHandlerProtocol {
    
    weak var viewModel: SettingsViewModelProtocol?
    weak var mainViewController: UIViewController?
    weak var navigationController: UINavigationController?
    private var changePassViewController: ChangePassViewController
    
    required init(with viewModel: SettingsViewModelProtocol?, _ navigationController: UINavigationController?) {
        self.viewModel = viewModel
        self.navigationController = navigationController
        
        changePassViewController = ChangePassViewController(with: nil)
        changePassViewController.commandHandler = self
        mainViewController = changePassViewController
    }
    
    func change(_ password: String) {
        if let settings = self.viewModel?.settings {
            do {
                try settings.setNewPassword(password: password)
            } catch {
                if let mainViewController = self.mainViewController {
                    UIAlertController.showErrorAlert(error.localizedDescription, mainViewController)
                }
                return
            }
            self.viewModel?.set(settings: settings)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
