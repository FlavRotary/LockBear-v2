//
//  SitesViewController.swift
//  Lock Bear
//
//  Created by Flavian Rotaru on 08/10/2018.
//  Copyright © 2018 Flavian Rotaru. All rights reserved.
//

import UIKit

class SitesViewController: BaseViewController {
    
    weak var commandHandler: SitesCommandHandlerProtocol?
    
    required init?(with commandHandler: SitesCommandHandlerProtocol?) {
        super.init(nibName: String(describing: SitesViewController.self), bundle: nil)
        self.title = "Sites"
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
