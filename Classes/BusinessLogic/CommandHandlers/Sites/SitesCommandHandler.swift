//
//  SitesCommandHandler.swift
//  Lock Bear
//
//  Created by Flavian Rotaru on 17/03/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation
import UIKit

class SitesCommandHandler: SitesCommandHandlerProtocol, SiteActionsCommandHandlerDelegate {
        
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
        
        let selectedSite = viewModel.categories[indexPath.section].sites[indexPath.row]
        
        let siteActionsCommandHandler = SiteActionsCommandHandler(with: selectedSite)
        siteActionsCommandHandler.delegate = self
        
        if let siteActionsMainViewController = siteActionsCommandHandler.mainViewController {
            siteActionsMainViewController.modalPresentationStyle = .overCurrentContext
            self.sitesViewController?.present(siteActionsMainViewController, animated: true, completion: nil)
        }

    }
    
    func didPressAdd() {
        
        let updateCommandHandler = UpdateSiteCommandHandler()
        updateCommandHandler.viewModel = viewModel
        updateCommandHandler.viewModel?.selectNewSite()
        updateCommandHandler.navigationController = navigationController
        if let updateMainViewController = updateCommandHandler.mainViewController {
            self.navigationController.pushViewController(updateMainViewController, animated: true)
        }
        
    }
    
    //MARK: - SiteActionsCHDelegate
    
    func didDismiss(_ ch: SiteActionsCommandHandler, with action: SiteAction?, for site: Site?) {
        
        if let action = action, let site = site {
            
            switch action {
            case .open:
                
                if let siteUrl = site.url, let url = URL(string: siteUrl) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            case .showPass:
                
                if let pass = site.password {
                    let alert = UIAlertController(title: "Show Password", message: "Your password is: \n\(pass)", preferredStyle: .alert)
                    let copy = UIAlertAction(title: "Copy Password", style: .default) { (action) in
                        UIPasteboard.general.string = pass
                    }
                    alert.addAction(copy)
                    alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
                    self.mainViewController?.present(alert, animated: true, completion: {
                        
                    })
                }
            case .edit:
                let updateCommandHandler = UpdateSiteCommandHandler()
                updateCommandHandler.viewModel = viewModel
                updateCommandHandler.viewModel?.selectForEditing(site)
                updateCommandHandler.navigationController = navigationController
                if let updateMainViewController = updateCommandHandler.mainViewController {
                    self.navigationController.pushViewController(updateMainViewController, animated: true)
                }
            case .delete:
                self.viewModel.deleteSite(site) { (error) in
                    DispatchQueue.main.async {
                        if let error = error {
                            UIAlertController.showErrorAlert(error.localizedDescription, self.navigationController)
                        }
                    }
                }
                
            default:
                break
            }
        }
        
        ch.delegate = nil
    }
    
}
