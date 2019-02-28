//
//  UIView+RoundedCorners.swift
//  Nomad
//
//  Created by Mohammed Safwat on 26.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import UIKit

extension UIView {
    func setRoundedCorners(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }

    func setRoundCornersWithRect(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
