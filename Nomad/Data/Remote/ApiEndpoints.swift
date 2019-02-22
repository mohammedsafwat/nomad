//
//  ApiEndpoints.swift
//  Nomad
//
//  Created by Mohammed Safwat on 22.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation

struct API {
    private static let baseUrl = "https://api.skypicker.com/"
    static var flightsUrl: String {
        return baseUrl + "flights"
    }
}
