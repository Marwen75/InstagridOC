//
//  Viewcontroller+OpenUserLibrary.swift
//  InstagridOC
//
//  Created by Marwen Haouacine on 10/04/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import UIKit

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openUserLibrary() {
        if   UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
   
    func imagePickerController(_ picker:UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let imageToChange = imageToChange else {return}
        guard let pickedImage = info[.originalImage] as? UIImage else {return}
        imageToChange.image = pickedImage
        dismiss(animated: true, completion: nil)
    }
}

