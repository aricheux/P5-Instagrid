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
    
    var imageIsAdded = false {
        didSet {
            if imageIsAdded == true {
                self.buttonFrameImageAdded()
            } else {
                self.initFrame(size: self.size)
            }
        }
    }
    var size: Size = .normal
    var location: Location = .topLeft
    
    public func initFrame(size: Size) {
        self.size = size
        
        if let containerView = self.superview {
            let margin = containerView.frame.size.height * 0.05
            let side = (containerView.frame.size.width - (3*margin)) / 2
            let marginPlusButton = side + 2*margin
            
            var sizeButton = CGSize(width: side, height: side)
            if size == .long {
                sizeButton = CGSize(width: 2*side + margin, height: side)
            }
            
            var originButton = CGPoint()
            switch location {
            case .topLeft:
                originButton = CGPoint(x: margin, y: margin)
            case .topRight:
                originButton = CGPoint(x: marginPlusButton, y: margin)
            case .bottomLeft:
                originButton = CGPoint(x: margin, y: marginPlusButton)
            case .bottomRight:
                originButton = CGPoint(x: marginPlusButton, y: marginPlusButton)
            }
            
            self.frame = CGRect(origin: originButton, size: sizeButton)
            
            if imageIsAdded {
                self.buttonFrameImageAdded()
            }
        }
    }

    private func buttonFrameImageAdded() {
        self.imageView?.contentMode = .scaleAspectFit

        if let buttonView = self.imageView, let buttonImg = self.imageView?.image {
            let widthRatio = buttonView.bounds.size.width / buttonImg.size.width;
            let heightRatio = buttonView.bounds.size.height / buttonImg.size.height;
            let scale = min(widthRatio, heightRatio).roundThreeDecimal()
            
            let newWidth = scale * buttonImg.size.width;
            let newHeight = scale * buttonImg.size.height;
            let newButtonSize = CGSize(width: newWidth, height: newHeight)
            
            let newOriginX = (self.frame.size.width - newWidth) / 2 + self.frame.origin.x
            let newOriginY = (self.frame.size.height - newHeight) / 2 + self.frame.origin.y
            let newButtonOrigin = CGPoint(x: newOriginX, y: newOriginY)
            
            self.frame = CGRect(origin: newButtonOrigin, size: newButtonSize)
        }

    }
}

extension CGFloat {
    /// Rounds the double to decimal places value
    func roundThreeDecimal() -> CGFloat {
        return CGFloat(Darwin.round(1000*self)/1000)
    }
}
