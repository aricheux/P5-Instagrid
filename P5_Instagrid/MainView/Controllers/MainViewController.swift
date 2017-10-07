//
//  ViewController.swift
//  P5_Instagrid
//
//  Created by RICHEUX Antoine on 06/10/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import UIKit
import Photos

class MainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var photoContainer: PhotoContainerView!
    @IBOutlet var dispositionSelected: [UIImageView]!
    @IBOutlet var plusButton: [UIButton]!
    
    var dispositionIndex = 0
    var buttonTag = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dispositionIndex = 2
        dispositionSelected[dispositionIndex].isHidden = false
        photoContainer.createDisposition(disposition: dispositionIndex)
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            self.photoContainer.resizeView(orientation: UIApplication.shared.statusBarOrientation, screenBounds: UIScreen.main.bounds)
            
        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            self.photoContainer.createDisposition(disposition: self.dispositionIndex)
            
        })
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    // Choice a photo from iphone
    @IBAction func selectPhoto(_ sender: Any) {
        guard let button = sender as? UIButton else {
            return
        }
        buttonTag = button.tag
    }
    
    // Choice the photo's disposition
    @IBAction func selectDisposition(_ sender: Any) {
        guard let button = sender as? UIButton else {
            return
        }
        
        for dispo in dispositionSelected {
            dispo.isHidden = true
        }
        
        dispositionIndex = button.tag
        dispositionSelected[button.tag].isHidden = false
        photoContainer.createDisposition(disposition: button.tag)
        
    }
    
}

