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
    var httpClient: RestNetworkClientProtocol

    // MARK: - Initializer

    private init() {
        httpClient = RestNetworkClient(headers: [:])
    }
}
