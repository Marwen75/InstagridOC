//
//  UIViewExtension+NibInit.swift
//  InstagridOC
//
//  Created by Marwen Haouacine on 22/04/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import UIKit

extension UIView {
    
    func loadViewFromNib(name: String) {
           let bundle = Bundle(for: type(of: self))
           let nib = UINib(nibName: name, bundle: bundle)
           let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
           view.frame = bounds
           view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
           addSubview(view)
       }
}
