//
//  UserDefaultsManager.swift
//  Lock Bear
//
//  Created by Flavian Rotaru on 21/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    func retrieveSettings() -> Settings? {
        
        if let dict = UserDefaults.standard.dictionary(forKey: "settings") {
            
            return Settings(with: dict)
        }
        
        return nil
        
    }
    
    func saveSettings(settings: Settings?) {
        UserDefaults.standard.set(settings?.getDict(), forKey: "settings")
        UserDefaults.standard.synchronize()
    }
    
}
