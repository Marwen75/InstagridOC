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
    
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var upperTwoSquares: UIStackView!
    @IBOutlet weak var lowerTwoSquaresView: UIStackView!
    @IBOutlet var customClassAllViews: [ButtonAndImageView]!
    var buttonAndImageView = ButtonAndImageView()
    
    // rectBas 0 / rectHaut 1 / carréHautgauche 2 / carréHautdr 3 / carrébasgauche 4 / carrébasdr 5
    
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
            
            upperTwoSquares.isHidden = false
            lowerTwoSquaresView.isHidden = true
            customClassAllViews[0].isHidden = false
            customClassAllViews[1].isHidden = true
            
        case .fullSquares:
            
            upperTwoSquares.isHidden = false
            lowerTwoSquaresView.isHidden = false
            customClassAllViews[0].isHidden = true
            customClassAllViews[1].isHidden = true
            
        case .rectangleUp:
            
            upperTwoSquares.isHidden = true
            lowerTwoSquaresView.isHidden = false
            customClassAllViews[0].isHidden = true
            customClassAllViews[1].isHidden = false
        }
    }
}
