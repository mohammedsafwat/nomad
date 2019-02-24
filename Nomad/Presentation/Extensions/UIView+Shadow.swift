//
//  UIView+Shadow.swift
//  Nomad
//
//  Created by Mohammed Safwat on 24.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import UIKit

extension UIView {
    func addShadow(shadow: Shadow) {
        let layer = self.layer
        layer.shadowRadius = shadow.radius
        layer.shadowOpacity = shadow.opacity
        layer.shadowOffset = shadow.offset
        layer.masksToBounds = shadow.masksToBounds
        layer.shadowColor = shadow.shadowColor.cgColor
        let cachedBackgroundColor = self.backgroundColor?.cgColor
        self.backgroundColor = nil
        layer.backgroundColor =  cachedBackgroundColor
    }
}
