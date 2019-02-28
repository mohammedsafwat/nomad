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

    var from: Location
    var dateFrom: String
    var returnFrom: String
    var price: Int
    var limit: Int
    var maxStopovers: Int

    // MARK: - Initializer

    init(from: Location, dateFrom: String, returnFrom: String, price: Int, limit: Int, maxStopovers: Int) {
        self.from = from
        self.dateFrom = dateFrom
        self.returnFrom = returnFrom
        self.price = price
        self.limit = limit
        self.maxStopovers = maxStopovers
    }

    static func == (lhs: FlightsFilter, rhs: FlightsFilter) -> Bool {
        return lhs.from == rhs.from &&
            lhs.dateFrom == rhs.dateFrom &&
            lhs.returnFrom == rhs.returnFrom &&
            lhs.price == rhs.price &&
            lhs.limit == rhs.limit &&
            lhs.maxStopovers == rhs.maxStopovers
    }
}
