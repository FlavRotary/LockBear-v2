//
//  SiteCategory.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 17/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation

class SiteCategory {
    var id: Int?
    var name: String?
    var sites: [Site]? // Because of your ultimatum: Your way or the highway >:P
    
    init(_ id: Int, _ name: String,_ sites: [Site]) {
        self.id = id
        self.name = name
        self.sites = sites
    }
}
