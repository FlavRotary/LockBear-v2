//
//  SitesCommandHandlerProtocol.swift
//  Lock Bear
//
//  Created by Flavian Rotaru on 17/02/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation

protocol SitesCommandHandlerProtocol: class {
    
    var viewModel: SitesViewModelProtocol { get set}
    
    func didSelectSiteAtIndexPath(_ indexPath: IndexPath)
    func didPressAdd()
}
