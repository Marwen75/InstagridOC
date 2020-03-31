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
    
    @IBOutlet weak var lowerLeftSquarePlusImage: UIImageView!
    @IBOutlet weak var upperLeftSquarePlusImage: UIImageView!
    @IBOutlet weak var upperRightSquarePlusImage: UIImageView!
    @IBOutlet weak var lowerRightSquarePlusImage: UIImageView!
    @IBOutlet weak var upperRectanglePlusImage: UIImageView!
    @IBOutlet weak var lowerRectanglePlusImage: UIImageView!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var upperRectangleButton: UIButton!
    @IBOutlet weak var lowerRectangleButton: UIButton!
    @IBOutlet weak var upperTwoSquareView: UIStackView!
    @IBOutlet weak var upperLeftSquareButton: UIButton!
    @IBOutlet weak var upperRightSquareButton: UIButton!
    @IBOutlet weak var lowerTwoSquareView: UIStackView!
    @IBOutlet weak var lowerLeftSquareButton: UIButton!
    @IBOutlet weak var lowerRightSquareButton: UIButton!
    
    @IBAction func didTapUpperLeftSquareButton(_ sender: UIButton) {
        selectedView = upperLeftSquarePlusImage
        oneSquareViewButtonTapped()
    }
    
    @IBAction func didTapUpperRightSquareButton(_ sender: UIButton) {
        selectedView = upperRightSquarePlusImage
        oneSquareViewButtonTapped()
    }
    
    @IBAction func didTapLowerLeftSquareButton(_ sender: UIButton) {
        selectedView = lowerLeftSquarePlusImage
        oneSquareViewButtonTapped()
    }
    
    @IBAction func didTapLowerRightSquareButton(_ sender: UIButton) {
        selectedView = lowerRightSquarePlusImage
        oneSquareViewButtonTapped()
    }
    
    @IBAction func didTapUpperRectangleButton(_ sender: UIButton) {
        selectedView = upperRectanglePlusImage
        oneSquareViewButtonTapped()
    }
    
    @IBAction func didTapLowerRectangleButton(_ sender: UIButton) {
        selectedView = lowerRectanglePlusImage
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
            
            makeTheImagesAppear(showThose: [lowerRectanglePlusImage, upperRightSquarePlusImage, upperLeftSquarePlusImage], notThose: [lowerRightSquarePlusImage, lowerLeftSquarePlusImage, upperRectanglePlusImage])
            
            lowerRectangleButton.isHidden = false
            upperTwoSquareView.isHidden = false
            lowerTwoSquareView.isHidden = true
            upperRectangleButton.isHidden = true
            
        case .fullSquares:
            
            makeTheImagesAppear(showThose: [upperLeftSquarePlusImage, upperRightSquarePlusImage, lowerLeftSquarePlusImage, lowerRightSquarePlusImage], notThose: [upperRectanglePlusImage, lowerRectanglePlusImage])
            
            lowerRectangleButton.isHidden = true
            upperTwoSquareView.isHidden = false
            lowerTwoSquareView.isHidden = false
            upperRectangleButton.isHidden = true
            
        case .rectangleUp:
            
            makeTheImagesAppear(showThose: [upperRectanglePlusImage, lowerRightSquarePlusImage, lowerLeftSquarePlusImage], notThose: [lowerRectanglePlusImage, upperRightSquarePlusImage, upperLeftSquarePlusImage])
            
            lowerRectangleButton.isHidden = true
            upperTwoSquareView.isHidden = true
            lowerTwoSquareView.isHidden = false
            upperRectangleButton.isHidden = false
        }
    }
    
    private func makeTheImagesAppear(showThose: [UIImageView], notThose: [UIImageView]) {
        
        for images in showThose {
            images.isHidden = false
        }
        for images in notThose {
            images.isHidden = true
        }
    }
}
