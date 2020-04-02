//
//  ViewController.swift
//  InstagridOC
//
//  Created by Marwen Haouacine on 18/03/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var squareView: SquareView!
    @IBOutlet weak var firstLayoutButton: UIButton!
    @IBOutlet weak var secondLayoutButton: UIButton!
    @IBOutlet weak var thirdLayoutButton: UIButton!
    @IBOutlet weak var firstGridSelectedImage: UIImageView!
    @IBOutlet weak var secondGridSelectedImage: UIImageView!
    @IBOutlet weak var thirdGridSelectedImage: UIImageView!
    let image = UIImagePickerController()
    
    // MARK: - Actions
    
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
    
    
    // MARK: - Swipe Gesture Recognizer Settings
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        squareView.gridDisposition = .rectangleDown
        let name = Notification.Name(rawValue: "ButtonTapped")
        NotificationCenter.default.addObserver(self, selector: #selector(openUserLibrary),
                                               name: name, object: nil)
        image.delegate = self
        
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeSquareView(_:)))
        squareView.addGestureRecognizer(swipeGestureRecognizer)
    }
    
    @objc func swipeSquareView(_ sender: UISwipeGestureRecognizer) {
        switch sender.state {
        case .began, .changed:
            transformSquareViewWith(gesture: sender)
        case .ended, .cancelled:
            print("cancelled")
        default:
            break
        }
    }
    
    private func transformSquareViewWith(gesture: UISwipeGestureRecognizer) {
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            gesture.direction = .left
            let viewPosition = CGPoint(x: squareView.frame.origin.x - 50.0, y: squareView.frame.origin.y)
            squareView.frame = CGRect(x: viewPosition.x, y: viewPosition.y, width: squareView.frame.size.width, height: squareView.frame.size.height)
        } else {
            gesture.direction = .up
            let viewPosition = CGPoint(x: squareView.frame.origin.x, y: squareView.frame.origin.y)
            squareView.frame = CGRect(x: viewPosition.x, y: viewPosition.y + 50.0, width: squareView.frame.size.width, height: squareView.frame.size.height)
    }
    }
}


// MARK: - Extension

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @objc func openUserLibrary() {
        if  UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            image.allowsEditing = false
            image.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(image, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[.originalImage] as? UIImage else { return }
        squareView.buttonAndImageView.plusView.image = pickedImage
        dismiss(animated: true, completion: nil)
    }
}




