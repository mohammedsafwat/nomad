//
//  LocationsTableViewCell.swift
//  Nomad
//
//  Created by Mohammed Safwat on 27.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import UIKit

class LocationsTableViewCell: UITableViewCell {

    // MARK: - Properties

    @IBOutlet private weak var locationsNameLabel: UILabel!

    // MARK: - Public Methods

    func configure(location: Location) {
        locationsNameLabel.text = location.name
    }
}
