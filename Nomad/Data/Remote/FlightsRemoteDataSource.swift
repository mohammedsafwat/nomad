//
//  FlightsRemoteDataSource.swift
//  Nomad
//
//  Created by Mohammed Safwat on 20.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import RxSwift

class FlightsRemoteDataSource: FlightsDataSource {
    
    // MARK: - Properties
    
    private var restNetworkClient: RestNetworkClientProtocol
    
    // MARK: - Initializer
    
    init(restNetworkClient: RestNetworkClientProtocol) {
        
    }
}
