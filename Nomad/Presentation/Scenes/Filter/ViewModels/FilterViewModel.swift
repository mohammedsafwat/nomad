//
//  FilterViewModel.swift
//  Nomad
//
//  Created by Mohammed Safwat on 27.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

struct FilterViewModel {

    // MARK: - Properties

    private let filterDataSource: FilterDataSource
    private let storeUtils: StoreUtilsProtocol
    private let schedulersFacade: SchedulersFacade
    private(set) var flightsFilter: BehaviorRelay<FlightsFilter>

    var priceSectionTitle: String {
        return String(format: "%@ (%@)",
                      Constants.ViewControllers.Filter.Sections.PriceSection.priceSectionTitle,
                      storeUtils.loadCurrency())
    }

    var filter: Observable<FlightsFilter> {
        return flightsFilter
            .subscribeOn(schedulersFacade.backgroundScheduler())
            .flatMap { filterValue -> Observable<FlightsFilter> in
                return Observable.of(FlightsFilter(from: filterValue.from, travelInterval: filterValue.travelInterval, price: filterValue.price, limit: filterValue.limit, maxStopovers: filterValue.maxStopovers))
            }
    }

    // MARK: - Initializer

    init(filterDataSource: FilterDataSource, flightsFilter: BehaviorRelay<FlightsFilter>, storeUtils: StoreUtilsProtocol, schedulersFacade: SchedulersFacade) {
        self.filterDataSource = filterDataSource
        self.flightsFilter = flightsFilter
        self.storeUtils = storeUtils
        self.schedulersFacade = schedulersFacade
    }

    // MARK: - Store Filter

    func storeFlightsFilter() -> Observable<FlightsFilter> {
        return filterDataSource.storeFlightsFilter(flightsFilter: self.flightsFilter.value)
            .subscribeOn(schedulersFacade.backgroundScheduler())
    }
}
