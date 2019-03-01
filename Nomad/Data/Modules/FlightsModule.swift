//
//  FlightsModule.swift
//  Nomad
//
//  Created by Mohammed Safwat on 22.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation

class FlightsModule {
    static let shared = FlightsModule()

    private init() {}

    func flightsRemoteDataSource(restNetworkClient: RestNetworkClientProtocol, storeUtils: StoreUtils) -> FlightsDataSource {
        return FlightsRemoteDataSource(restNetworkClient: restNetworkClient, storeUtils: storeUtils)
    }
}
