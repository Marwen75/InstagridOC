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
    let image = UIImagePickerController()
    var swipeGestureRecognizer: UISwipeGestureRecognizer?
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        squareView.gridDisposition = .rectangleDown
        assignBackgroundImages()
        squareView.customClassAllViews.forEach { $0.addPhotoButtonTapped = { self.openUserLibrary()}}
        assignImagesToChange(firstView: self.squareView.customClassAllViews[0], secondView: self.squareView.customClassAllViews[1], thirdView: squareView.customClassAllViews[2], fourthView: squareView.customClassAllViews[3])
        self.sortLayoutChoiceView()
        image.delegate = self
        swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(setAnimationForLeftAndUpSwipes))
        guard let swipeGestureRecognizer = swipeGestureRecognizer else {return}
        squareView.addGestureRecognizer(swipeGestureRecognizer)
        assignDirectionToTheSwipe()
        NotificationCenter.default.addObserver(self, selector: #selector(assignDirectionToTheSwipe), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    // MARK: - LayoutChoiceView and AddPhotoView Settings
    
    private func assignBackgroundImages() {
        allLayoutChoiceView[1].seletedImage.isHidden = false
        allLayoutChoiceView[0].layoutButton.setBackgroundImage(UIImage(named: "Layout 1"), for: .normal)
        allLayoutChoiceView[1].layoutButton.setBackgroundImage(UIImage(named: "Layout 2"), for: .normal)
        allLayoutChoiceView[2].layoutButton.setBackgroundImage(UIImage(named: "Layout 3"), for: .normal)
    }
    
    private func assignImagesToChange(firstView: AddPhotoView, secondView: AddPhotoView, thirdView: AddPhotoView, fourthView: AddPhotoView) {
        firstView.setImageView = { self.imageToChange = firstView.photoView }
        secondView.setImageView = { self.imageToChange = secondView.photoView }
        thirdView.setImageView = { self.imageToChange = thirdView.photoView }
        fourthView.setImageView = { self.imageToChange = fourthView.photoView }
    }
    
    private func sortLayoutChoiceView() {
        allLayoutChoiceView[0].didTap = {self.showSelectedGrid(selected: self.allLayoutChoiceView[0], other: self.allLayoutChoiceView[1], last: self.allLayoutChoiceView[2])
            self.squareView.gridDisposition = .rectangleUp}
        allLayoutChoiceView[1].didTap = {self.showSelectedGrid(selected: self.allLayoutChoiceView[1], other: self.allLayoutChoiceView[2], last: self.allLayoutChoiceView[0])
            self.squareView.gridDisposition = .rectangleDown}
        allLayoutChoiceView[2].didTap = {self.showSelectedGrid(selected: self.allLayoutChoiceView[2], other: self.allLayoutChoiceView[0], last: self.allLayoutChoiceView[1])
            self.squareView.gridDisposition = .fullSquares}
    }
    
    
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
        }, completion:  { (success) in
            if success {
                succeed()
            }
        })
    }
    
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
    
    // MARK:- Activity Controller
    
    private func openActivityController() {
        let userImageToShare = [UIImage.init(view: squareView)]
        let activityController = UIActivityViewController(activityItems: userImageToShare as [Any], applicationActivities: nil)
        present(activityController, animated: true)
        activityController.completionWithItemsHandler = { activiy, completed, items, Error in
            self.reverseSquareViewSwipeAnimation()
        }
    }
}







