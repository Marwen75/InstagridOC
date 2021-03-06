//
//  ViewController.swift
//  InstagridOC
//
//  Created by Marwen Haouacine on 18/03/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Outlets and Properties
    @IBOutlet weak var squareView: SquareView!
    @IBOutlet var allLayoutChoiceView: [LayoutChoiceView]!
    
    var imageToChange: UIImageView? = nil
    let imagePicker = UIImagePickerController()
    private var swipeGestureRecognizer: UISwipeGestureRecognizer?
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        squareView.gridDisposition = .rectangleDown
        assignBackgroundImages()
        squareView.customClassAllViews.forEach {
            $0.addPhotoButtonTapped = { [weak self] photoView in
                guard let strongSelf = self else { return }
                strongSelf.openUserLibrary()
                strongSelf.imageToChange = photoView
            }
        }
        
        self.sortLayoutChoiceViews()
        imagePicker.delegate = self
        swipeGestureRecognizer = UISwipeGestureRecognizer(target:
        self, action:#selector(setAnimationForLeftAndUpSwipes))
        guard let swipeGestureRecognizer = swipeGestureRecognizer else {return}
        squareView.addGestureRecognizer(swipeGestureRecognizer)
        assignDirectionToTheSwipe()
        NotificationCenter.default.addObserver(self, selector: #selector(assignDirectionToTheSwipe), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    // MARK: - LayoutChoiceView and AddPhotoView Settings
    // assigning a background image to our customized views
    private func assignBackgroundImages() {
        allLayoutChoiceView[1].seletedImage.isHidden = false
        allLayoutChoiceView.enumerated().forEach { (i, element) in
            element.layoutButton.setBackgroundImage(UIImage(named: "Layout \(i+1)"), for: .normal)
        }
    }
    
    // making the correct grid appear on the central squareview according to the selected Layout
    private func sortLayoutChoiceViews() {
        let parameters = [
            (selected: 0, other: 1, last: 2, disposition: SquareView.GridDisposition.rectangleUp),
            (selected: 1, other: 2, last: 0, disposition: SquareView.GridDisposition.rectangleDown),
            (selected: 2, other: 0, last: 1, disposition:
                SquareView.GridDisposition.fullSquares)
        ]
        allLayoutChoiceView.enumerated().forEach { [weak self] (i, element) in
            guard let strongSelf = self else { return }
            element.didTap = {
                strongSelf.showSelectedGrid(selected: strongSelf.allLayoutChoiceView[parameters[i].selected],
                    other: strongSelf.allLayoutChoiceView[parameters[i].other],
                    last: strongSelf.allLayoutChoiceView[parameters[i].last])
                strongSelf.squareView.gridDisposition = parameters[i].disposition
            }
        }
    }
    
    // show the selected image of the layoutview wich have been tapped on
    private func showSelectedGrid(selected: LayoutChoiceView, other: LayoutChoiceView, last: LayoutChoiceView) {
        selected.seletedImage.isHidden = false
        other.seletedImage.isHidden = true
        last.seletedImage.isHidden = true
    }
    
    // MARK: - Swipe Gesture Recognizer Settings
    @objc private func setAnimationForLeftAndUpSwipes() {
        if swipeGestureRecognizer?.direction == .up {
            squareViewSwipeAnimation(duration: 0.3, x: 0, y: -view.frame.height, succeed: openActivityController)
        } else {
            squareViewSwipeAnimation(duration: 0.3, x: -view.frame.width, y: 0, succeed: openActivityController)
        }
    }
    
    private func squareViewSwipeAnimation(duration: Double, x: CGFloat, y: CGFloat, succeed: @escaping () -> Void) {
        UIView.animate(withDuration: duration, animations: {
            self.squareView.transform = CGAffineTransform(translationX: x, y: y)
        }, completion: { (success) in
            if success {
                succeed()
            }
        })
    }
    
    // make the central grid returning at it's place with the inverse animation
    private func reverseSquareViewSwipeAnimation() {
        UIView.animate(withDuration: 0.3, animations: {
            self.squareView.transform = .identity
        })
    }
    
    @objc private func assignDirectionToTheSwipe() {
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            swipeGestureRecognizer?.direction = .left
        } else {
            swipeGestureRecognizer?.direction = .up
        }
    }
    
    // MARK: - Activity Controller
    private func openActivityController() {
        let userImageToShare = [UIImage.init(view: squareView)]
        let activityController =
            UIActivityViewController(activityItems:
                userImageToShare as [Any], applicationActivities: nil)
        present(activityController, animated: true)
        activityController.completionWithItemsHandler = { activiy, completed, items, error in
            self.reverseSquareViewSwipeAnimation()
        }
    }
}

extension UIImagePickerController {
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
}
