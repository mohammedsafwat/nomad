//
//  FlightsDataSource.swift
//  Nomad
//
//  Created by Mohammed Safwat on 19.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import RxSwift

protocol FlightsDataSource {
    func flights(from: String, to: String, dateFrom: String, dateTo: String) -> Observable<[Flight]>
}
