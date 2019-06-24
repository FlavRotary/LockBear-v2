//
//  SettingsViewModelProtocol.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 17/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation

protocol SettingsViewModelProtocol: class {
    
    var settings: Settings? {get}
    var settingTypes: [SettingType] {get}
    
    func reloadIfNeeded()
    func getSettingName(for index: Int) -> String
    func set(settings: Settings)
    
}
