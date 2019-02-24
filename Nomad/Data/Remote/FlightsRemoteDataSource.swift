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
        let returnFrom = flightsFilter.returnFrom
        let price = flightsFilter.price
        let limit = flightsFilter.limit
        let partner = Constants.DefaultFilter.partner
        let nightsInDestinationFrom = Constants.DefaultFilter.nightsInDestinationFrom
        let nightsInDestinationTo = Constants.DefaultFilter.nightsInDestinationTo

        let parameters: [String: Any] = [FlightsRequestParameter.from.rawValue: from,
                                         FlightsRequestParameter.dateFrom.rawValue: dateFrom,
                                         FlightsRequestParameter.returnFrom.rawValue: returnFrom,
                                         FlightsRequestParameter.price.rawValue: price,
                                         FlightsRequestParameter.limit.rawValue: limit,
                                         FlightsRequestParameter.partner.rawValue: partner,
                                         FlightsRequestParameter.nightsInDestinationFrom.rawValue: nightsInDestinationFrom,
                                         FlightsRequestParameter.nightsInDestinationTo.rawValue: nightsInDestinationTo]

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
                let flightsData = responseData[API.Flights.ResponseKeys.data] as? [[String: Any]],
                let currency = responseData[API.Flights.ResponseKeys.currency] as? String else {
                    throw DataErrorHelper.parseError
            }
            let flights = flightsData.compactMap { flightData in
                return self.parseFlight(flightData: flightData, currency: currency)
            }.compactMap { $0 }
            return Observable<[Flight]>.of(flights)
        case .failure(let error):
            throw error
        }
    }

    private func parseFlight(flightData: [String: Any], currency: String?) -> Flight? {
        let flight = Flight(JSON: flightData)
        flight?.currency = currency
        return flight
    }
}
