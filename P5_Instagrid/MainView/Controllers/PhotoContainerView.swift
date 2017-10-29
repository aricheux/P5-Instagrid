//
//  PhotoContainerView.swift
//  P5_Instagrid
//
//  Created by RICHEUX Antoine on 07/10/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import UIKit

// Photo container view handling
class PhotoContainerView: UIView {
    
    // Connexion to the storyboard for the four buttons
    @IBOutlet var plusButton: [PhotoButtonView]!
    
    // Resize all button to the original size and resize them according to the disposition choice
    public func createDisposition(disposition: Int) {
        
        for button in plusButton {
            button.isHidden = false
            button.setFrame(size: .normal, animated: false)
        }
        
        if disposition == 0 {
            plusButton[0].setFrame(size: .long, animated: true)
            plusButton[1].isHidden = true
        } else if disposition == 1 {
            plusButton[2].setFrame(size: .long, animated: true)
            plusButton[3].isHidden = true
        }
    }
    
    // Set the original image to the button according to the device's orientation
    public func removeImagetoButton() {
        for plusButton in plusButton {
            if UIApplication.shared.statusBarOrientation != .portrait {
                plusButton.setImage(#imageLiteral(resourceName: "plusGray"), for: .normal)
            } else {
                plusButton.setImage(#imageLiteral(resourceName: "plusBlue"), for: .normal)
            }
        }
    }
    
    // Set the user image to the button
    public func addImageToButton(_ image: UIImage, buttonTag: Int) {
        plusButton[buttonTag - 10].setImage(image, for: .normal)
        plusButton[buttonTag - 10].imageView?.contentMode = .scaleAspectFill
    }
    
    // Make an image with the disposition image to share it
    public func imageWithView() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}
