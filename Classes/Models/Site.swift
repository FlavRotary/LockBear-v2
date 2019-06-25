//
//  Site.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 17/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation
import UIKit

class Site{
    
    var id: Int?
    var categoryid: Int?
    var siteCategory: SiteCategory?
    var name: String?
    var url: String?
    var username: String?
    var password: String?
    var icon: UIImage = UIImage(named: "website_placeholder_icon")!
    
    init() {
        
    }
    
    init(_ id: Int, _ categoryid: Int, _ name: String, _ url: String, _ username: String, _ password: String) {
        self.id = id
        self.categoryid = categoryid
        self.name = name
        self.url = url
        self.username = username
        self.password = password
    }
    
    init(_ id: Int, _ categoryid: Int, _ name: String, _ url: String, _ username: String){
        self.id = id
        self.categoryid = categoryid
        self.name = name
        self.url = url
        self.username = username
    }
    
    func nilCheck(){
        if self.categoryid == nil {
            self.categoryid = 1
        }
        if self.name == nil {
            self.name = "No Name"
        }
        
        if self.url == nil {
            self.url = "http://www.google.com"
        }
        if self.username == nil {
            self.username = "Unknown"
        }
        if self.password == nil {
            self.password = "NoPass"
        }
    }
    
}
