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
    var catBackgrounds: [UIImage] = [UIImage()]
    var sqlManager: SQLManager?
    
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
    
    func addSite(_ site: Site) {
        
    }
    
    func editSite(_ site: Site) {
        
    }
    
    func deleteSite(_ site: Site) {
        
    }
    func getSitePass(_ site: Site) {
        
    }
    
}
