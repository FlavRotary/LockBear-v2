//
//  MainCommandHandler.swift
//  Lock Bear
//
//  Created by Flavian Rotaru on 17/02/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation
import UIKit

class MainCommandHandler {
    
    var mainViewController: UIViewController
    private var sitesCommandHandler: SitesCommandHandler
    private var settingsCommandHandler: SettingsCommandHandler
    private var loginCommandHandler: LoginCommandHandler?
    
    required init() {
        
        
        sitesCommandHandler = SitesCommandHandler()
        settingsCommandHandler = SettingsCommandHandler()
        let mainViewController = UITabBarController()
        mainViewController.viewControllers = [sitesCommandHandler.mainViewController, settingsCommandHandler.mainViewController]
        
        let sitesItem = mainViewController.tabBar.items?[0]
        sitesItem?.image = UIImage(named: "sites-tabbatItem")
        
        let settingsItem = mainViewController.tabBar.items?[1]
        settingsItem?.image = UIImage(named: "settings-tabbatItem")
        
        self.mainViewController = mainViewController
        
        setGlobalAppearance()
        registerForAppNotifications()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            self.showLogin(false)
        }
    }
    
    func setGlobalAppearance() {
        
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = UIColor(red: 51.0/255.0, green: 214.0/255.0, blue: 193.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        
        UITabBar.appearance().unselectedItemTintColor = .white
        UITabBar.appearance().barTintColor = UIColor(red: 51.0/255.0, green: 214.0/255.0, blue: 193.0/255.0, alpha: 1.0)
        UITabBar.appearance().tintColor = UIColor(red: 92.0/255.0, green: 81.0/255.0, blue: 151.0/255.0, alpha: 1.0)
        
        let tabbarTitleAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
        
        UITabBarItem.appearance().setTitleTextAttributes(tabbarTitleAttributes, for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes(tabbarTitleAttributes, for: .normal)
        
    }
    
    func registerForAppNotifications() {
        NotificationCenter.default.addObserver(forName: UIApplication.willResignActiveNotification, object: nil, queue: nil) { (notification) in
            self.showLogin(false)
        }
    }
    
    func showLogin(_ animated: Bool) {
        
        if loginCommandHandler != nil {
            return
        }
        
        loginCommandHandler = LoginCommandHandler()
        mainViewController.present(loginCommandHandler!.mainViewController, animated: animated, completion: nil)
        
    }
    
}
