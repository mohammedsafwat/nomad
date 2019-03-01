//
//  Flight.swift
//  Nomad
//
//  Created by Mohammed Safwat on 20.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import ObjectMapper

class Flight: Mappable {
    
    // MARK: - Properties

    var route: [RouteItem]?
    var price: Int?
    var deepLink: String?
    
    // MARK: - Initializer
    
    init(route: [RouteItem]?, price: Int?, deepLink: String?) {
        self.route = route
        self.price = price
        self.deepLink = deepLink
    }
    
    // MARK: - Object Mapping
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        route <- map[API.Flights.ResponseKeys.route]
        price <- map[API.Flights.ResponseKeys.price]
        deepLink <- map[API.Flights.ResponseKeys.deepLink]
    }
}
