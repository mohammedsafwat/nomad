//
//  LocationsDataSource.swift
//  Nomad
//
//  Created by Mohammed Safwat on 27.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import RxSwift

protocol LocationsDataSource {
    func locations(name: String) -> Observable<[Location]>
}
