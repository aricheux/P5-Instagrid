//
//  PhotoButtonView.swift
//  P5_Instagrid
//
//  Created by RICHEUX Antoine on 10/10/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import UIKit

// Enumeration to define the size of the button
enum Size {
    case normal, long
}

// Photo button view handling
class PhotoButtonView: UIButton {
    // Size of the button
    var size: Size = .normal
    
    /* Set the frame of the button according to the button's size
     Animate the transition between two frame */
    public func setFrame(size: Size) {
        self.size = size
        
        if let containerView = self.superview {
            let margin = containerView.frame.size.height * 0.05
            let side = (containerView.frame.size.width - (margin * 3)) / 2
            
            var sizeButton = CGSize(width: side, height: side)
            if size == .long {
                sizeButton = CGSize(width: side*2 + margin, height: side)
            }
            
            UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
                self.frame.size = sizeButton
            },completion: nil)
        }
    }
}
