
//
//  UIImagePickerExtension.swift
//  P5_Instagrid
//
//  Created by RICHEUX Antoine on 07/11/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import Foundation
import UIKit

/// Extension to show the image picker in the good orientation
extension UIImagePickerController
{
    override open var shouldAutorotate: Bool {
        return true
    }
    override open var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .all
    }
}
