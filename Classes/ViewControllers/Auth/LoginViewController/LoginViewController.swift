//
//  LoginViewController.swift
//  Lock Bear
//
//  Created by Flavian Rotaru on 08/10/2018.
//  Copyright © 2018 Flavian Rotaru. All rights reserved.
//

import UIKit
import LocalAuthentication
import GBFloatingTextField

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var passTextField: GBTextField!
    @IBOutlet weak var showPassButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    weak var commandHandler: LoginCommandHandlerProtocol?
    
    required init?(with commandHandler: LoginCommandHandlerProtocol?) {
        super.init(nibName: String(describing: LoginViewController.self), bundle: nil)
        self.title = "Login"
        self.commandHandler = commandHandler
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        updateBiometryView()
        
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: nil) { (notification) in
            
            if let viewModel = self.commandHandler?.viewModel {
                
                if ((viewModel.settings?.useBioAuth ?? false) == true &&
                    (viewModel.getBiometryType() == .touchID || viewModel.getBiometryType() == .faceID)) {
                    
                    self.commandHandler?.tryBiometricLogin()
                }
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    func updateBiometryView() {
        var biometryAvailable = false
        if let viewModel = self.commandHandler?.viewModel {
            let biometry = viewModel.getBiometryType()
            
            if biometry == .faceID {
                biometryAvailable = true
                //update interface
                
            } else if biometry == .touchID {
                biometryAvailable = true
                //update interface
            }
        }
        
        if biometryAvailable == false {
            //update interface
        }
        
    }

    @IBAction func showPassAction(_ sender: Any) {
        passTextField.isSecureTextEntry = !passTextField.isSecureTextEntry
        showPassButton.isSelected = !showPassButton.isSelected
    }
    @IBAction func loginAction(_ sender: Any) {
        self.commandHandler?.didPressLogin(passTextField.text ?? "")
    }
}
