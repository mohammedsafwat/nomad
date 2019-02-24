//
//  UIBarButtonIten+Action.swift
//  Nomad
//
//  Created by Mohammed Safwat on 24.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    func addAction(target: UIViewController, action: Selector) {
        self.target = target
        self.action = action
    }
}
