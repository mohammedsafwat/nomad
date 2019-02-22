//
//  FlightsRequest.swift
//  Nomad
//
//  Created by Mohammed Safwat on 22.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation

struct FlightsRequest: Equatable {

    // MARK: - Properties

    let from: String
    let to: String?
    let dateFrom: String
    let dateTo: String

    // MARK: - Initializer

    init(from: String, to: String?, dateFrom: String, dateTo: String) {
        self.from = from
        self.to = to
        self.dateFrom = dateFrom
        self.dateTo = dateTo
    }
}
