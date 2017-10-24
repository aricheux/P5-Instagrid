//
//  PhotoButtonView.swift
//  P5_Instagrid
//
//  Created by RICHEUX Antoine on 10/10/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import UIKit

enum Size {
    case normal, long
}

enum Location {
    case topLeft, topRight, bottomLeft, bottomRight
}

class PhotoButtonView: UIButton {
    
    var size: Size = .normal
    
    public func setFrame(size: Size) {
        self.size = size
        
        if let containerView = self.superview {
            let margin = containerView.frame.size.height * 0.05
            let side = (containerView.frame.size.width - (margin * 3)) / 2

            var sizeButton = CGSize(width: side, height: side)
            if size == .long {
                sizeButton = CGSize(width: side*2 + margin, height: side)
            }
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                self.frame.size = sizeButton
            },completion: nil)
        }
    }
}
