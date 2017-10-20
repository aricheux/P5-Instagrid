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
    var location: Location = .topLeft
    
    public func initFrame(size: Size) {
        self.size = size
        
        if let containerView = self.superview {
            print(containerView.frame)
            let margin = containerView.frame.size.height * 0.05
            print(margin)
            let side = (containerView.frame.size.width - (margin * 3)) / 2

            var sizeButton = CGSize(width: side, height: side)
            if size == .long {
                sizeButton = CGSize(width: side*2 + margin, height: side)
            }
            
            var originButton = CGPoint()
            switch location {
            case .topLeft:
                originButton = CGPoint(x: margin, y: margin)
            case .topRight:
                originButton = CGPoint(x: side + margin * 2, y: margin)
            case .bottomLeft:
                originButton = CGPoint(x: margin, y: side + margin * 2)
            case .bottomRight:
                originButton = CGPoint(x: side + margin * 2, y: side + margin * 2)
            }
            
            self.frame = CGRect(origin: originButton, size: sizeButton)
        }
    }
}
