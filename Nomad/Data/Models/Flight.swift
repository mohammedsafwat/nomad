//
//  Flight.swift
//  Nomad
//
//  Created by Mohammed Safwat on 20.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation
import ObjectMapper

class Flight: Mappable {
    
    // MARK: - Properties
    
    var flyTo: String?
    var flyFrom: String?
    var cityTo: String?
    var cityFrom: String?
    var departureTime: TimeInterval?
    var arrivalTime: TimeInterval?
    var flyDuration: String?
    var airlines: [String]?
    var price: Int?
    var deepLink: String?
    
    // MARK: - Initializer
    
    init(flyTo: String?, flyFrom: String?, cityTo: String?, cityFrom: String?, departureTime: TimeInterval?, arrivalTime: TimeInterval?, flyDuration: String?, airlines: [String]?, price: Int?, deepLink: String?) {
        self.flyTo = flyTo
        self.flyFrom = flyFrom
        self.cityTo = cityTo
        self.cityFrom = cityFrom
        self.departureTime = departureTime
        self.arrivalTime = arrivalTime
        self.flyDuration = flyDuration
        self.airlines = airlines
        self.price = price
        self.deepLink = deepLink
    }
    
    // MARK: - Object Mapping
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        flyTo <- map[API.Flights.ResponseKeys.flyTo]
        flyFrom <- map[API.Flights.ResponseKeys.flyFrom]
        cityTo <- map[API.Flights.ResponseKeys.cityTo]
        cityFrom <- map[API.Flights.ResponseKeys.cityFrom]
        departureTime <- map[API.Flights.ResponseKeys.departureTime]
        arrivalTime <- map[API.Flights.ResponseKeys.arrivalTime]
        flyDuration <- map[API.Flights.ResponseKeys.flyDuration]
        airlines <- map[API.Flights.ResponseKeys.airlines]
        price <- map[API.Flights.ResponseKeys.price]
        deepLink <- map[API.Flights.ResponseKeys.deepLink]
    }
}
