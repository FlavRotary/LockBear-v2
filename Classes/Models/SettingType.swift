//
//  SettingType.swift
//  Lock Bear
//
//  Created by Flavian Rotaru on 22/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation

class SettingType {
    
    var setting: Setting
    var editType: SettingEditType
    var settingSwitchStatus: SettingSwitchStatus = .disabled
    
    required init(with setting: Setting, _ editType: SettingEditType, _ switchStatus: SettingSwitchStatus = .disabled) {
        self.setting = setting
        self.editType = editType
        self.settingSwitchStatus = switchStatus
    }
}
