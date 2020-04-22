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
        loadViewFromNib(name: "AddPhotoView")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib(name: "AddPhotoView")
    }
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var photoView: UIImageView!
    
    var addPhotoButtonTapped: ((UIImageView) -> Void)? = nil
    
    @IBAction func buttonTapped(_ sender: Any) {
        addPhotoButtonTapped?(photoView)
    }
    
}
