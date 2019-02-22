//
//  API.swift
//  Nomad
//
//  Created by Mohammed Safwat on 22.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation

struct API {
    private static let baseUrl = "https://api.skypicker.com/"

    struct Flights {
        static var endpointUrl: String {
            return baseUrl + "flights"
        }
        struct ResponseKeys {
            static let data = "data"
            static let flyTo = "flyTo"
            static let flyFrom = "flyFrom"
            static let cityTo = "cityTo"
            static let cityFrom = "cityFrom"
            static let departureTime = "dTime"
            static let arrivalTime = "aTime"
            static let flyDuration = "fly_duration"
            static let airlines = "airlines"
            static let price = "price"
            static let deepLink = "deep_link"
        }
    }
}
