//
//  SettingsViewController.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 17/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, SettingsSwitchCellDelegate {
    
    @IBOutlet weak var tView: UITableView!
    
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
        
        tView.register(SettingsSimpleTableViewCell.nib, forCellReuseIdentifier: SettingsSimpleTableViewCell.cellReuseIdentifier)
        tView.register(SettingsSwitchTableViewCell.nib, forCellReuseIdentifier: SettingsSwitchTableViewCell.cellReuseIdentifier)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        commandHandler?.viewModel?.reloadIfNeeded()
    }
    
    //MARK: - UITableViewDataSource & Delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commandHandler?.viewModel?.settingTypes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let settingType = commandHandler?.viewModel?.settingTypes[indexPath.row] {
            
            switch settingType.editType {
                case .usingSwitch:
                    let cell : SettingsSwitchTableViewCell = tableView.dequeueReusableCell(withIdentifier: SettingsSwitchTableViewCell.cellReuseIdentifier)! as! SettingsSwitchTableViewCell
                    cell.delegate = self
                    cell.label.text = commandHandler?.viewModel?.getSettingName(for: indexPath.row)
                    cell.switch.isOn = true
                    cell.switch.isEnabled = true
                    switch settingType.settingSwitchStatus {
                    case .on:
                        cell.switch.isOn = true
                        break;
                    case .off:
                        cell.switch.isOn = false
                        break;
                    default:
                        cell.switch.isEnabled = false
                        break;
                    }
                    return cell
                default:
                    let cell: SettingsSimpleTableViewCell = tableView.dequeueReusableCell(withIdentifier: SettingsSimpleTableViewCell.cellReuseIdentifier)! as! SettingsSimpleTableViewCell
                    cell.label.text = commandHandler?.viewModel?.getSettingName(for:indexPath.row)
                    return cell
            }
            
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let settingType = commandHandler?.viewModel?.settingTypes[indexPath.row] {
            if settingType.editType == .normal {
                commandHandler?.didSelectSettingType(at: indexPath.row)
            }
        }
        
    }
    
    //MARK: - SettingsSwitchCellDelegate
    
    func didSwitch(in cell: SettingsSwitchTableViewCell) {
        
        if let indexPath = tView.indexPath(for: cell) {
            self.commandHandler?.didSwitch(at: indexPath.row)
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
