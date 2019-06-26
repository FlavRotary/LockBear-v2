//
//  UpdateSiteCommandHandlerProtocol.swift
//  Lock Bear
//
//  Created by Flavian Rotaru on 25/04/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation
import UIKit

protocol UpdateSiteCommandHandlerProtocol {
    var viewModel: SitesViewModelProtocol? {get}
    
    func didPressSave()
}
