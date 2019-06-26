//
//  SiteActionsViewModel.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 26/06/2019.
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
