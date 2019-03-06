//
//  HttpClientModule.swift
//  Nomad
//
//  Created by Mohammed Safwat on 22.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation

class HttpClientModule {

    // MARK: - Properties
    
    static let shared = HttpClientModule()

    // MARK: - Initializer

    private init() {}

    var httpClient: RestNetworkClientProtocol {
        return RestNetworkClient(headers: [:])
    }
}
