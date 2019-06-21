//
//  Site.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 17/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation
enum PasswordState: String{
    case isHidden
    case isShown
}
class Site{
    
    var id: Int?
    var categoryid: Int?
    var name: String?
    var url: String?
    var username: String?
    var password: String?
    var state: PasswordState{
        didSet{
            switch state{
            case .isHidden : hidePass()
            case .isShown : getPass()
                
            }
        }
    }
    
    init(_ id: Int, _ categoryid: Int, _ name: String, _ url: String,_ username: String) {
        self.id = id
        self.categoryid = categoryid
        self.name = name
        self.url = url
        self.username = username
        self.state = .isHidden
    }
    
    // Pass logic :
    // # if it is needed to be shown -> getPass() and put it in self.password only for the time it is used
    // # else -> make the password "*******" to be more secure
    
    func hidePass(){
        self.password = "*******"
    }
    
    func getPass(){
        //To be implemented later
    }

}
