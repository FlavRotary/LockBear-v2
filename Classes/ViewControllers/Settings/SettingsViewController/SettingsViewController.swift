//
//  SettingsViewController.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 17/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController {
    
    weak var commandHandler: SettingsCommandHandlerProtocol?
    
    required init?(with commandHandler: SettingsCommandHandlerProtocol?) {
        super.init(nibName: String(describing: SettingsViewController.self), bundle: nil)
        self.title = "Settings"
        self.commandHandler = commandHandler
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
