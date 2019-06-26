//
//  MainCommandHandler.swift
//  Lock Bear
//
//  Created by Flavian Rotaru on 17/02/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation
import UIKit

class MainCommandHandler: LoginCommandHandlerDelegate {
    
    var mainViewController: UIViewController
    private var sitesCommandHandler: SitesCommandHandler
    private var settingsCommandHandler: SettingsCommandHandler
    private var loginCommandHandler: LoginCommandHandler?
    private var loginWindow: UIWindow?
    
    required init() {
        
        
        sitesCommandHandler = SitesCommandHandler()
        settingsCommandHandler = SettingsCommandHandler()
        let mainViewController = UITabBarController()
        
        var tabbarControllers: [UIViewController] = []
        if let sitesMainViewController = sitesCommandHandler.mainViewController {
            tabbarControllers.append(sitesMainViewController)
        }
        if let settingsMainViewController = settingsCommandHandler.mainViewController {
            tabbarControllers.append(settingsMainViewController)
        }
        
        mainViewController.viewControllers = tabbarControllers
        
        if let _ = sitesCommandHandler.mainViewController {
            
            let sitesItem = mainViewController.tabBar.items?[0]
            sitesItem?.image = UIImage(named: "sites-tabbatItem")
            
        }
        if let settingsMainViewController = settingsCommandHandler.mainViewController {
            
            let index = tabbarControllers.firstIndex(where: {$0 == settingsMainViewController})
            
            if index != nil {
                let settingsItem = mainViewController.tabBar.items?[index!]
                settingsItem?.image = UIImage(named: "settings-tabbatItem")
            }
            
        }
        
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
        loginCommandHandler?.delegate = self
        if let loginCommandHandler = loginCommandHandler, let loginMainViewController = loginCommandHandler.mainViewController {
            loginWindow = UIWindow(frame: UIScreen.main.bounds)
            loginWindow?.rootViewController = UIViewController()
            let topWindow = UIApplication.shared.windows.last
            loginWindow?.windowLevel = UIWindow.Level(rawValue: UIWindow.Level.RawValue(topWindow?.windowLevel.rawValue ?? 0 + 100))
            loginWindow?.makeKeyAndVisible()
            loginWindow?.rootViewController?.present(loginMainViewController, animated: animated, completion: nil)
        }
        
        
    }
    
    //MARK: - LoginCommandHandlerDelegate0
    
    func didDismissLogin() {
        loginCommandHandler?.delegate = nil
        loginCommandHandler = nil
        loginWindow?.isHidden = true
        loginWindow = nil
    }
    
}
