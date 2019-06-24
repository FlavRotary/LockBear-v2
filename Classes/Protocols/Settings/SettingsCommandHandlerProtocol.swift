//
//  SettingsCommandHandlerProtocol.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 17/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation

protocol SettingsCommandHandlerProtocol: class {
    
    var viewModel: SettingsViewModelProtocol? {get}
    
    func didSelectSettingType(at index: Int)
    func didSwitch(at index:Int)
}
