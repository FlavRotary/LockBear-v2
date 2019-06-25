//
//  SiteCategorySectionHeaderView.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 17/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import UIKit

class SiteCategorySectionHeaderView: UIView {
    
    
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categorySiteCount: UILabel!
    @IBOutlet weak var categoryIcon: UIImageView!
    @IBOutlet weak var backgroudImage: UIImageView!
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func configure(with category: SiteCategory, _ bkgImage: UIImage?) {
        
        self.categoryName.text = category.name
        self.categoryIcon.image = category.icon
        self.categorySiteCount.text = "\(category.sites?.count ?? 0) sites"
        self.backgroudImage.image = bkgImage
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
}
