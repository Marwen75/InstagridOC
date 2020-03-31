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
    
    var selectedView: UIImageView? = nil
    var selectedButton: UIButton? = nil
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var upperTwoSquareView: UIStackView!
    
    @IBOutlet weak var lowerTwoSquareView: UIStackView!
    
    @IBOutlet weak var uperrLeftSquareImage: UIImageView!
    
    @IBOutlet weak var upperRightSquareImage: UIImageView!
    
    @IBOutlet weak var lowerLeftSquareImage: UIImageView!
    
    @IBOutlet weak var lowerRightSquareImage: UIImageView!
    
    @IBOutlet weak var upperRectacngleImage: UIImageView!
    
    @IBOutlet weak var lowerRectangleImage: UIImageView!
    
    @IBOutlet weak var upperRectangleButton: UIButton!
    
    @IBOutlet weak var lowerRectangleButton: UIButton!
    
    @IBOutlet weak var lowerLeftSquareButton: UIButton!
    
    @IBOutlet weak var lowerRightSquareButton: UIButton!
    
    @IBOutlet weak var upperRightSquareButton: UIButton!
    
    @IBOutlet weak var upperLeftSquareButton: UIButton!
    
    
    @IBAction func didTapUpperLeftSquareButton(_ sender: UIButton) {
        selectedView = uperrLeftSquareImage
        selectedButton = upperLeftSquareButton
        oneSquareViewButtonTapped()
    }
    
    @IBAction func didTapUpperRightSquareButton(_ sender: UIButton) {
        selectedView = upperRightSquareImage
        selectedButton = upperRightSquareButton
        oneSquareViewButtonTapped()
    }
    
    @IBAction func didTapLowerLeftSquareButton(_ sender: UIButton) {
        selectedView = lowerLeftSquareImage
        selectedButton = lowerLeftSquareButton
        oneSquareViewButtonTapped()
    }
    
    @IBAction func didTapLowerRightSquareButton(_ sender: UIButton) {
        selectedView = lowerRightSquareImage
        selectedButton = lowerRightSquareButton
        oneSquareViewButtonTapped()
    }
    
    @IBAction func didTapUpperRectangleButton(_ sender: UIButton) {
        selectedView = upperRectacngleImage
        selectedButton = upperRectangleButton
        oneSquareViewButtonTapped()
    }
    
    @IBAction func didTapLowerRectangleButton(_ sender: UIButton) {
        selectedView = lowerRectangleImage
        selectedButton = lowerRectangleButton
        oneSquareViewButtonTapped()
    }
    
    private func oneSquareViewButtonTapped() {
        let name = Notification.Name(rawValue: "ButtonTapped")
        let notification = Notification(name: name)
        NotificationCenter.default.post(notification)
    }
    
    
    
    
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
            
            makeButtonsAppear(showThose: [lowerRectangleButton, upperLeftSquareButton, upperRightSquareButton], notThose: [upperRectangleButton, lowerLeftSquareButton, lowerRightSquareButton])
            lowerRectangleImage.isHidden = false
            upperTwoSquareView.isHidden = false
            lowerTwoSquareView.isHidden = true
            upperRectacngleImage.isHidden = true
            
        case .fullSquares:
            
            makeButtonsAppear(showThose: [lowerLeftSquareButton, upperRightSquareButton, lowerRightSquareButton, upperLeftSquareButton], notThose: [upperRectangleButton, lowerRectangleButton])
            lowerRectangleImage.isHidden = true
            upperTwoSquareView.isHidden = false
            lowerTwoSquareView.isHidden = false
            upperRectacngleImage.isHidden = true
            
        case .rectangleUp:
            
            makeButtonsAppear(showThose: [upperRectangleButton, lowerLeftSquareButton, lowerRightSquareButton], notThose: [lowerRectangleButton, upperRightSquareButton, upperLeftSquareButton])
            lowerRectangleImage.isHidden = true
            upperTwoSquareView.isHidden = true
            lowerTwoSquareView.isHidden = false
            upperRectacngleImage.isHidden = false
        }
    }
    
    private func makeButtonsAppear(showThose: [UIButton], notThose: [UIButton]) {
        
        
        for button in showThose {
            button.isHidden = false
        }
        for button in notThose {
            button.isHidden = true
        }
    }
}
