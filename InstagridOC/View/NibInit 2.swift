//
//  NibInit.swift
//  InstagridOC
//
//  Created by Marwen Haouacine on 22/04/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import UIKit

class UIView {
    
    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         loadViewFromNib()
     }
     
     override init(frame: CGRect) {
         super.init(frame: frame)
         loadViewFromNib()
     }
     
     func loadViewFromNib() {
         let bundle = Bundle(for: type(of: self))
         let nib = UINib(nibName: "SquareView", bundle: bundle)
         let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
         view.frame = bounds
         view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
         addSubview(view)
     }
}
