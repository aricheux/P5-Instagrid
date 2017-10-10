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
        let button = plusButton[buttonTag-10]
        
        button.imageIsAdded = false
        button.setImage(image, for: .normal)
        button.imageIsAdded = true
    }
    
    public func resizeView(orientation: UIInterfaceOrientation, screenBounds: CGRect){
        let minSide = min(screenBounds.height, screenBounds.width)
        let maxSide = max(screenBounds.height, screenBounds.width)
        let marginX = minSide * 0.1
        let side = (minSide - 2*marginX)
        let marginYportrait = (maxSide - side) * 0.5
        let marginYlandscape = (minSide - side) * 0.75
        
        switch orientation {
        case .portrait:
            self.frame = CGRect(origin: CGPoint(x: marginX, y: marginYportrait), size: CGSize(width: side, height: side))
            
        case .landscapeLeft,.landscapeRight :
            self.frame = CGRect(origin: CGPoint(x: marginYportrait, y: marginYlandscape), size: CGSize(width: side, height: side))
            
        default:
            print("Anything But Portrait")
        }
    }
 
}
