//
//  SettingsCommandHandler.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 17/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation
import UIKit

class SettingsCommandHandler: SettingsCommandHandlerProtocol {
    
    var mainViewController: UIViewController
    private var navigationController: UINavigationController
    private var settingsViewController: SettingsViewController?
    
    required init() {
        
        settingsViewController = SettingsViewController(with: nil)
        navigationController = UINavigationController(rootViewController: settingsViewController!)
        mainViewController = navigationController
        
        settingsViewController?.commandHandler = self
    }
    
}
