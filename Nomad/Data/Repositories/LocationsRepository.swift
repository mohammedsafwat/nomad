//
//  LocationsRepository.swift
//  Nomad
//
//  Created by Mohammed Safwat on 27.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import RxSwift

class LocationsRepository: LocationsDataSource {

    // MARK: - Properties

    private let remoteDataSource: LocationsDataSource

    // MARK: - Initializer

    init(remoteDataSource: LocationsDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    // MARK: - LocationsDataSource Methods

    func locations(name: String) -> Observable<[Location]> {
        return remoteDataSource.locations(name: name)
    }
}
