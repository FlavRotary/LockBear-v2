//
//  SettingsCommandHandlerProtocol.swift
//  Lock Bear
//
//  Created by Flavian Rotaru on 17/04/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation

protocol SettingsCommandHandlerProtocol: class {
    
    var viewModel: SettingsViewModelProtocol? {get}
    
    func didSelectSettingType(at index: Int)
    func didSwitch(at index:Int)
}
