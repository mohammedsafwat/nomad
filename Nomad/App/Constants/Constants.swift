//
//  Constants.swift
//  Nomad
//
//  Created by Mohammed Safwat on 22.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation

struct Constants {
    struct DefaultFilter {
        static let from = "TXL,SXF"
        static let dateFrom = ""
        static let dateTo = ""
        static let price = 50
        static let limit = 30
        static let partner = "skyscanner"
    }

    struct NavigationBar {
        static let tintColorHex = "#fff"
    }
    
    struct ViewControllers {
        struct Flights {
            struct CollectionView {
                static let CellName = "FlightsTableViewCell"
                static let CellIdentifier = "FlightsTableViewCell"
            }
        }
    }
}
