//
//  FlightsRepository.swift
//  Nomad
//
//  Created by Mohammed Safwat on 20.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import RxSwift

class FlightsRepository: FlightsDataSource {
    
    // MARK: - Properties
    
    private let remoteDataSource: FlightsDataSource
    private let localDataSource: FlightsDataSource
    private let storeUtils: StoreUtilsProtocol
    private let cachingUtils: CachingUtilsProtocol
    
    // MARK: - Initializer
    
    init(remoteDataSource: FlightsDataSource, localDataSource: FlightsDataSource, storeUtils: StoreUtilsProtocol, cachingUtils: CachingUtilsProtocol) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
        self.storeUtils = storeUtils
        self.cachingUtils = cachingUtils
    }
    
    // MARK: - FlightsDataSource Methods

    func flights(flightsFilter: FlightsFilter) -> Observable<FlightsResponse> {
        let shouldRefreshContent = cachingUtils.shouldRefreshContent(lastRefreshDate: storeUtils.loadFlightsLastUpdateDate(), cachingHours: Constants.GeneralProperties.cachingHours)

        return localDataSource.flights(flightsFilter: flightsFilter).flatMap { flightsResponse -> Observable<FlightsResponse> in
            let flights = flightsResponse.flights ?? []
            if flights.isEmpty || shouldRefreshContent {
                return self.remoteDataSource.flights(flightsFilter: flightsFilter).flatMap { flightsResponse -> Observable<FlightsResponse> in
                    self.storeFlights(flightsResponse: flightsResponse, withFilter: flightsFilter)
                }.do(onNext: { _ in
                    self.storeUtils.storeFlightsLastUpdateDate(lastUpdate: Date())
                })
            } else {
                print("DEBUG: Fetching from cache")
                return Observable.of(flightsResponse)
            }
        }
    }

    func storeFlights(flightsResponse: FlightsResponse, withFilter flightsFilter: FlightsFilter) -> Observable<FlightsResponse> {
        return localDataSource.storeFlights(flightsResponse: flightsResponse, withFilter: flightsFilter)
    }
}
