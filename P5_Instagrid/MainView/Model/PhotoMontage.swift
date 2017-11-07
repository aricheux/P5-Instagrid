//
//  PhotoMontage.swift
//  P5_Instagrid
//
//  Created by RICHEUX Antoine on 31/10/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import Foundation
import UIKit

// Enumeration to define the size of the button
enum ButtonSize {
    case normal, long
}

struct ImageButton {
    var size: ButtonSize
    var hidden: Bool
}

class PhotoMontage {
    let imageNumber = 4
    var dispositionIndex: Int
    var imageButton = [ImageButton]()
    
    init(disposition: Int) {
        dispositionIndex = disposition
        
        for _ in 0...imageNumber-1 {
            imageButton.append(ImageButton.init(size: .normal, hidden: false))
        }
    }
    
    func updateDisposition(_ disposition: Int) {
        dispositionIndex = disposition
    }
    
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
    
    // Make an image with the disposition image to share it
    func imageWithView(view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return img
    }
}
