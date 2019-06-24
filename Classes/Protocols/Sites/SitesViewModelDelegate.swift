//
//  SitesViewModelDelegate.swift
//  LockBear
//
//  Created by Flavian Rotaru on 08/10/2018.
//  Copyright © 2018 Flavian Rotaru. All rights reserved.
//

import Foundation

protocol SitesViewModelDelegate {
    
    func sitesViewModelDidStartUpdating(_ sitesViewModel: SitesViewModelProtocol)
    func sitesViewModelDidEndUpdating(_ sitesViewModel: SitesViewModelProtocol)
    
}
