//
//  DataModule.swift
//  Nomad
//
//  Created by Mohammed Safwat on 22.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation

class DataModule {

    // MARK: - Properties
    
    static let shared = DataModule()
    private let restNetworkClient = HttpClientModule.shared.httpClient
    private let storeUtils = StoreUtils()

    private init() {}

    // MARK: - Repositories Methods

    func flightsRepository() -> FlightsDataSource {
        let flightsRemoteDataSource = FlightsModule.shared.flightsRemoteDataSource(restNetworkClient: restNetworkClient, storeUtils: storeUtils)
        return FlightsRepository(remoteDataSource: flightsRemoteDataSource)
    }

    func locationsRepository() -> LocationsDataSource {
        let locationsRemoteDataSource = LocationsModule.shared.locationsRemoteDataSource(restNetworkClient: restNetworkClient)
        return LocationsRepository(remoteDataSource: locationsRemoteDataSource)
    }
}
