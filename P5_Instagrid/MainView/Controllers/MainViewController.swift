//
//  ViewController.swift
//  P5_Instagrid
//
//  Created by RICHEUX Antoine on 06/10/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import UIKit
import Photos

// Extension to show the image picker in the good orientation
extension UIImagePickerController
{
    override open var shouldAutorotate: Bool {
        return true
    }
    override open var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .all
    }
}

// Main view handling
class MainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // a view that contains the 4 buttons to add photos
    @IBOutlet weak var photoContainer: PhotoContainerView!
    // a collection connexion for the four image "disposition selected"
    @IBOutlet var dispositionSelected: [UIImageView]!
    // a label to explain how you can share the image
    @IBOutlet weak var swipeLabel: UILabel!
    // current diposition of the photomontage
    var dispositionIndex = 0
    
    // Set the standard disposition when the view is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dispositionIndex = 2
        dispositionSelected[dispositionIndex].isHidden = false
        photoContainer.createDisposition(disposition: dispositionIndex)

        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    /* Check if the device's orientation has changed
    According to the current orientation change the label text and reload the current disposition */
    @objc func rotated() {
        if UIDevice.current.orientation.isLandscape {
            swipeLabel.text = "Swipe left to share"
        } else {
            swipeLabel.text = "Swipe up to share"
        }
        photoContainer.createDisposition(disposition: dispositionIndex)
    }
    
    /* Check if the user has authorized access to the library
    Add image to the button from the user library */
    @IBAction func selectPhoto(_ sender: Any) {
        guard let button = sender as? UIButton else {
            return
        }
        
        let alert = UIAlertController(title : "Accès refusé", message: "Vous devez autoriser l'accès au photos dans les réglage de l'application", preferredStyle : UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        
        let libraryAuthorization = PHPhotoLibrary.authorizationStatus()
        if libraryAuthorization == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized  {
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
        } else if libraryAuthorization == .denied {
            self.present(alert, animated: true, completion: nil)
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
        
        dispositionIndex = button.tag
        dispositionSelected[dispositionIndex].isHidden = false
        photoContainer.createDisposition(disposition: dispositionIndex)
    }
    
    // Connexion to the storyboard to detect a swipe up
    @IBAction func swipeUpDetected(_ sender: UISwipeGestureRecognizer) {
        if UIApplication.shared.statusBarOrientation == .portrait {
            animateView(sender.direction)
        }
    }
    
    // Connexion to the storyboard to detect a swipe left
    @IBAction func swipeLeftDetected(_ sender: UISwipeGestureRecognizer) {
        if UIApplication.shared.statusBarOrientation != .portrait {
            animateView(sender.direction)
        }
    }
    
    // Move the photocontainer to the good position before share
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
    
    // Create the image from the photocontainer view and share it
    private func sharePhoto() {
        // set up activity view controller
        if let imageWithView = photoContainer.imageWithView() {
            let imageToShare = [imageWithView]
            let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            activityViewController.completionWithItemsHandler = { (activity, success, items, error) in
                self.photoContainer.transform = .identity
                self.photoContainer.removeImagetoButton()
            }
            
            activityViewController.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.postToFacebook,UIActivityType.postToTwitter]
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
}

