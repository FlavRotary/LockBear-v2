//
//  ToSViewController.swift
//  Lock Bear
//
//  Created by Flavian Rotaru on 22/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import UIKit

class ToSViewController: BaseWebViewController {
    
    var viewModel: TosViewModelProtocol?
    
    required init(with viewModel: TosViewModelProtocol?) {
        super.init(nibName: String(describing: BaseWebViewController.self), bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let viewModel = self.viewModel {
            
            let req = URLRequest(url: viewModel.tosUrl)
            webView.load(req)
        }
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
