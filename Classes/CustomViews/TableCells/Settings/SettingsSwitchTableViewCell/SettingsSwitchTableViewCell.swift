//
//  SettingsSwitchTableViewCell.swift
//  Lock Bear
//
//  Created by Flavian Rotaru on 17/04/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import UIKit

protocol SettingsSwitchCellDelegate: class {
    func didSwitch(in cell: SettingsSwitchTableViewCell)
}

class SettingsSwitchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var `switch`: UISwitch!
    
    weak var delegate: SettingsSwitchCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func switchValueChanged(_ sender: Any) {
        self.delegate?.didSwitch(in: self)
    }
}
