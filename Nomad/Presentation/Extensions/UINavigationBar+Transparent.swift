//
//  UINavigationBar+Transparent.swift
//  Nomad
//
//  Created by Mohammed Safwat on 22.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import UIKit

extension UINavigationBar {
    func makeTransparent(withTintColor tintColor: UIColor) {
        self.setBackgroundImage(UIImage(), for: .default)
        self.tintColor = tintColor
        self.shadowImage = UIImage()
        self.backgroundColor = UIColor.clear
    }
}
