//
//  SettingTypesEnum.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 22/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation

enum Setting {
    case changePass
    case useBio
    case about
    case tos
    
    func getSettingsName() -> String {
        switch self {
        case .changePass:
            return "Change Password"
        case .useBio:
            return "Use Biometric Login"
        case .about:
            return "About this app"
        case .tos:
            return "Terms and Conditions"
        }
    }
}

enum SettingEditType {
    case normal
    case usingSwitch
}

enum SettingSwitchStatus {
    case disabled
    case on
    case off
}
