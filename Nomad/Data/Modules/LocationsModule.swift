//
//  LocationsModule.swift
//  Nomad
//
//  Created by Mohammed Safwat on 27.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation

class LocationsModule {
    static let shared = LocationsModule()

    private init() {}

    func locationsRemoteDataSource(restNetworkClient: RestNetworkClientProtocol) -> LocationsDataSource {
        return LocationsRemoteDataSource(restNetworkClient: restNetworkClient)
    }
}
