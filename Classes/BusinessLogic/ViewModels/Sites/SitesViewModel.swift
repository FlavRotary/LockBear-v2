//
//  SitesViewModel.swift
//  Lock Bear
//
//  Created by Flavian Rotaru on 08/10/2018.
//  Copyright © 2018 Flavian Rotaru. All rights reserved.
//

import Foundation
import UIKit

class SitesViewModel: SitesViewModelProtocol {
   
    
    var delegate: SitesViewModelDelegate?
    var categories: [SiteCategory] = []
    var sqlManager: SQLManager?
    var selectedSite: Site?
    
    required init() {
        if sqlManager == nil {
            sqlManager = SQLManager()
        }
        updateData()
    }
    
    func fetchDataFromDB(with completion: (() -> Void)? = nil){
        
        DispatchQueue.global().async {
            if let sqlManager = self.sqlManager {
                self.categories = sqlManager.fetchData()
                print(self.categories)
                if let completion = completion{
                    completion()
                }
            }
        }
    }
    
    func updateData(){
        
        self.delegate?.sitesViewModelDidStartUpdating(self)
        fetchDataFromDB(){
            self.delegate?.sitesViewModelDidEndUpdating(self)
        }
    }
    
    func selectNewSite() {
        selectedSite = Site()
    }
    func selectForEditing(_ site: Site) {
        selectedSite = site
    }
    func deleteSite(_ site: Site, _ completion: @escaping ((Error?) -> Void)) {
        
        let error = NSError(domain: "com.lockbear", code: 0, userInfo: [NSLocalizedDescriptionKey:"Site not found."])
        
        if let sitesTable = sqlManager?.sitesTable {
            
            DispatchQueue.global().async {
                let success = self.sqlManager?.deleteIn(sitesTable, site)
                self.updateData()
                completion(success == false ? error : nil)
            }
            
        } else {
            completion(error)
        }
    }
    
    func saveSelectedSite(with completion: @escaping ((Error?) -> Void)) {
        
        let error = NSError(domain: "com.lockbear", code: 0, userInfo: [NSLocalizedDescriptionKey:"Site not found."])
        
        if let selectedSite = self.selectedSite, let sitesTable = sqlManager?.sitesTable {
            
            DispatchQueue.global().async {
                var success = false
                if selectedSite.id == nil {
                    success = self.sqlManager?.insertIn(sitesTable, selectedSite) ?? false
                    self.updateData()
                } else {
                    success = self.sqlManager?.updateIn(sitesTable, selectedSite) ?? false
                }
                completion(success == false ? error : nil)
            }
            
        } else {
            completion(error)
        }
    }
    
}
