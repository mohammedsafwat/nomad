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
    
    private var remoteDataSource: FlightsDataSource
    
    // MARK: - Initializer
    
    init(remoteDataSource: FlightsDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    
    // MARK: - FlightsDataSource Methods

    func flights(flightsFilter: FlightsFilter) -> Observable<FlightsResponse> {
        return remoteDataSource.flights(flightsFilter: flightsFilter)
    }
}
