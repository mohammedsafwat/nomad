//
//  FilterRepository.swift
//  Nomad
//
//  Created by Mohammed Safwat on 07.03.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation
import RxSwift

class FilterRepository: FilterDataSource {

    // MARK: - Properties

    private let localDataSource: FilterDataSource

    // MARK: - Initializer

    init(localDataSource: FilterLocalDataSource) {
        self.localDataSource = localDataSource
    }

    // MARK: - FilterDataSource Methods

    func flightsFilter() -> Observable<FlightsFilter> {
        return localDataSource.flightsFilter()
    }

    func storeFlightsFilter(flightsFilter: FlightsFilter) -> Observable<FlightsFilter> {
        return localDataSource.storeFlightsFilter(flightsFilter: flightsFilter)
    }
}
