//
//  RegisterViewController.swift
//  Lock Bear
//
//  Created by Flavian Rotaru on 17/04/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import UIKit
import GBFloatingTextField

class RegisterViewController: BaseViewController, UITextFieldDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var passTextField: GBTextField!
    @IBOutlet weak var showPassButton: UIButton!
    @IBOutlet weak var confirmPassTextField: GBTextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var showConfirmPassButton: UIButton!
    
    //MARK: - Vars
    weak var commandHandler: RegisterCommandHandlerProtocol?
    weak var firstResponder: UITextField?
    
    //MARK: - UIVIewController Life Cycle
    
    required init(with commandHandler: RegisterCommandHandlerProtocol?) {
        super.init(nibName: String(describing: RegisterViewController.self), bundle: nil)
        self.title = "Register"
        self.commandHandler = commandHandler
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.scrollView.contentInsetAdjustmentBehavior = .never
        // Do any additional setup after loading the view.
        
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { (notification) in
            
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                self.scrollView.contentSize = CGSize(width: self.scrollView.bounds.width, height: self.registerButton.frame.origin.y + self.registerButton.frame.size.height + 20)
                self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
                self.scrollView.scrollRectToVisible(self.firstResponder?.frame ?? CGRect.zero, animated: true)
            }
            
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { (notification) in
            if let animationDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) {
                UIView.animate(withDuration: TimeInterval(exactly: animationDuration) ?? 0, animations: {
                    self.scrollView.contentInset = UIEdgeInsets.zero
                })
            } else {
                self.scrollView.contentInset = UIEdgeInsets.zero
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - UIButtonActions
    
    @IBAction func showPassAction(_ sender: Any) {
        passTextField.isSecureTextEntry = !passTextField.isSecureTextEntry
        showPassButton.isSelected = !showPassButton.isSelected
    }
    
    @IBAction func showConfirmPassAction(_ sender: Any) {
        confirmPassTextField.isSecureTextEntry = !confirmPassTextField.isSecureTextEntry
        showConfirmPassButton.isSelected = !showConfirmPassButton.isSelected
    }
    
    @IBAction func registerAction(_ sender: Any) {
        
        firstResponder?.resignFirstResponder()
        
        if passTextField.text?.count == 0 {
            
            UIAlertController.showErrorAlert("Please type in the password.", self)
            
            return
            
        }
        
        if confirmPassTextField.text?.count == 0 {
            
            UIAlertController.showErrorAlert("Please confirm the password.", self)
            
            return
        }
        
        if passTextField.text != confirmPassTextField.text {
            
            UIAlertController.showErrorAlert("Password do not match.", self)
            
            return
        }
        
        self.commandHandler?.register(with: passTextField.text!)
    }

    //MARK: - UITextFieldDelegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        firstResponder = textField
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        firstResponder = nil
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if let textField = textField as? GBTextField {
            textField.leftImage = UIImage(named: "pass_lock_icon_selected")
            textField.leftImageSquare = UIImage(named: "pass_lock_icon_selected")
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let textField = textField as? GBTextField {
            textField.leftImage = UIImage(named: "pass_lock_icon_unselected")
            textField.leftImageSquare = UIImage(named: "pass_lock_icon_unselected")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case passTextField:
            passTextField.resignFirstResponder()
            confirmPassTextField.becomeFirstResponder()
            break
        case confirmPassTextField:
            registerAction(registerButton ?? UIButton())
            
            break
        default:
            textField.resignFirstResponder()
        }
        
        return false
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
