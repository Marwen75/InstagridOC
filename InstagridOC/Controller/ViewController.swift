//
//  ViewController.swift
//  InstagridOC
//
//  Created by Marwen Haouacine on 18/03/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var selectGridView: SelectGridView!
    @IBOutlet weak var gridView: GridView!
    
    @IBAction func didSelectMiddleGrid() {
        
        middleGridSelected()
    }
    
    @IBAction func didSelectLeftGrid() {
        
        rightGridSelected()
    }
    
    
    @IBAction func didSelectRightGrid() {
        
        leftGridSelected()
    }
    
    private func middleGridSelected() {
        
        selectGridView.selectedImages[0].isHidden = false
        selectGridView.selectedImages[1].isHidden = true
        selectGridView.selectedImages[2].isHidden = true
        
    }
    
    private func leftGridSelected() {
        
        selectGridView.selectedImages[0].isHidden = true
        selectGridView.selectedImages[1].isHidden = false
        selectGridView.selectedImages[2].isHidden = true
    }
    
    private func rightGridSelected() {
        
        selectGridView.selectedImages[0].isHidden = false
        selectGridView.selectedImages[1].isHidden = true
        selectGridView.selectedImages[2].isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

