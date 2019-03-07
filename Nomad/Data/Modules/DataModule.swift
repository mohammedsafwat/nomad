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
    private let coreDataManager = CoreDataModule.shared.coreDataManger
    private let storeUtils = StoreUtilsModule.shared.storeUtils
    private let dateUtils = DateUtilsModule.shared.dateUtils

    private init() {}

    // MARK: - Repositories Methods

    func flightsRepository() -> FlightsDataSource {
        let flightsRemoteDataSource = FlightsModule.shared.flightsRemoteDataSource(restNetworkClient: restNetworkClient, storeUtils: storeUtils, dateUtils: dateUtils)
        let flightsLocalDataSource = FlightsModule.shared.flightsLocalDataSource(coreDataManager: coreDataManager, storeUtils: storeUtils)
        let cachingUtils = CachingUtilsModule.shared.cachingUtils(dateUtils: dateUtils)
        return FlightsRepository(remoteDataSource: flightsRemoteDataSource, localDataSource: flightsLocalDataSource, storeUtils: storeUtils, cachingUtils: cachingUtils)
    }

    func locationsRepository() -> LocationsDataSource {
        let locationsRemoteDataSource = LocationsModule.shared.locationsRemoteDataSource(restNetworkClient: restNetworkClient)
        return LocationsRepository(remoteDataSource: locationsRemoteDataSource)
    }

    func filterRepository() -> FilterDataSource {
        let filterLocalDataSource = FilterModule.shared.filterLocalDataSource(coreDataManager: coreDataManager)
        return FilterRepository(localDataSource: filterLocalDataSource)
    }

    var defaultFlightsFilter: FlightsFilter {
        return FlightsFilter(from: Constants.DefaultFilter.from, travelInterval: .nextWeekend, price: Constants.DefaultFilter.price, limit: Constants.DefaultFilter.limit, maxStopovers: Constants.DefaultFilter.maxStopOvers)
    }
}
