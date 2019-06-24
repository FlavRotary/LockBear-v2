//
//  SitesViewModelProtocol.swift
//  LockBear
//
//  Created by Flavian Rotaru on 08/10/2018.
//  Copyright © 2018 Flavian Rotaru. All rights reserved.
//

import Foundation

protocol SitesViewModelProtocol {
    
    var delegate: SitesViewModelDelegate? { get set }
    var categories: [SiteCategory] {get}
    
    func addSite(_ site: Site)
    func editSite(_ site: Site)
    func deleteSite(_ site: Site)
    func getSitePass(_ site: Site)
}
