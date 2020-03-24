//
//  SelectGridView.swift
//  InstagridOC
//
//  Created by Marwen Haouacine on 20/03/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import UIKit

class SelectGridView: UIView {

    @IBOutlet var layoutImages: [UIImageView]!
    @IBOutlet var layoutButtons: [UIButton]!
    @IBOutlet var selectedImages: [UIImageView]!
    
    enum Selection {
        
        case selected, normal
    }
    
    var selection: Selection = .normal {
        didSet {
            setSelection(selection)
        }
    }
    
    private func setSelection(_ selection: Selection) {
        switch selection {
        case .normal:
            for images in selectedImages {
                images.isHidden = true
            }
        case .selected:
            for images in selectedImages {
                images.isHidden = false
            }
        }
    }
    
    
    
    

}
