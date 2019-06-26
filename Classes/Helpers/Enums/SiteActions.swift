//
//  SiteActions.swift
//  Lock Bear
//
//  Created by Flavian Rotaru on 26/04/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation
import UIKit

enum SiteAction {
    case open
    case copyUsername
    case copyPass
    case edit
    case showPass
    case delete
    
    func getName() -> String {
        switch self {
        case .open:
            return "Open in Safari"
        case .copyUsername:
            return "Copy Username"
        case .copyPass:
            return "Copy Password"
        case .edit:
            return "View / Edit"
        case .showPass:
            return "Show Password"
        case .delete:
            return "Delete"
        }
    }
    
    func getColor() -> UIColor {
        switch self {
        case .delete:
            return UIColor.red
        default:
            return UIColor.black
        }
    }
    
    func getLogo() -> UIImage {
        switch self {
        case .open:
            return UIImage(named: "open_icon")!
        case .copyPass:
            return UIImage(named: "copy_pass_icon")!
        case .copyUsername:
            return UIImage(named: "copy_user_icon")!
        case .edit:
            return UIImage(named: "edit_icon")!
        case .showPass:
            return UIImage(named: "show_pass_icon")!
        case .delete:
            return UIImage(named: "delete_icon")!
            
        }
    }
    
}
