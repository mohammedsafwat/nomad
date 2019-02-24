//
//  RouteItem.swift
//  Nomad
//
//  Created by Mohammed Safwat on 20.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation
import ObjectMapper

class RouteItem: Mappable {
    
    // MARK: - Properties
    
    var flyTo: String?
    var flyFrom: String?
    var cityTo: String?
    var cityFrom: String?
    var departureTime: TimeInterval?
    var departureTimeFormatted: String {
        guard let departureTime = departureTime else { return "" }
        return DateUtils.stringFromDate(date: Date(timeIntervalSince1970: departureTime), dateStyle: .none, timeStyle: .short)
    }
    var arrivalTime: TimeInterval?
    var arrivalTimeFormatted: String {
        guard let arrivalTime = arrivalTime else { return "" }
        return DateUtils.stringFromDate(date: Date(timeIntervalSince1970: arrivalTime), dateStyle: .none, timeStyle: .short)
    }
    var flightNumber: Int?
    var airline: String?

    // MARK: - Initializer

    init(flyTo: String?, flyFrom: String?, cityTo: String?, cityFrom: String?, departureTime: TimeInterval?, arrivalTime: TimeInterval?, flightNumber: Int?, airline: String?) {
        self.flyTo = flyTo
        self.flyFrom = flyFrom
        self.cityTo = cityTo
        self.cityFrom = cityFrom
        self.departureTime = departureTime
        self.arrivalTime = arrivalTime
        self.flightNumber = flightNumber
        self.airline = airline
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
        airline <- map[API.Flights.ResponseKeys.airline]
    }
}
