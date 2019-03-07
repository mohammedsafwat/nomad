//
//  AppWideConfigurations.swift
//  Nomad
//
//  Created by Mohammed Safwat on 07.03.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class AppWideConfigurations {
    static let shared = AppWideConfigurations()

    private let disposeBag = DisposeBag()
    private let filterDataSource = DataModule.shared.filterRepository()
    private let defaultFlightsFilter = DataModule.shared.defaultFlightsFilter

    var flightsFilter: BehaviorRelay<FlightsFilter>

    private init() {
        flightsFilter = BehaviorRelay<FlightsFilter>(value: defaultFlightsFilter)
        filterDataSource.flightsFilter().subscribe(onNext: { filter in
            self.flightsFilter.accept(filter)
        }).disposed(by: disposeBag)
    }
}
