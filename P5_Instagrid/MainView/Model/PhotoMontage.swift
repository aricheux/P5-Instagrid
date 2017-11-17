//
//  PhotoMontage.swift
//  P5_Instagrid
//
//  Created by RICHEUX Antoine on 31/10/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import Foundation
import UIKit

/// Enumeration to define the size of the button
enum ButtonSize {
    case normal, long
}

/// Structure to configure the image button
struct ImageButton {
    var size: ButtonSize
    var hidden: Bool
}

/// Class to handle the photo montage
class PhotoMontage {
    /// Number of image in the photo montage
    let imageNumber = 4
    
    // Actual disposition index of the photo montage
    var dispositionIndex: Int
    
    /// Array who contains all buttons image
    var imageButton = [ImageButton]()
    
    /// Initialize the disposition and create all buttons
    init(disposition: Int) {
        dispositionIndex = disposition
        
        for _ in 0...imageNumber-1 {
            imageButton.append(ImageButton.init(size: .normal, hidden: false))
        }
    }
    
    /// Change the actual disposition
    func updateDisposition(_ disposition: Int) {
        dispositionIndex = disposition
    }
    
    /// Configure all button according to the disposition
    /// - Returns: array of buttons configuration for the controller
    func refreshView() -> [ImageButton] {
        for i in 0...imageNumber-1 {
            imageButton[i].size = .normal
            imageButton[i].hidden = false
        }
        
        if dispositionIndex == 0 {
            imageButton[0].size = .long
            imageButton[1].hidden = true
        } else if dispositionIndex == 1 {
            imageButton[2].size = .long
            imageButton[3].hidden = true
        }
        
        return imageButton
    }
    
    /// Make an image with the photo montage view
    /// - Returns: an image of the photo montage to share it
    func imageWithView(view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return img
    }
}
