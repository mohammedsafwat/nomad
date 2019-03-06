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
    private var storeUtils: StoreUtilsProtocol
    private var dateUtils: DateUtilsProtocol

    // MARK: - Initializer
    
    init(restNetworkClient: RestNetworkClientProtocol, storeUtils: StoreUtilsProtocol, dateUtils: DateUtilsProtocol) {
        self.restNetworkClient = restNetworkClient
        self.storeUtils = storeUtils
        self.dateUtils = dateUtils
    }
    
    // MARK: - FlightsDataSource
    
    func flights(flightsFilter: FlightsFilter) -> Observable<FlightsResponse> {
        print("DEBUG: Fetching from remote data source")
        let from = flightsFilter.from.code ?? ""
        let dateFrom = dateUtils.weekendDateStrings(travelInterval: flightsFilter.travelInterval).0
        let returnFrom = dateUtils.weekendDateStrings(travelInterval: flightsFilter.travelInterval).1
        let price = flightsFilter.price
        let limit = flightsFilter.limit
        let partner = Constants.DefaultFilter.partner
        let nightsInDestinationFrom = Constants.DefaultFilter.nightsInDestinationFrom
        let nightsInDestinationTo = Constants.DefaultFilter.nightsInDestinationTo
        let maxStopovers = flightsFilter.maxStopovers

        let parameters: [String: Any] = [FlightsRequestParameter.from.rawValue: from,
                                         FlightsRequestParameter.dateFrom.rawValue: dateFrom,
                                         FlightsRequestParameter.returnFrom.rawValue: returnFrom,
                                         FlightsRequestParameter.price.rawValue: price,
                                         FlightsRequestParameter.limit.rawValue: limit,
                                         FlightsRequestParameter.partner.rawValue: partner,
                                         FlightsRequestParameter.nightsInDestinationFrom.rawValue: nightsInDestinationFrom,
                                         FlightsRequestParameter.nightsInDestinationTo.rawValue: nightsInDestinationTo,
                                         FlightsRequestParameter.maxStopovers.rawValue: maxStopovers]

        return restNetworkClient.performRequest(requestURLString: API.Flights.endpointUrl, type: .get, parameters: parameters)
            .flatMap { result in
                try self.parseFlightsQueryResponse(result: result)
            }
    }

    func storeFlights(flightsResponse: FlightsResponse, withFilter flightsFilter: FlightsFilter) -> Observable<FlightsResponse> {
        return Observable<FlightsResponse>.empty()
    }
}

// MARK: - Parsing Methods

extension FlightsRemoteDataSource {
    private func parseFlightsQueryResponse(result: Result<(HTTPURLResponse, Any), DataError>) throws -> Observable<FlightsResponse> {
        switch result {
        case .success(let response):
            guard let responseData = response.1 as? [String: Any],
                let flightsData = responseData[API.Flights.ResponseKeys.data] as? [[String: Any]],
                let currency = responseData[API.Flights.ResponseKeys.currency] as? String else {
                    throw DataErrorHelper.parseError
            }

            storeUtils.storeCurrency(currency: currency)

            let flights = flightsData.compactMap { flightData in
                return self.parseFlight(flightData: flightData)
            }.compactMap { $0 }
            let flightsResponse = FlightsResponse(flights: flights, currency: currency)
            return Observable<FlightsResponse>.of(flightsResponse)
        case .failure:
            throw DataErrorHelper.requestFailedError
        }
    }

    private func parseFlight(flightData: [String: Any]) -> Flight? {
        return Flight(JSON: flightData)
    }
}
