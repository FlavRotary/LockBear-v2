//
//  SitesCommandHandler.swift
//  Lock Bear
//
//  Created by Flavian Rotaru on 17/03/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation
import UIKit

class SitesCommandHandler: SitesCommandHandlerProtocol {
    
    var mainViewController: UIViewController
    private var navigationController: UINavigationController
    private var sitesViewController: SitesViewController?
    
    required init() {
    
        sitesViewController = SitesViewController(with: nil)
        navigationController = UINavigationController(rootViewController: sitesViewController!)
        mainViewController = navigationController
        
        sitesViewController?.commandHandler = self
    }
    
}
