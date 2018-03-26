//
//  UIImageExt.swift
//  Tindog
//
//  Created by jean on 3/25/18.
//  Copyright © 2018 jean. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView{
    func round() {
        self.layer.cornerRadius = self.bounds.size.height / 2
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1.0
        self.clipsToBounds = true
    }
}
