//
//  SquareView.swift
//  InstagridOC
//
//  Created by Marwen Haouacine on 25/03/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import UIKit
@IBDesignable
class SquareView: UIView {
    
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
    
    // outlets
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var upperTwoSquares: UIStackView!
    @IBOutlet weak var lowerTwoSquaresView: UIStackView!
    @IBOutlet var customClassAllViews: [AddPhotoView]!
    
    
    //  carréHautgauche 0 / carréHautdr 1 / carrébasgauche 2 / carrébasdr 3
    
    enum GridDisposition {
        
        case rectangleDown, rectangleUp, fullSquares
    }
    
    var gridDisposition: GridDisposition = .rectangleDown  {
        
        didSet {
            setDisposition(gridDisposition)
        }
    }
    
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
