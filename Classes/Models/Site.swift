//
//  Site.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 17/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation
import UIKit

enum PasswordState: String{
    case isHidden
    case isShown
    case isSetted
}
class Site{
    
    var id: Int?
    var categoryid: Int!
    var siteCategory: SiteCategory!
    var name: String!
    var url: String!
    var username: String!
    var password: String!
    var icon: UIImage!
    var state: PasswordState{
        didSet{
            switch state{
            case .isHidden : hidePass()
            case .isShown : getPass()
            case .isSetted:
                break
            }
        }
    }

    
    init(_ id: Int, _ categoryid: Int, _ name: String, _ url: String, _ username: String, _ password: String, _ icon: UIImage) {
        self.id = id
        self.categoryid = categoryid
        self.name = name
        self.url = url
        self.username = username
        self.state = .isSetted
        self.password = password
    }
    
    init(_ id: Int, _ categoryid: Int, _ name: String, _ url: String, _ username: String, _ icon: UIImage){
        self.id = id
        self.categoryid = categoryid
        self.name = name
        self.url = url
        self.username = username
        self.icon = icon
        self.state = .isHidden
    }
    
    func hidePass(){
        self.password = "*******"
    }
    
    func getPass(){
        //To be implemented later
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
        if self.icon == nil{
            self.icon = UIImage(named: "pass_lock_icon_unselected")
        }
        self.state = .isSetted
    }
    
}
