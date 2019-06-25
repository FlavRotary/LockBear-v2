//
//  ActivityDataExtension.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 25/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

extension ActivityData {
    
    static let shared = ActivityData(size: CGSize(width: 100,height: 100),
                                     message: "Loading...",
                                     messageFont: UIFont.boldSystemFont(ofSize: 18.0),
                                     messageSpacing: nil,
                                     type: .circleStrokeSpin,
                                     color: UIColor(red: 51.0/255.0, green: 214.0/255.0, blue: 193.0/255.0, alpha: 1.0),
                                     padding: 10,
                                     displayTimeThreshold: nil,
                                     minimumDisplayTime: nil,
                                     backgroundColor: UIColor.clear,
                                     textColor: UIColor(red: 51.0/255.0, green: 214.0/255.0, blue: 193.0/255.0, alpha: 1.0))
    
}
