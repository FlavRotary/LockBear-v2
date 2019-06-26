//
//  InfoViewModel.swift
//  Lock Bear
//
//  Created by Flavian Rotaru on 22/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation

class InfoViewModel: InfoViewModelProtocol {
    var infoURL: URL
    
    required init() {
        let infoUrlString = Bundle.main.path(forResource: "info", ofType: "html", inDirectory: "docs")
        infoURL = URL(fileURLWithPath: infoUrlString ?? "")
    }
    
}
