//
//  PhotoContainerView.swift
//  P5_Instagrid
//
//  Created by RICHEUX Antoine on 07/10/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import UIKit

class PhotoContainerView: UIView {
    
    @IBOutlet var plusButton: [UIButton]!
    
    // Resize the button to the original size and resize according to the disposition choice
    func createDisposition(disposition: Int) {
        let margin = self.frame.size.height * 0.05
        let side = (self.frame.size.width - (3 * margin)) / 2
        let doubleSide = side * 2 + margin
        
        switch disposition {
        case 0:
            plusButton[0].frame = CGRect(origin: CGPoint(x:margin, y:margin), size: CGSize(width: doubleSide, height: side))
            plusButton[1].isHidden = true
            plusButton[2].frame = CGRect(origin: CGPoint(x:margin, y: side + margin*2), size: CGSize(width: side, height: side))
            plusButton[3].frame = CGRect(origin: CGPoint(x:side + margin*2, y:side + margin*2), size: CGSize(width: side, height: side))
            plusButton[3].isHidden = false
            
        case 1:
            plusButton[0].frame = CGRect(origin: CGPoint(x:margin,y:margin), size: CGSize(width: side, height: side))
            plusButton[0].frame = buttonFrameImageAdded(button: plusButton[0])
            plusButton[1].frame = CGRect(origin: CGPoint(x:side + margin*2,y:margin), size: CGSize(width: side, height: side))
            plusButton[1].isHidden = false
            plusButton[2].frame = CGRect(origin: CGPoint(x:margin,y:side + margin*2), size: CGSize(width: doubleSide, height: side))
            plusButton[3].isHidden = true
            
        case 2:
            plusButton[0].frame = CGRect(origin: CGPoint(x:margin,y:margin), size: CGSize(width: side, height: side))
            plusButton[1].frame = CGRect(origin: CGPoint(x:side + margin*2,y:margin), size: CGSize(width: side, height: side))
            plusButton[1].isHidden = false
            plusButton[2].frame = CGRect(origin: CGPoint(x:margin,y:side + margin*2), size: CGSize(width: side, height: side))
            plusButton[3].frame = CGRect(origin: CGPoint(x:side + margin*2,y:side + margin*2), size: CGSize(width: side, height: side))
            plusButton[3].isHidden = false
            
        default:
            break
            // rien faire
        }
    }
    
    func resizeView(orientation: UIInterfaceOrientation, screenBounds: CGRect){
        let minSide = min(screenBounds.height, screenBounds.width)
        let maxSide = max(screenBounds.height, screenBounds.width)
        let xMargin = minSide * 0.15
        let side = (minSide - 2*xMargin)
        let yMargin = (maxSide - side) / 2
        print("\(minSide) \(maxSide) \(xMargin) \(yMargin) \(side)")
        
        switch orientation {
        case .portrait:
            self.frame = CGRect(origin: CGPoint(x: xMargin, y: yMargin), size: CGSize(width: side, height: side))
            
        case .landscapeLeft,.landscapeRight :
            self.frame = CGRect(origin: CGPoint(x: yMargin, y: xMargin), size: CGSize(width: side, height: side))
            
        default:
            print("Anything But Portrait")
        }
    }
    
    public func addImageToButton(_ image: UIImage, _ button: UIButton) {
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.frame = buttonFrameImageAdded(button: button)
    }
   
    private func buttonFrameImageAdded(button: UIButton) -> CGRect {
        if let buttonView = button.imageView, let buttonImg = button.imageView?.image {
            let widthRatio = buttonView.bounds.size.width / buttonImg.size.width;
            let heightRatio = buttonView.bounds.size.height / buttonImg.size.height;
            let scale = min(widthRatio, heightRatio).roundThreeDecimal()
            
            let newWidth = scale * buttonImg.size.width;
            let newHeight = scale * buttonImg.size.height;
            let newButtonSize = CGSize(width: newWidth, height: newHeight)
            
            let newOriginX = (button.frame.size.width - newWidth) / 2 + button.frame.origin.x
            let newOriginY = (button.frame.size.height - newHeight) / 2 + button.frame.origin.y
            let newButtonOrigin = CGPoint(x: newOriginX, y: newOriginY)

            return CGRect(origin: newButtonOrigin, size: newButtonSize)
        }
        
        return button.frame
    }
    
}
