//
//  UpdateSiteCommandHandler.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 17/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation
import UIKit

class UpdateSiteCommandHandler: UpdateSiteCommandHandlerProtocol {
    
    weak var mainViewController: UIViewController?
    weak var navigationController : UINavigationController?
    weak var viewModel: SitesViewModelProtocol?
    private var updateViewController: UpdateSiteViewController
    
    required init() {
        
        updateViewController = UpdateSiteViewController(with: nil)
        mainViewController = updateViewController
        updateViewController.commandHandler = self
        
    }
    
    func didPressSave() {
        
        if let viewModel = self.viewModel, let selectedSite = viewModel.selectedSite {
            selectedSite.categoryid = updateViewController.selectedCategory?.id
            selectedSite.name = updateViewController.siteNameTextField.text
            selectedSite.url = updateViewController.siteUrlTextField.text
            selectedSite.username = updateViewController.SiteUsernameTextField.text
            selectedSite.password = updateViewController.sitePasswordTextField.text
            if let image = updateViewController.iconImgView.image {
                selectedSite.icon = image
            }
            
            viewModel.saveSelectedSite { (error) in
                
                DispatchQueue.main.async {
                    if let error = error {
                        UIAlertController.showErrorAlert(error.localizedDescription, self.updateViewController)
                    } else {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
                
            }
        }
        
    }
    
}
