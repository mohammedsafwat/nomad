//
//  FilterDataSource.swift
//  Nomad
//
//  Created by Mohammed Safwat on 07.03.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import RxSwift

protocol FilterDataSource {
    func flightsFilter() -> Observable<FlightsFilter>
    func storeFlightsFilter(flightsFilter: FlightsFilter) -> Observable<FlightsFilter>
}
