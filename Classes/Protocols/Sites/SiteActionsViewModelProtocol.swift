//
//  SiteActionsViewModelProtocol.swift
//  Lock Bear
//
//  Created by Flavian Rotaru on 26/04/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation

protocol SiteActionsViewModelProtocol:class {
    
    var actions: [SiteAction] {get}
    var selectedSite: Site? {get set}
    
}
