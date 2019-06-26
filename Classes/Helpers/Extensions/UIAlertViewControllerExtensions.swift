//
//  UIAlertViewControllerExtensions.swift
//  Lock Bear
//
//  Created by Flavian Rotaru on 17/04/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    
    public static func showErrorAlert(_ message: String, _ parent: UIViewController) {
        
        let alert = UIAlertController.init(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction.init(title: "OK", style: .default) { (action) in
            
        }
        alert.addAction(action)
        parent.present(alert, animated: true, completion: nil)
        
    }
    
    public static func showNoticeAlert(_ title: String, _ message: String, _ parent: UIViewController) {
        
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction.init(title: "OK", style: .default) { (action) in
            
        }
        alert.addAction(action)
        parent.present(alert, animated: true, completion: nil)
        
    }
    
    public static func showNoticeAlert(_ title: String, _ message: String, _ parent: UIViewController, _ actionBlock: @escaping (() -> Void)) {
        
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction.init(title: "OK", style: .default) { (action) in
            actionBlock()
        }
        alert.addAction(action)
        parent.present(alert, animated: true, completion: nil)
        
    }
    
}
