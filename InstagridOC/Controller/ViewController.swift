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
    // swiftlint:disable redundant_optional_initialization
    @IBOutlet weak var squareView: SquareView!
    @IBOutlet var allLayoutChoiceView: [LayoutChoiceView]!
    var imageToChange: UIImageView? = nil
    let imagePicker = UIImagePickerController()
    var swipeGestureRecognizer: UISwipeGestureRecognizer?
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        squareView.gridDisposition = .rectangleDown
        assignBackgroundImages()
        squareView.customClassAllViews.forEach { $0.addPhotoButtonTapped = { photoView in
            self.openUserLibrary()
            self.imageToChange = photoView
            }
        }
        self.sortLayoutChoiceViews()
        imagePicker.delegate = self
        swipeGestureRecognizer = UISwipeGestureRecognizer(target: self,
        action: #selector(setAnimationForLeftAndUpSwipes))
        guard let swipeGestureRecognizer = swipeGestureRecognizer else {return}
        squareView.addGestureRecognizer(swipeGestureRecognizer)
        assignDirectionToTheSwipe()
        NotificationCenter.default.addObserver(self, selector: #selector(assignDirectionToTheSwipe),
            name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    // MARK: - LayoutChoiceView and AddPhotoView Settings
    private func assignBackgroundImages() {
        allLayoutChoiceView[1].seletedImage.isHidden = false
        for (idx, element) in allLayoutChoiceView.enumerated() {
            element.layoutButton.setBackgroundImage(UIImage(named: "Layout \(idx+1)"), for: .normal)
        }
    }
    private func sortLayoutChoiceViews() {
        let parameters = [
            (selected: 0, other: 1, last: 2, disposition: SquareView.GridDisposition.rectangleUp),
            (selected: 1, other: 2, last: 0, disposition: SquareView.GridDisposition.rectangleDown),
            (selected: 2, other: 0, last: 1, disposition:
                SquareView.GridDisposition.fullSquares)
        ]
        allLayoutChoiceView.enumerated().forEach { (idx, element) in
            element.didTap = {
                self.showSelectedGrid(selected: self.allLayoutChoiceView[parameters[idx].selected],
                    other: self.allLayoutChoiceView[parameters[idx].other],
                    last: self.allLayoutChoiceView[parameters[idx].last])
                self.squareView.gridDisposition = parameters[idx].disposition
            }
        }
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
    // swiftlint:disable identifier_name
    private func squareViewSwipeAnimation(duration: Double, x: CGFloat, y: CGFloat, succeed: @escaping () -> Void) {
        UIView.animate(withDuration: duration, animations: {
            self.squareView.transform = CGAffineTransform(translationX: x, y: y)
        }, completion: { (success) in
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
