//
//  UpdateSiteViewController.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 17/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import UIKit
import GBFloatingTextField

class UpdateSiteViewController: BaseViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var scrollVIew: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var changeIconButton: UIButton!
    @IBOutlet weak var siteNameTextField: GBTextField!
    @IBOutlet weak var siteUrlTextField: GBTextField!
    @IBOutlet weak var SiteUsernameTextField: GBTextField!
    @IBOutlet weak var sitePasswordTextField: GBTextField!
    @IBOutlet weak var showPassButton: UIButton!
    @IBOutlet weak var siteCategoryTextField: GBTextField!
    
    var commandHandler: UpdateSiteCommandHandlerProtocol?
    weak var firstResponder: UITextField?
    var firstResponderLabelText: String?
    private var picker: UIPickerView?
    var selectedCategory: SiteCategory?

    required init(with commandHandler: UpdateSiteCommandHandlerProtocol?) {
        super.init(nibName: String(describing: UpdateSiteViewController.self), bundle: nil)
        self.title = "Update Site"
        self.commandHandler = commandHandler
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveAction))
        
        picker = UIPickerView()
        picker?.delegate = self
        siteCategoryTextField.inputView = picker
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        scrollVIew.contentSize = contentView.bounds.size
        
        if let selectedSite = commandHandler?.viewModel?.selectedSite {
            siteNameTextField.text = selectedSite.name
            siteUrlTextField.text = selectedSite.url
            SiteUsernameTextField.text = selectedSite.username
            sitePasswordTextField.text = selectedSite.password
            siteCategoryTextField.text = selectedSite.siteCategory?.name
            selectedCategory = selectedSite.siteCategory
            let size = CGSize(width: self.iconImgView.bounds.width * UIScreen.main.scale, height: self.iconImgView.bounds.height * UIScreen.main.scale)
            DispatchQueue.global().async {
                let resizedImage = selectedSite.icon.resize(width: size.width, height: size.height)
                DispatchQueue.main.async {
                    self.iconImgView.image = resizedImage
                }
            }
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { (notification) in
            
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                self.scrollVIew.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
                self.scrollVIew.scrollRectToVisible(self.firstResponder?.frame ?? CGRect.zero, animated: true)
            }
            
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { (notification) in
            if let animationDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) {
                UIView.animate(withDuration: TimeInterval(exactly: animationDuration) ?? 0, animations: {
                    self.scrollVIew.contentInset = UIEdgeInsets.zero
                })
            } else {
                self.scrollVIew.contentInset = UIEdgeInsets.zero
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - Button Actions
    
    @objc func saveAction() {
        
        if siteNameTextField.text?.count == 0 {
            UIAlertController.showErrorAlert("Please input site's name", self)
            return
        }
        if siteUrlTextField.text?.count == 0 {
            UIAlertController.showErrorAlert("Please input site's url ", self)
            return
        }
        if SiteUsernameTextField.text?.count == 0 {
            UIAlertController.showErrorAlert("Please input site's username", self)
            return
        }
        if sitePasswordTextField.text?.count == 0 {
            UIAlertController.showErrorAlert("Please input site's password", self)
            return
        }
        if siteCategoryTextField.text?.count == 0 {
            UIAlertController.showErrorAlert("Please input site's category", self)
            return
        }
        
        self.commandHandler?.didPressSave()
        
    }

    @IBAction func showPassAction(_ sender: Any) {
        sitePasswordTextField.isSecureTextEntry = !sitePasswordTextField.isSecureTextEntry
        showPassButton.isSelected = !showPassButton.isSelected
    }
    
    @IBAction func selectIconAction(_ sender: Any) {
        
    }
    
    //MARK: - UITextFieldDelegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        firstResponder = textField
        
        if textField == siteCategoryTextField {
            picker?.reloadAllComponents()
        }
        
        if let textField = textField as? GBTextField {
            firstResponderLabelText = textField.labelText
            textField.labelText = " "
        }
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        firstResponder = nil
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        if let textField = textField as? GBTextField {
            
            switch textField {
            case siteNameTextField:
                textField.leftImage = UIImage(named: "site_name_icon_selected")
                textField.leftImageSquare = UIImage(named: "site_name_icon_selected")
            case siteUrlTextField:
                textField.leftImage = UIImage(named: "site_url_icon_selected")
                textField.leftImageSquare = UIImage(named: "site_url_icon_selected")
            case SiteUsernameTextField:
                textField.leftImage = UIImage(named: "site_username_icon_selected")
                textField.leftImageSquare = UIImage(named: "site_username_icon_selected")
            case sitePasswordTextField:
                textField.leftImage = UIImage(named: "pass_lock_icon_selected")
                textField.leftImageSquare = UIImage(named: "pass_lock_icon_selected")
            case siteCategoryTextField:
                textField.leftImage = UIImage(named: "site_category_icon_selected")
                textField.leftImageSquare = UIImage(named: "site_category_icon_selected")
            
            default:
                break
            }
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let textField = textField as? GBTextField {
            switch textField {
            case siteNameTextField:
                textField.leftImage = UIImage(named: "site_name_icon_unselected")
                textField.leftImageSquare = UIImage(named: "site_name_icon_unselected")
            case siteUrlTextField:
                textField.leftImage = UIImage(named: "site_url_icon_unselected")
                textField.leftImageSquare = UIImage(named: "site_url_icon_unselected")
            case SiteUsernameTextField:
                textField.leftImage = UIImage(named: "site_username_icon_unselected")
                textField.leftImageSquare = UIImage(named: "site_username_icon_unselected")
            case sitePasswordTextField:
                textField.leftImage = UIImage(named: "pass_lock_icon_unselected")
                textField.leftImageSquare = UIImage(named: "pass_lock_icon_unselected")
            case siteCategoryTextField:
                textField.leftImage = UIImage(named: "site_category_icon_unselected")
                textField.leftImageSquare = UIImage(named: "site_category_icon_unselected")
            default:
                break
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let currentTag = textField.tag
        if let nextTf = self.view.viewWithTag(currentTag + 1) {
            textField.resignFirstResponder()
            nextTf.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let textField = textField as? GBTextField {
            textField.labelText = firstResponderLabelText ?? ""
        }
        
        return true
    }
    
    //MARK:-
    //MARK:- Picker Delegates
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let viewModel = self.commandHandler?.viewModel {
            return viewModel.categories.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.commandHandler?.viewModel?.categories[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedCategory = self.commandHandler?.viewModel?.categories[row]
        siteCategoryTextField.text = selectedCategory?.name
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
