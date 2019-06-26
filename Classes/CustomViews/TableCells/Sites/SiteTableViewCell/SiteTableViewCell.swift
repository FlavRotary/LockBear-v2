//
//  SiteTableViewCell.swift
//  Lock Bear
//
//  Created by Flavian Rotaru on 17/04/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import UIKit

class SiteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var siteIconImageView: UIImageView!
    @IBOutlet weak var siteNameLabel: UILabel!
    @IBOutlet weak var siteDescLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(for site: Site) {
        self.siteIconImageView.image = site.icon
        self.siteNameLabel.text = site.name
        self.siteDescLabel.text = site.username
        let size = CGSize(width: self.siteIconImageView.bounds.width * UIScreen.main.scale, height: self.siteIconImageView.bounds.height * UIScreen.main.scale)
        DispatchQueue.global().async {
            let resizedImage = site.icon.resize(width: size.width, height: size.height)
            DispatchQueue.main.async {
                self.siteIconImageView.image = resizedImage
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
