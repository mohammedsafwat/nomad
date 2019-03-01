//
//  FlightsResponse.swift
//  Nomad
//
//  Created by Mohammed Safwat on 28.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import ObjectMapper

class FlightsResponse: Mappable {

    // MARK: - Properties

    var flights: [Flight]?
    var currency: String?

    // MARK: - Initializer

    init(flights: [Flight]?, currency: String?) {
        self.flights = flights
        self.currency = currency
    }

    // MARK: - Object Mapping

    required init?(map: Map) {
        mapping(map: map)
    }

    func mapping(map: Map) {
        flights <- map[API.Flights.ResponseKeys.data]
        currency <- map[API.Flights.ResponseKeys.currency]
    }
}
