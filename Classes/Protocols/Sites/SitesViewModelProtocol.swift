//
//  SitesViewModelProtocol.swift
//  LockBear
//
//  Created by Flavian Rotaru on 08/10/2018.
//  Copyright © 2018 Flavian Rotaru. All rights reserved.
//

import Foundation
import UIKit

protocol SitesViewModelProtocol: class {
    
    var delegate: SitesViewModelDelegate? { get set}
    var categories: [SiteCategory] {get}
    var selectedSite: Site? {get}
    
    func selectNewSite()
    func selectForEditing(_ site: Site)
    func saveSelectedSite(with completion: @escaping((Error?) -> Void))
    func deleteSite(_ site: Site, _ completion: @escaping ((Error?) -> Void))
}
