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
    
    @IBOutlet var swipeGestureRecognizer: UISwipeGestureRecognizer!
    
    
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
    
    @IBAction func swipeGestureRecognizer(_ sender: UISwipeGestureRecognizer) {
        assignDirectionToTheSwipe(gesture: sender)
        setAnimationForLeftAndUpSwipes()
    }
    
    private func setAnimationForLeftAndUpSwipes() {
        if swipeGestureRecognizer.direction == .up {
            squareViewSwipeAnimation(duration: 0.3, x: 0, y: -view.frame.height, ifNotCancelled: openActivityController)
        } else if swipeGestureRecognizer.direction == .left {
            squareViewSwipeAnimation(duration: 0.3, x: -view.frame.height, y: 0, ifNotCancelled: openActivityController)
        }
    }
    
    private func squareViewSwipeAnimation(duration: Double, x: CGFloat, y: CGFloat, ifNotCancelled: @escaping () -> Void) {
        UIView.animate(withDuration: duration, animations: {
            self.squareView.transform = CGAffineTransform(translationX: x, y: y)
        }, completion:  { (success) in
            if success {
                ifNotCancelled()
            }
        })
    }
    
    private func reverseSquareViewSwipeAnimation() {
        UIView.animate(withDuration: 0.3, animations: {
            self.squareView.transform = .identity
        })
    }
    
    private func assignDirectionToTheSwipe(gesture: UISwipeGestureRecognizer) {
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            gesture.direction = .left
        } else {
            gesture.direction = .up
        }
    }
    
    // MARK:- Activity Controller
    
    private func openActivityController() {
        let userImageToShare = [UIImage.init(view: squareView)]
        let activityController = UIActivityViewController(activityItems: userImageToShare as [Any], applicationActivities: nil)
            present(activityController, animated: true)
        activityController.completionWithItemsHandler = { activiy, completed, items, Error in
            self.reverseSquareViewSwipeAnimation()
        }
    }
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //squareView.gridDisposition = .rectangleDown
        let name = Notification.Name(rawValue: "ButtonTapped")
        NotificationCenter.default.addObserver(self, selector: #selector(openUserLibrary),
                                               name: name, object: nil)
        image.delegate = self
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
        if let pickedImage = info[.originalImage] as? UIImage {
            squareView.buttonAndImageView.photoView.image = pickedImage
            dismiss(animated: true, completion: nil)
        }
    }
}

extension UIImage{
    convenience init(view: UIView) {

    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
    view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    self.init(cgImage: (image?.cgImage)!)

  }
}




