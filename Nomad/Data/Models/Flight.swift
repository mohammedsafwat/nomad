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
        flyTo <- map["flyTo"]
        flyFrom <- map["flyTrom"]
        cityTo <- map["cityTo"]
        cityFrom <- map["cityTrom"]
        departureTime <- map["dTime"]
        arrivalTime <- map["aTime"]
        flyDuration <- map["fly_duration"]
        airlines <- map["airlines"]
        price <- map["price"]
        deepLink <- map["deep_link"]
    }
}
