//
//  SiteActionsCommandHandlerProtocol.swift
//  Lock Bear
//
//  Created by Flavian Rotaru on 26/04/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation

protocol SiteActionsCommandHandlerProtocol: class {
    
    var viewModel: SiteActionsViewModelProtocol {get}
    func didSelectAction(at index:Int)
    func didClickOverlay()
    
}
