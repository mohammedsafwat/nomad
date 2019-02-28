//
//  DataModule.swift
//  Nomad
//
//  Created by Mohammed Safwat on 22.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation

class DataModule {
    static let shared = DataModule()
    private let restNetworkClient = HttpClientModule.shared.httpClient

    private init() {}

    func flightsRepository() -> FlightsDataSource {
        let flightsRemoteDataSource = FlightsModule.shared.flightsRemoteDataSource(restNetworkClient: restNetworkClient)
        return FlightsRepository(remoteDataSource: flightsRemoteDataSource)
    }

    func locationsRepository() -> LocationsDataSource {
        let locationsRemoteDataSource = LocationsModule.shared.locationsRemoteDataSource(restNetworkClient: restNetworkClient)
        return LocationsRepository(remoteDataSource: locationsRemoteDataSource)
    }
}
