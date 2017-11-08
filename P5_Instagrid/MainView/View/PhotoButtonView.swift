//
//  PhotoButtonView.swift
//  P5_Instagrid
//
//  Created by RICHEUX Antoine on 10/10/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import UIKit

/// Class to handle photo button view 
class PhotoButtonView: UIButton {
    
    /// Set the frame of the button according to the button's size
    /// Animate the transition between two frame
    /// - Parameter size: button size -> normal or long
    public func setFrame(size: ButtonSize) {
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
    
    /// Set the original image to the button according to the device's orientation
    public func initializeImageView() {
        if UIApplication.shared.statusBarOrientation != .portrait {
            self.setImage(#imageLiteral(resourceName: "plusGray"), for: .normal)
        } else {
            self.setImage(#imageLiteral(resourceName: "plusBlue"), for: .normal)
        }
    }
}
