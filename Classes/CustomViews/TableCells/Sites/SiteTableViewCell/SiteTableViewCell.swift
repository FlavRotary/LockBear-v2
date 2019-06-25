//
//  SiteTableViewCell.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 17/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import UIKit

class SiteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var siteIcon: UIImageView!
    @IBOutlet weak var siteName: UILabel!
    @IBOutlet weak var siteURL: UILabel!
    @IBOutlet weak var siteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(for site: Site, _ buttonImage: UIImage){
        self.siteIcon.image = site.icon
        self.siteName.text = site.name
        self.siteURL.text = site.url
        self.siteButton.imageView?.image = buttonImage
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
