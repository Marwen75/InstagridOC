//
//  UIImageExtension.swift
//  InstagridOC
//
//  Created by Marwen Haouacine on 10/04/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import UIKit

extension UIImage{
    convenience init(view: UIView) {
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage)!)
        
    }
}
