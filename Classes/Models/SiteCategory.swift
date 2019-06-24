//
//  SiteCategory.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 17/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation
import UIKit

class SiteCategory {
    var id: Int?
    var name: String?
    var icon: UIImage!
    var sites: [Site]? = []
    
    init(_ id: Int, _ name: String, _ icon: UIImage, _ sites: [Site]) {
        self.id = id
        self.name = name
        self.icon = icon
        self.sites = sites
    }
}
