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
    var icon: UIImage {
        
        if self.url?.hasPrefix("https://dropbox.com") ?? false || self.url?.hasPrefix( "http://dropbox.com") ?? false {
            return UIImage(named: "dropbox_logo")!
        }
        
        if self.url?.hasPrefix("https://facebook.com") ?? false || self.url?.hasPrefix( "http://facebook.com") ?? false {
            return UIImage(named: "facebook_logo")!
        }
        
        if self.url?.hasPrefix("https://github.com") ?? false || self.url?.hasPrefix( "http://github.com") ?? false {
            return UIImage(named: "github_logo")!
        }
        
        if self.url?.hasPrefix("https://facebook.com") ?? false || self.url?.hasPrefix( "http://facebook.com") ?? false {
            return UIImage(named: "facebook_logo")!
        }
        
        if self.url?.hasPrefix("https://google.com") ?? false || self.url?.hasPrefix( "http://google.com") ?? false || self.url?.hasPrefix("https://mail.google.com") ?? false || self.url?.hasPrefix( "http://mail.google.com") ?? false {
            return UIImage(named: "google_logo")!
        }
        
        if self.url?.hasPrefix("https://instagram.com") ?? false || self.url?.hasPrefix( "http://instagram.com") ?? false {
            return UIImage(named: "instagram_logo")!
        }
        
        if self.url?.hasPrefix("https://kickstarter.com") ?? false || self.url?.hasPrefix( "http://kickstarter.com") ?? false {
            return UIImage(named: "kickstarter-logo")!
        }
        
        if self.url?.hasPrefix("https://linkedin.com") ?? false || self.url?.hasPrefix( "http://instagram.com") ?? false {
            return UIImage(named: "linkedin_logo")!
        }
        
        if self.url?.hasPrefix("https://reddit.com") ?? false || self.url?.hasPrefix( "http://reddit.com") ?? false {
            return UIImage(named: "reddit_logo")!
        }
        
        if self.url?.hasPrefix("https://skype.com") ?? false || self.url?.hasPrefix( "http://skype.com") ?? false {
            return UIImage(named: "skype_logo")!
        }
        
        if self.url?.hasPrefix("https://soundcloud.com") ?? false || self.url?.hasPrefix( "http://soundcloud.com") ?? false {
            return UIImage(named: "soundcloud_logo")!
        }
        
        if self.url?.hasPrefix("https://spotify.com") ?? false || self.url?.hasPrefix( "http://spotify.com") ?? false {
            return UIImage(named: "spotify_logo")!
        }
        
        if self.url?.hasPrefix("https://teamviewer.com") ?? false || self.url?.hasPrefix( "http://teamviewer.com") ?? false {
            return UIImage(named: "teamviewer_logo")!
        }
        
        if self.url?.hasPrefix("https://twitter.com") ?? false || self.url?.hasPrefix( "http://twitter.com") ?? false {
            return UIImage(named: "twitter_logo")!
        }
        
        if self.url?.hasPrefix("https://vimeo.com") ?? false || self.url?.hasPrefix( "http://vimeo.com") ?? false {
            return UIImage(named: "vimeo_logo")!
        }
        
        if self.url?.hasPrefix("https://mail.yahoo.com") ?? false || self.url?.hasPrefix( "http://mail.yahoo.com") ?? false || self.url?.hasPrefix("https://yahoo.com") ?? false || self.url?.hasPrefix("http://yahoo.com") ?? false{
            return UIImage(named: "yahoo_logo")!
        }
        
        return UIImage(named: "website_placeholder_icon")!
    }
    
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
