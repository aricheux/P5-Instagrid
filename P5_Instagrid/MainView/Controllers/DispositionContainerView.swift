//
//  DispositionContainerView.swift
//  P5_Instagrid
//
//  Created by RICHEUX Antoine on 10/10/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import UIKit

class DispositionContainerView: UIView {

    public func resizeView(orientation: UIInterfaceOrientation, screenBounds: CGRect){
        let minSide = min(screenBounds.height, screenBounds.width)
        let maxSide = max(screenBounds.height, screenBounds.width)
        let side: CGFloat = 160.0
        let yMargin = maxSide - side
        
        switch orientation {
        case .portrait:
            self.frame = CGRect(origin: CGPoint(x: 0, y: yMargin), size: CGSize(width: minSide, height: side))
            
        case .landscapeLeft,.landscapeRight :
            self.frame = CGRect(origin: CGPoint(x: yMargin, y: 0), size: CGSize(width: side, height: minSide))
            
        default:
            print("Anything But Portrait")
        }
    }

}
