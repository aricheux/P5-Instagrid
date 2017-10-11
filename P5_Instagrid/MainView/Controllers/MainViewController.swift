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
    
    // a view that contains the 4 buttons to add photos
    @IBOutlet weak var photoContainer: PhotoContainerView!
    // a view that contains the 3 buttons to choice dispositions
    @IBOutlet weak var dispositionContainer: DispositionContainerView!
    // current diposition of the photomontage
    var dispositionIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.photoContainer.resizeView(orientation: UIApplication.shared.statusBarOrientation, screenBounds: UIScreen.main.bounds)
        self.dispositionContainer.resizeView(orientation: UIApplication.shared.statusBarOrientation, screenBounds: UIScreen.main.bounds)
        
        dispositionIndex = 2
        dispositionContainer.changeDisposition(disposition: dispositionIndex)
        photoContainer.createDisposition(disposition: dispositionIndex)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            self.photoContainer.resizeView(orientation: UIApplication.shared.statusBarOrientation, screenBounds: UIScreen.main.bounds)
            self.dispositionContainer.resizeView(orientation: UIApplication.shared.statusBarOrientation, screenBounds: UIScreen.main.bounds)
            
        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            self.photoContainer.createDisposition(disposition: self.dispositionIndex)
            
        })
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    // Added photos from the user library's
    @IBAction func selectPhoto(_ sender: Any) {
        guard let button = sender as? UIButton else {
            return
        }
        
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
            imagePicker.view.tag = button.tag
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // Add the image to the button when the action is done
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickerImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            photoContainer.addImageToButton(pickerImage, buttonTag: picker.view.tag)
            dismiss(animated: true)
        }
    }
    
    // Choice the photomontage disposition and change the frame of the view
    @IBAction func selectDisposition(_ sender: Any) {
        guard let button = sender as? UIButton else {
            return
        }
        
        dispositionIndex = button.tag
        dispositionContainer.changeDisposition(disposition: dispositionIndex)
        photoContainer.createDisposition(disposition: dispositionIndex)
    }
    
}

