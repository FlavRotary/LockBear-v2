//
//  SiteCategorySectionHeaderView.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 17/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import UIKit

class SiteCategorySectionHeaderView: UIView {
    
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categorySiteCountLabel: UILabel!
    @IBOutlet weak var categoryIconView: UIImageView!
    @IBOutlet weak var backgroudImageView: UIImageView!
    
    func configure(with category: SiteCategory, _ bkgImage: UIImage?) {
        
        self.categoryNameLabel.text = category.name
        self.categoryIconView.image = category.icon
        self.categorySiteCountLabel.text = "\(category.sites.count) sites"
        self.backgroudImageView.image = bkgImage
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
}
