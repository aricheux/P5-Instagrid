//
//  PhotoContainerView.swift
//  P5_Instagrid
//
//  Created by RICHEUX Antoine on 07/10/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import UIKit

class PhotoContainerView: UIView {
    
    @IBOutlet var plusButton: [PhotoButtonView]!
    
    // Resize the button to the original size and resize according to the disposition choice
    public func createDisposition(disposition: Int) {
        plusButton[0].location = .topLeft
        plusButton[1].location = .topRight
        plusButton[2].location = .bottomLeft
        plusButton[3].location = .bottomRight
        
        for button in plusButton {
            button.isHidden = false
            button.initFrame(size: .normal)
        }
        
        if disposition == 0 {
            plusButton[0].initFrame(size: .long)
            plusButton[1].isHidden = true
        } else if disposition == 1 {
            plusButton[2].initFrame(size: .long)
            plusButton[3].isHidden = true
        }
    }
    
    public func addImageToButton(_ image: UIImage, buttonTag: Int) {
        plusButton[buttonTag - 10].setImage(image, for: .normal)
        plusButton[buttonTag - 10].imageView?.contentMode = .scaleAspectFill
        print(plusButton[buttonTag - 10].frame)
    }
    
    public func imageWithView() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}
