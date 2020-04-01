//
//  ButtonAndImageView.swift
//  InstagridOC
//
//  Created by Marwen Haouacine on 01/04/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import UIKit
@IBDesignable
class ButtonAndImageView: UIView {

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
          let nib = UINib(nibName: "ButtonAndImageView", bundle: bundle)
          let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
          view.frame = bounds
          view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
          addSubview(view)
      }
    
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var plusView: UIImageView!
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        plusView.isHidden = false
        sendNotification()
    }
    
    private func sendNotification() {
           let name = Notification.Name(rawValue: "ButtonTapped")
           let notification = Notification(name: name)
           NotificationCenter.default.post(notification)
    }
}
