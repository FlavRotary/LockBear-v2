//
//  SiteActionsViewModel.swift
//  Lock Bear
//
//  Created by Flavian Rotaru on 26/04/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation

class SiteActionsViewModel: SiteActionsViewModelProtocol {
    
    var actions: [SiteAction] = []
    weak var selectedSite: Site?
    
    required init(with selectedSite: Site) {
        actions.append(.open)
        actions.append(.copyUsername)
        actions.append(.copyPass)
        actions.append(.edit)
        actions.append(.showPass)
        actions.append(.delete)
        
        self.selectedSite = selectedSite
    }
    
}
