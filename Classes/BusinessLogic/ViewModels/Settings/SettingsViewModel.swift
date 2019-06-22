//
//  SettingsViewModel.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 17/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation
import LocalAuthentication

class SettingsViewModel: SettingsViewModelProtocol {
    
    var settings: Settings?
    var settingTypes: [SettingType]
    
    required init() {
        settings = UserDefaultsManager.shared.retrieveSettings()
        settingTypes = []
        initSettingTypes()
    }
    
    private func initSettingTypes() {
        settingTypes.append(SettingType(with: .changePass, .normal))
        settingTypes.append(SettingType(with: .useBio, .usingSwitch))
        settingTypes.append(SettingType(with: .tos, .normal))
        settingTypes.append(SettingType(with: .about, .normal))
        
        reloadIfNeeded()
    }
    
    private func getBiometryType() -> LABiometryType {
        let context = LAContext()
        
        var policy: LAPolicy?
        policy = .deviceOwnerAuthenticationWithBiometrics
        var err: NSError?
        guard context.canEvaluatePolicy(policy!, error: &err) else
        {
            if #available(iOS 11.2, *) {
                return .none
            } else {
                return .LABiometryNone
            }
        }
        
        return context.biometryType
    }
    
    func reloadIfNeeded() {
        
        let filtered = settingTypes.filter { (settingType) -> Bool in
            return settingType.setting == .useBio
        }
        
        if filtered.count == 0 {
            return
        }
        
        let useBioSetting = filtered[0]
        
        let bioType = getBiometryType()
        
        if bioType == .faceID || bioType == .touchID {
            useBioSetting.settingSwitchStatus = (settings?.useBioAuth ?? true) ? .on: .off
        } else {
            useBioSetting.settingSwitchStatus = .disabled
        }
    }
    
    func getSettingName(for index: Int) -> String {
        
        if settingTypes.count > index {
            return settingTypes[index].setting.getSettingsName()
        }
        
        return ""
    }
    
    func set(settings: Settings) {
        self.settings = settings
        UserDefaultsManager.shared.saveSettings(settings: settings)
    }
    
}
