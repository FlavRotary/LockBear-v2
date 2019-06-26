//
//  SiteActionsCommandHandlerProtocol.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 26/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation

protocol SiteActionsCommandHandlerProtocol: class {
    
    var viewModel: SiteActionsViewModelProtocol {get}
    func didSelectAction(at index:Int)
    func didClickOverlay()
    
}
