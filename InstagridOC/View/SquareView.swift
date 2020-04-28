//
//  SquareView.swift
//  InstagridOC
//
//  Created by Marwen Haouacine on 25/03/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import UIKit
@IBDesignable

class SquareView: NibView {
 
    // MARK: - Outlets
    @IBOutlet weak var upperTwoSquares: UIStackView!
    @IBOutlet weak var lowerTwoSquaresView: UIStackView!
    @IBOutlet var customClassAllViews: [AddPhotoView]!
    // Enumeration for the 3 possible layouts
    enum GridDisposition {
        case rectangleDown, rectangleUp, fullSquares
    }
    // Using poperties observation
    var gridDisposition: GridDisposition = .rectangleDown {
        didSet {
            setDisposition(gridDisposition)
        }
    }
    // changing the disposition of the central grid when a layout
    // is selected.
    private func setDisposition(_ gridDisposition: GridDisposition) {
        switch gridDisposition {
        case .rectangleDown:
            customClassAllViews[2].isHidden = true
            customClassAllViews[0].isHidden = false
        case .fullSquares:
            customClassAllViews.forEach { $0.isHidden = false }
        case .rectangleUp:
            customClassAllViews[0].isHidden = true
            customClassAllViews[2].isHidden = false
        }
    }
}
