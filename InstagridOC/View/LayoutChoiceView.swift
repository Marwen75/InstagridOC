//
//  LayoutChoiceView.swift
//  InstagridOC
//
//  Created by Marwen Haouacine on 08/04/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import UIKit
@IBDesignable
class LayoutChoiceView: NibView {

    // MARK: - Outlets
    @IBOutlet weak var layoutButton: UIButton!
    @IBOutlet weak var seletedImage: UIImageView!
    var didTap: (() -> Void)? = nil
    // MARK: - Actions
    @IBAction func layoutButtonTapped(_ sender: UIButton) {
        didTap?()
    }
}
