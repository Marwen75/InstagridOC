//
//  LayoutChoiceView.swift
//  InstagridOC
//
//  Created by Marwen Haouacine on 08/04/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import UIKit
@IBDesignable
class LayoutChoiceView: UIView {

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
            let nib = UINib(nibName: "LayoutChoiceView", bundle: bundle)
            let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(view)
        }
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var layoutButton: UIButton!
    
    @IBOutlet weak var seletedImage: UIImageView!
  
    var didTap: (() -> Void)? = nil


    
    @IBAction func layoutButtonTapped(_ sender: UIButton) {
        didTap?()
    }
    
    
    
    
    
    
    
    
}
