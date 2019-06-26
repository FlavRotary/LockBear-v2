//
//  SiteActionsCommandHandler.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 26/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation
import UIKit

protocol SiteActionsCommandHandlerDelegate: class {
    func didDismiss(_ ch: SiteActionsCommandHandler, with action:SiteAction?, for site: Site?)
}

class SiteActionsCommandHandler: SiteActionsCommandHandlerProtocol {
    
    weak var mainViewController: UIViewController?
    weak var delegate : SiteActionsCommandHandlerDelegate?
    var viewModel: SiteActionsViewModelProtocol
    private var siteActionsViewController: SiteActionsViewController
    
    required init(with selectedSite: Site) {
        viewModel = SiteActionsViewModel(with: selectedSite)
        siteActionsViewController = SiteActionsViewController(with: nil)
        siteActionsViewController.commandHandler = self
        
        mainViewController = siteActionsViewController
    }
    
    func didSelectAction(at index:Int) {
        
        siteActionsViewController.dismiss(animated: true) {
            
            let action = self.viewModel.actions[index]
            
            switch action {
            case .copyPass:
                UIPasteboard.general.string = self.viewModel.selectedSite?.password
                break
            case .copyUsername:
                UIPasteboard.general.string = self.viewModel.selectedSite?.username
                break
            default:
                self.delegate?.didDismiss(self, with: self.viewModel.actions[index], for: self.viewModel.selectedSite)
            }
        }
        
    }
    
    func didClickOverlay() {
        siteActionsViewController.dismiss(animated: true, completion: {
            self.delegate?.didDismiss(self, with: nil, for: self.viewModel.selectedSite)
        })
    }
    
}
