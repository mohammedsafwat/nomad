//
//  FlightsRemoteDataSource.swift
//  Nomad
//
//  Created by Mohammed Safwat on 20.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import RxSwift
import Alamofire

class FlightsRemoteDataSource: FlightsDataSource {
    
    // MARK: - Properties
    
    private var restNetworkClient: RestNetworkClientProtocol
    
    // MARK: - Initializer
    
    init(restNetworkClient: RestNetworkClientProtocol) {
        self.restNetworkClient = restNetworkClient
    }
    
    // MARK: - FlightsDataSource
    
    func flights(flightsFilter: FlightsFilter) -> Observable<[Flight]> {
        let from = flightsFilter.from
        let dateFrom = flightsFilter.dateFrom
        let dateTo = flightsFilter.dateTo
        let limit = flightsFilter.limit
        let partner = Constants.DefaultFilter.partner

        let parameters: [String: Any] = [FlightsRequestParameter.from.rawValue: from,
                                         FlightsRequestParameter.dateFrom.rawValue: dateFrom,
                                         FlightsRequestParameter.dateTo.rawValue: dateTo,
                                         FlightsRequestParameter.limit.rawValue: limit,
                                         FlightsRequestParameter.partner.rawValue: partner]

        return restNetworkClient.performRequest(requestURLString: API.Flights.endpointUrl, type: .get, parameters: parameters).flatMap { result in
            try self.parseFlightsQueryResponse(result: result)
        }
    }
}

// MARK: - Parsing Methods

extension FlightsRemoteDataSource {
    private func parseFlightsQueryResponse(result: Result<(HTTPURLResponse, Any), DataError>) throws -> Observable<[Flight]> {
        switch result {
        case .success(let response):
            guard let responseData = response.1 as? [String: Any],
                let flightsData = responseData[API.Flights.ResponseKeys.data] as? [[String: Any]] else {
                    throw DataErrorHelper.parseError
            }
            let flights = flightsData.compactMap { flightData in
                return self.parseFlight(flightData: flightData)
            }.compactMap { $0 }
            return Observable<[Flight]>.of(flights)
        case .failure(let error):
            throw error
        }
    }

    private func parseFlight(flightData: [String: Any]) -> Flight? {
        return Flight(JSON: flightData)
    }
}
