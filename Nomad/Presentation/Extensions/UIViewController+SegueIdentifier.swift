//
//  UIViewController+SegueIdentifier.swift
//  Nomad
//
//  Created by Mohammed Safwat on 27.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import UIKit

extension UIViewController {
    func storyboardSegue(for segue: UIStoryboardSegue) -> StoryboardSegue {
        return StoryboardSegue(rawValue: segue.identifier ?? "") ?? StoryboardSegue.undefined
    }
}
