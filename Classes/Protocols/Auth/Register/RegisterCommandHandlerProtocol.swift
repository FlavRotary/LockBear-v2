//
//  RegisterCommandHandlerProtocol.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 20/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation

protocol RegisterCommandHandlerProtocol: class {
 
    var viewModel: AuthViewModelProtocol? {get}
    
    func register(with password: String!)
    
}
