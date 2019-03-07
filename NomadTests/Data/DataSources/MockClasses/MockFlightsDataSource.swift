//
//  MockFlightsDataSource.swift
//  NomadTests
//
//  Created by Mohammed Safwat on 07.03.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Mimus
import RxSwift
@testable import Nomad

class MockFlightsDataSource: FlightsDataSource, Mock {
    var storage: [RecordedCall] = []
    private let flightsResponse: Observable<FlightsResponse>

    init(flightsResponse: Observable<FlightsResponse>) {
        self.flightsResponse = flightsResponse
    }

    func flights(flightsFilter: FlightsFilter) -> Observable<FlightsResponse> {
        recordCall(withIdentifier: "flights", arguments: [flightsFilter])
        return self.flightsResponse
    }

    func storeFlights(flightsResponse: FlightsResponse, withFilter flightsFilter: FlightsFilter) -> Observable<FlightsResponse> {
        recordCall(withIdentifier: "storeFlights", arguments: [flightsResponse, flightsFilter])
        return self.flightsResponse
    }
}
