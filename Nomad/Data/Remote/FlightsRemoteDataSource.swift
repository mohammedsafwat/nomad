//
//  FlightsRemoteDataSource.swift
//  Nomad
//
//  Created by Mohammed Safwat on 20.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import RxSwift

class FlightsRemoteDataSource: FlightsDataSource {
    
    // MARK: - Properties
    
    private var restNetworkClient: RestNetworkClientProtocol
    
    // MARK: - Initializer
    
    init(restNetworkClient: RestNetworkClientProtocol) {
        self.restNetworkClient = restNetworkClient
    }
    
    // MARK: - FlightsDataSource
    
    func flights(from: String, to: String, dateFrom: String, dateTo: String) -> Observable<[Flight]> {
        return restNetworkClient.performRequest(requestURLString: API.flightsUrl, type: .get).flatMap({ data in
            try self.parseFlightsQueryResponse(data: data)
        })
    }
}

// MARK: - Parsing Methods

extension FlightsRemoteDataSource {
    private func parseFlightsQueryResponse(data: [String: Any]) throws -> Observable<[Flight]> {
        return Observable<[Flight]>.of([])
    }
}
