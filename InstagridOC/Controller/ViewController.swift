//
//  ViewController.swift
//  InstagridOC
//
//  Created by Marwen Haouacine on 18/03/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var squareView: SquareView!
    @IBOutlet weak var firstLayoutButton: UIButton!
    @IBOutlet weak var secondLayoutButton: UIButton!
    @IBOutlet weak var thirdLayoutButton: UIButton!
    @IBOutlet weak var firstGridSelectedImage: UIImageView!
    @IBOutlet weak var secondGridSelectedImage: UIImageView!
    @IBOutlet weak var thirdGridSelectedImage: UIImageView!
    let image = UIImagePickerController()
    
    @IBAction func didTapFirstLayoutButton() {
        
        didSelectOneGrid(selected: firstGridSelectedImage, other: secondGridSelectedImage, last: thirdGridSelectedImage)
        squareView.gridDisposition = .rectangleUp
    }
    
    @IBAction func didTapSecondLayoutButton() {
        
        didSelectOneGrid(selected: secondGridSelectedImage, other: firstGridSelectedImage, last: thirdGridSelectedImage)
        squareView.gridDisposition = .rectangleDown
    }
    
    @IBAction func didTapThirdLayoutButton() {
        
        didSelectOneGrid(selected: thirdGridSelectedImage, other: firstGridSelectedImage, last: secondGridSelectedImage)
        squareView.gridDisposition = .fullSquares
    }
    
    private func didSelectOneGrid(selected: UIImageView!, other: UIImageView!, last: UIImageView!) {
        selected.isHidden = false
        other.isHidden = true
        last.isHidden = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        squareView.gridDisposition = .rectangleDown
        let name = Notification.Name(rawValue: "ButtonTapped")
        NotificationCenter.default.addObserver(self, selector: #selector(openUserLibrary),
                                               name: name, object: nil)
        
        image.delegate = self
    }
}
    extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func openUserLibrary() {
        if  UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            image.allowsEditing = false
            image.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(image, animated: true, completion: nil)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            squareView.buttonAndImageView.plusView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
}




