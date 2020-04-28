//
//  ButtonAndImageView.swift
//  InstagridOC
//
//  Created by Marwen Haouacine on 01/04/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import UIKit
@IBDesignable
class AddPhotoView: NibView {

    // MARK: - Outlets
    @IBOutlet weak var plusView: UIImageView!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var photoView: UIImageView!
    var addPhotoButtonTapped: ((UIImageView) -> Void)? = nil
    
    // MARK: - Actions
    @IBAction func buttonTapped(_ sender: Any) {
        addPhotoButtonTapped?(photoView)
    }
}
