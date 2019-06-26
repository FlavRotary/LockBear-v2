//
//  SettingsCommandHandler.swift
//  Lock Bear
//
//  Created by Flavian Rotaru on 17/04/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation
import UIKit

class SettingsCommandHandler: SettingsCommandHandlerProtocol {
    
    weak var mainViewController: UIViewController?
    private var navigationController: UINavigationController
    private var settingsViewController: SettingsViewController?
    var viewModel: SettingsViewModelProtocol?
    
    required init() {
        
        viewModel = SettingsViewModel()
        
        settingsViewController = SettingsViewController(with: nil)
        navigationController = UINavigationController(rootViewController: settingsViewController!)
        mainViewController = navigationController
        
        settingsViewController?.commandHandler = self
    }
    
    private func showToS() {
        
        let tosViewModel = ToSViewModel()
        let tosViewController = ToSViewController(with: tosViewModel)
        tosViewController.title = Setting.tos.getSettingsName()
        self.navigationController.pushViewController(tosViewController, animated: true)
    }
    
    private func showInfo(){
        let infoViewModel = InfoViewModel()
        let infoViewController = InfoViewController(with: infoViewModel)
        infoViewController.title = Setting.about.getSettingsName()
        self.navigationController.pushViewController(infoViewController, animated: true)
        
    }
    
    private func showChangePass() {
        let changePassCommandHandler = ChangePassCommandHandler(with: viewModel, navigationController)
        if let changePassMainController = changePassCommandHandler.mainViewController {
            navigationController.pushViewController(changePassMainController, animated: true)
        }
    }
    
    func didSelectSettingType(at index: Int) {
        
        if let settingType = viewModel?.settingTypes[index] {
            switch settingType.setting {
            case .tos:
                showToS()
                break
            case .about:
                showInfo()
                break
            case .changePass:
                showChangePass()
                break
            default:
                break
            }
        }
        
    }
    
    func didSwitch(at index: Int) {
        
        if let settingType = viewModel?.settingTypes[index] {
            if settingType.editType != .usingSwitch {
                return
            }
            
            switch settingType.setting {
            case .useBio:
                if let settings = self.viewModel?.settings {
                    settings.useBioAuth = !settings.useBioAuth
                    self.viewModel?.set(settings: settings)
                }
                break
            default:
                break;
            }
        }
        
    }
    
}
