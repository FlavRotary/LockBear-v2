//
//  UITableVIewCellExtension.swift
//  Lock Bear
//
//  Created by Flavian Rotaru on 22/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    public class var cellReuseIdentifier : String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    
    public class var nib : UINib {
        let xibName = NSStringFromClass(self).components(separatedBy: ".").last!
        return UINib(nibName: xibName, bundle: nil)
    }
    
}
