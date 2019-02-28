//
//  LocationsRemoteDataSource.swift
//  Nomad
//
//  Created by Mohammed Safwat on 27.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import RxSwift
import Alamofire

class LocationsRemoteDataSource: LocationsDataSource {

    // MARK: - Properties

    private var restNetworkClient: RestNetworkClientProtocol

    // MARK: - Initializer

    init(restNetworkClient: RestNetworkClientProtocol) {
        self.restNetworkClient = restNetworkClient
    }

    // MARK: - LocationsDataSource

    func locations(name: String) -> Observable<[Location]> {
        let parameters: [String: Any] = [LocationsRequestParameter.term.rawValue: name,
                                         LocationsRequestParameter.locationTypes.rawValue: API.Locations.RequestDefaultValues.locationTypes,
                                         LocationsRequestParameter.activeOnly.rawValue: API.Locations.RequestDefaultValues.activeOnly,
                                         LocationsRequestParameter.sort.rawValue: API.Locations.RequestDefaultValues.sort]

        return restNetworkClient.performRequest(requestURLString: API.Locations.endpointUrl, type: .get, parameters: parameters)
            .flatMap { result in
                try self.parseLocationsQueryResponse(result: result)
            }
    }
}

// MARK: - Parsing Methods

extension LocationsRemoteDataSource {
    private func parseLocationsQueryResponse(result: Result<(HTTPURLResponse, Any), DataError>) throws -> Observable<[Location]> {
        switch result {
        case .success(let response):
            guard let responseData = response.1 as? [String: Any],
                let locationsData = responseData[API.Locations.ResponseKeys.locations] as? [[String: Any]] else {
                    throw DataErrorHelper.parseError
            }
            let locations = locationsData.compactMap { locationData in
                return self.parseLocation(locationData: locationData)
            }.compactMap { $0 }
            return Observable<[Location]>.of(locations)
        case .failure(let error):
            throw error
        }
    }

    private func parseLocation(locationData: [String: Any]) -> Location? {
        return Location(JSON: locationData)
    }
}
