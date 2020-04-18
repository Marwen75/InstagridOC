//
//  ButtonAndImageView.swift
//  InstagridOC
//
//  Created by Marwen Haouacine on 01/04/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import UIKit
@IBDesignable
class AddPhotoView: UIView {

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
          let nib = UINib(nibName: "AddPhotoView", bundle: bundle)
          let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
          view.frame = bounds
          view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
          addSubview(view)
      }
    
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var photoView: UIImageView!

    var addPhotoButtonTapped: (() -> Void)? = nil
    var setImageView: (() -> ())? = nil
    
    @IBAction func buttonTapped(_ sender: Any) {
        addPhotoButtonTapped?()
        setImageView?()
    }
    
}
