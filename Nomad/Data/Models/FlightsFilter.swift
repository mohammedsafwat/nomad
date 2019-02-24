//
//  FlightsFilter.swift
//  Nomad
//
//  Created by Mohammed Safwat on 22.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation

class FlightsFilter: Equatable {

    // MARK: - Properties

    let from: String
    let dateFrom: String
    let returnFrom: String
    let price: Int
    var limit: Int

    // MARK: - Initializer

    init(from: String, dateFrom: String, returnFrom: String, price: Int, limit: Int) {
        self.from = from
        self.dateFrom = dateFrom
        self.returnFrom = returnFrom
        self.price = price
        self.limit = limit
    }

    static func == (lhs: FlightsFilter, rhs: FlightsFilter) -> Bool {
        return lhs.from == rhs.from &&
            lhs.dateFrom == rhs.dateFrom &&
            lhs.returnFrom == rhs.returnFrom &&
            lhs.price == rhs.price &&
            lhs.limit == rhs.limit
    }
}
