//
//  CGFloat.swift
//  P5_Instagrid
//
//  Created by RICHEUX Antoine on 09/10/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    /// Rounds the double to decimal places value
    func roundThreeDecimal() -> CGFloat {
        return CGFloat(Darwin.round(1000*self)/1000)
    }
}
