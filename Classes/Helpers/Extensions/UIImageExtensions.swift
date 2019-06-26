//
//  UIImageExtensions.swift
//  Lock Bear
//
//  Created by Teodor Rotaru on 17/06/2019.
//  Copyright © 2019 Flavian Rotaru. All rights reserved.
//

import Foundation
import UIKit

extension UIImage{
    func resize (width: CGFloat, height: CGFloat)-> UIImage{
        
        var scaledImageRect:CGRect = .zero;
        
        let aspectWidth: CGFloat = width / self.size.width;
        let aspectHeight: CGFloat = height / self.size.height;
        let aspectRatio: CGFloat = min( aspectWidth, aspectHeight );
        
        scaledImageRect.size.width = self.size.width * aspectRatio;
        scaledImageRect.size.height = self.size.height * aspectRatio;
        scaledImageRect.origin.x = (width - scaledImageRect.size.width) / 2.0;
        scaledImageRect.origin.y = (height - scaledImageRect.size.height) / 2.0;
        
        UIGraphicsBeginImageContextWithOptions( CGSize(width: width, height: height), false, 0 );
        self.draw(in: scaledImageRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        return newImage
    }
}
