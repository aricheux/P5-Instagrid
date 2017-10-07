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
        
        // Library authorization
        let libraryAuthorization = PHPhotoLibrary.authorizationStatus()
        if libraryAuthorization == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{
                    self.selectPhoto(sender)
                }
            })
        } else if libraryAuthorization == .authorized {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }

    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
 
        let pickerImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        plusButton[buttonTag-10].imageView?.contentMode = .scaleAspectFit
        plusButton[buttonTag-10].setImage(pickerImage , for: .normal)
        
        dismiss(animated: true)
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

