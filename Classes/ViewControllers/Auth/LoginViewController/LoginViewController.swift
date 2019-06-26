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

class LoginViewController: BaseViewController, UITextFieldDelegate {
    
    //MARK: - Outlets
    
    @IBOutlet weak var passTextField: GBTextField!
    @IBOutlet weak var showPassButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var biometricDescLabel: UILabel!
    @IBOutlet weak var useBiometricButton: UIButton!
    @IBOutlet weak var biometricNameLabel: UILabel!
    
    //MARK: - Vars
    weak var commandHandler: LoginCommandHandlerProtocol?
    
    //MARK: - UIVIewController Life Cycle
    
    required init?(with commandHandler: LoginCommandHandlerProtocol?) {
        super.init(nibName: String(describing: LoginViewController.self), bundle: nil)
        self.title = "Login"
        self.commandHandler = commandHandler
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        updateBiometryView()
        
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: nil) { (notification) in
            
            self.tryBiometricLogin()
            
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - Layout
    
    func updateBiometryView() {
        
        biometricDescLabel.text = ""
        useBiometricButton.setImage(nil, for: .normal)
        useBiometricButton.isEnabled = false
        biometricNameLabel.text = ""
        
        var biometryAvailable = false
        if let viewModel = self.commandHandler?.viewModel {
            let biometry = viewModel.getBiometryType()
            
            if biometry == .faceID {
                biometryAvailable = true
                biometricDescLabel.text = "Or use"
                useBiometricButton.setImage(UIImage(named: "face_id_logo"), for: .normal)
                useBiometricButton.isEnabled = true
                biometricNameLabel.text = "Face ID"
                
            } else if biometry == .touchID {
                biometryAvailable = true
                biometricDescLabel.text = "Or use"
                useBiometricButton.setImage(UIImage(named: "touch_id_logo"), for: .normal)
                useBiometricButton.isEnabled = true
                biometricNameLabel.text = "Touch ID"
            }
        }
        
        if biometryAvailable == false {
            //update interface
            biometricDescLabel.text = "Your device doesn’t have Touch ID or Face ID capability, so the bear recommends using vault password, or just upgrading to a newer device ^^"
            useBiometricButton.setImage(nil, for: .normal)
            useBiometricButton.isEnabled = false
            biometricNameLabel.text = ""
        }
        
    }
    
    func tryBiometricLogin() {
        
        if let viewModel = self.commandHandler?.viewModel {
            
            if ((viewModel.settings?.useBioAuth ?? false) == true &&
                (viewModel.getBiometryType() == .touchID || viewModel.getBiometryType() == .faceID)) {
                
                self.commandHandler?.tryBiometricLogin()
            }
        }
    }
    
    //MARK: - UIButtonActions

    @IBAction func showPassAction(_ sender: Any) {
        passTextField.isSecureTextEntry = !passTextField.isSecureTextEntry
        showPassButton.isSelected = !showPassButton.isSelected
    }
    @IBAction func loginAction(_ sender: Any) {
        passTextField.resignFirstResponder()
        
        if passTextField.text?.count == 0 {
            
            UIAlertController.showErrorAlert("Please type in the password.", self)
            
            return
            
        }
        
        self.commandHandler?.didPressLogin(passTextField.text ?? "")
    }
    @IBAction func biometricAuthAction(_ sender: Any) {
        self.commandHandler?.tryBiometricLogin()
    }
    
    //MARK: - UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == passTextField {
            passTextField.leftImage = UIImage(named: "pass_lock_icon_selected")
            passTextField.leftImageSquare = UIImage(named: "pass_lock_icon_selected")
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == passTextField {
            passTextField.leftImage = UIImage(named: "pass_lock_icon_unselected")
            passTextField.leftImageSquare = UIImage(named: "pass_lock_icon_unselected")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.loginAction(loginButton ?? UIButton())
        return false
    }
}
