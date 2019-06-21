//
//  SettingsModel.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 17/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation

class Settings {
    
    private var vaultPassword: String?
    var useBioAuth: Bool = true
    
    convenience init(with dict: [String: Any]) {
        self.init()
        set(with: dict)
    }
    
    func set(with dict: [String: Any]) {
        
        if let password = dict["password"] as? String {
            vaultPassword = password
        }
        
        if let bioAuth = dict["useBioAuth"] as? Bool {
            useBioAuth = bioAuth
        }
    }
    
    func getDict() -> [String: Any]? {
        
        var dict : [String: Any] = [:]
        
        if let vaultPassword = self.vaultPassword {
            dict["password"] = vaultPassword
        }
        
        dict["useBioAuth"] = useBioAuth
        
        return dict
        
    }
    
    func setNewPassword(password: String) throws{
        
        vaultPassword = password.md5()
        
        let regexPattern = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8}$"
        let regexTest = NSPredicate(format:"SELF MATCHES %@", regexPattern)
        if regexTest.evaluate(with: password) == false {
            throw NSError(domain: "com.lockbear", code: 100, userInfo: [NSLocalizedDescriptionKey: "The password is too weak. The bear asks for a password of at least 8 characters and with at least one uppercase letter, one lowercase letter and one number."])
        }
    }
    
    func getVaultPassword() -> String? {
        
        return vaultPassword
    }
}
