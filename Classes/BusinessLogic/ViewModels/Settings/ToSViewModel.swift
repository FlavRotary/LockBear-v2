//
//  ToSViewModel.swift
//  Lock Bear
//
//  Created by Flavian Rotaru on 22/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation

class ToSViewModel: TosViewModelProtocol {
    
    var tosUrl: URL
    
    required init() {
        
        let tosUrlString = Bundle.main.path(forResource: "tos", ofType: "html", inDirectory: "docs")
        tosUrl = URL(fileURLWithPath: tosUrlString ?? "")
    }
    
}
