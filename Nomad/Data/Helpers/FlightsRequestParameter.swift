//
//  FlightsRequestParameter.swift
//  Nomad
//
//  Created by Mohammed Safwat on 22.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

enum FlightsRequestParameter: String {
    case from = "flyFrom"
    case to = "flyTo"
    case dateFrom = "dateFrom"
    case dateTo = "dateTo"
    case price = "price_to"
    case limit = "limit"
    case partner = "partner"
    case nightsInDestinationFrom = "nights_in_dst_from"
    case nightsInDestinationTo = "nights_in_dst_to"
    case maxStopovers = "max_stopovers"
}
