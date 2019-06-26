//
//  SiteActionsViewModelProtocol.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 26/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation

protocol SiteActionsViewModelProtocol:class {
    
    var actions: [SiteAction] {get}
    var selectedSite: Site? {get set}
    
}
