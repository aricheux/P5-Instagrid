//
//  DispositionContainerView.swift
//  P5_Instagrid
//
//  Created by RICHEUX Antoine on 10/10/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import UIKit

class DispositionContainerView: UIView {
    
    @IBOutlet var dispositionSelected: [UIImageView]!
    @IBOutlet var dispositionButton: [UIButton]!
    
    public func changeDisposition(disposition: Int) {
        
        for dispositionSelected in dispositionSelected {
            dispositionSelected.isHidden = true
        }
        
        dispositionSelected[disposition].isHidden = false
    }

    public func resizeView(orientation: UIInterfaceOrientation, screenBounds: CGRect){
        let minSide = min(screenBounds.height, screenBounds.width)
        let maxSide = max(screenBounds.height, screenBounds.width)
        
        let buttonSide: CGFloat = 80.0
        let margin = (minSide - buttonSide * 3) / 4
        let widht = buttonSide * 3 + margin * 2
        let marginYportrait = maxSide - margin - buttonSide
        let marginYlandscape = margin * 1.5
                        
        switch orientation {
        case .portrait:
            self.frame = CGRect(origin: CGPoint(x: margin, y: marginYportrait), size: CGSize(width: widht, height: buttonSide))
            
            dispositionButton[0].frame.origin = CGPoint(x: 0, y: 0)
            dispositionButton[1].frame.origin = CGPoint(x: buttonSide + margin, y: 0)
            dispositionButton[2].frame.origin = CGPoint(x: (buttonSide + margin) * 2, y: 0)

        case .landscapeLeft,.landscapeRight :
            self.frame = CGRect(origin: CGPoint(x: marginYportrait, y: marginYlandscape), size: CGSize(width: buttonSide, height: widht))
            
            dispositionButton[0].frame.origin = CGPoint(x: 0, y: 0)
            dispositionButton[1].frame.origin = CGPoint(x: 0, y: buttonSide + margin)
            dispositionButton[2].frame.origin = CGPoint(x: 0, y: (buttonSide + margin) * 2)
            
        default:
            break
        }
        
        dispositionSelected[0].frame = dispositionButton[0].frame
        dispositionSelected[1].frame = dispositionButton[1].frame
        dispositionSelected[2].frame = dispositionButton[2].frame
               
    }

}
