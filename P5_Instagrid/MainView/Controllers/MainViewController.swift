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
    @IBOutlet var dispositionSelected: [UIImageView]!
    // a label
    @IBOutlet weak var swipeLabel: UILabel!
    // current diposition of the photomontage
    var dispositionIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dispositionIndex = 2
        dispositionSelected[dispositionIndex].isHidden = false
        photoContainer.createDisposition(disposition: dispositionIndex)

        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    @objc func rotated() {
        if UIDevice.current.orientation.isLandscape {
            swipeLabel.text = "Swipe left to share"
        } else {
            swipeLabel.text = "Swipe up to share"
        }
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
        
        for dispositionSelected in dispositionSelected {
            dispositionSelected.isHidden = true
        }
        
        dispositionSelected[button.tag].isHidden = false
        photoContainer.createDisposition(disposition: button.tag)
    }
    
    @IBAction func swipeUpDetected(_ sender: UISwipeGestureRecognizer) {
        if UIApplication.shared.statusBarOrientation == .portrait {
            animateView(sender.direction)
        }
    }
    
    @IBAction func swipeLeftDetected(_ sender: UISwipeGestureRecognizer) {
        if UIApplication.shared.statusBarOrientation != .portrait {
            animateView(sender.direction)
        }
    }
    
    private func animateView(_ direction: UISwipeGestureRecognizerDirection) {
        let screenHeight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
        var translationTransform: CGAffineTransform
        
        if direction == .up {
            translationTransform = CGAffineTransform(translationX: 0, y: -screenHeight)
        } else {
            translationTransform = CGAffineTransform(translationX: -screenWidth, y: 0)
        }
        
        UIView.animate(withDuration: 1.0, animations: {
            self.photoContainer.transform = translationTransform
        }, completion: { (success) in
            if success {
                self.sharePhoto()
            }
        })
    }
    
    private func sharePhoto() {
        // set up activity view controller
        if let imageWithView = photoContainer.imageWithView() {
            let imageToShare = [imageWithView]
            let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            activityViewController.completionWithItemsHandler = { (activity, success, items, error) in
                self.photoContainer.transform = .identity
            }
            
            // exclude some activity types from the list (optional)
            activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
            
            // present the view controller
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
}

