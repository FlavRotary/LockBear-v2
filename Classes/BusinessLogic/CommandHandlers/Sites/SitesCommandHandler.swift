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
        
    weak var mainViewController: UIViewController?
    private var navigationController: UINavigationController
    private var sitesViewController: SitesViewController?
    var viewModel: SitesViewModelProtocol
    
    required init() {
    
        viewModel = SitesViewModel()
        
        sitesViewController = SitesViewController(with: nil)
        navigationController = UINavigationController(rootViewController: sitesViewController!)
        mainViewController = navigationController
        sitesViewController?.commandHandler = self
    }
    
    //MARK: - SitesCommandHandlerProtocol delegates
    
    func didSelectSiteAtIndexPath(_ indexPath: IndexPath) {
        //
    }
    
    func didPressAdd() {
        
        let updateCommandHandler = UpdateSiteCommandHandler()
        updateCommandHandler.viewModel = viewModel
        updateCommandHandler.viewModel?.selectNewSite()
        if let updateMainViewController = updateCommandHandler.mainViewController {
            self.navigationController.pushViewController(updateMainViewController, animated: true)
        }
        
    }
    
}
