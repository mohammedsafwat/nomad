//
//  FlightsViewModel.swift
//  Nomad
//
//  Created by Mohammed Safwat on 22.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct FlightsViewModel {

    // MARK: - Properties

    private let flightsDataSource: FlightsDataSource
    private let schedulersFacade: SchedulersFacadeProtocol

    private(set) var flights = BehaviorRelay<[Flight]>(value: [])
    private(set) var flightsFilter = BehaviorRelay<FlightsFilter>(value: FlightsFilter(from: Constants.DefaultFilter.from, travelInterval: .nextWeekend, price: Constants.DefaultFilter.price, limit: Constants.DefaultFilter.limit, maxStopovers: Constants.DefaultFilter.maxStopOvers))
    private(set) var requestStatus = BehaviorSubject<RequestStatus>(value: RequestStatus(status: .success))

    var flightsResponse: Observable<FlightsResponse> {
        return flightsFilter
            .subscribeOn(schedulersFacade.backgroundScheduler())
            .flatMap { _ -> Observable<FlightsResponse> in
                let filter = self.flightsFilter.value
                self.requestStatus.onNext(RequestStatus(status: .loading))
                return self.flightsDataSource.flights(flightsFilter: filter)
            }.do(onNext: { flightsResponse in
                self.flights.accept(flightsResponse.flights ?? [])
                self.requestStatus.onNext(RequestStatus(status: .success))
            })
            .catchError { error -> Observable<FlightsResponse> in
                self.requestStatus.onNext(RequestStatus(error: error as? DataError, status: .failed))
                return Observable<FlightsResponse>.empty()
            }
    }

    // MARK: - Initializer

    init(flightsDataSource: FlightsDataSource, schedulersFacade: SchedulersFacade) {
        self.flightsDataSource = flightsDataSource
        self.schedulersFacade = schedulersFacade
    }
}

// MARK: - Helper Methods

extension FlightsViewModel {
    func setFlightsFilter(filter: FlightsFilter?) {
        guard let filter = filter else { return }
        if self.flightsFilter.value != filter {
            self.flightsFilter.accept(filter)
        }
    }
}

// MARK: - NetworkingOperations Protocol

extension FlightsViewModel: NetworkingOperations {
    func refresh() {
        setFlightsFilter(filter: flightsFilter.value)
    }

    func loadMore(itemsCount: Int) {
        flightsFilter.value.limit += itemsCount
        setFlightsFilter(filter: flightsFilter.value)
    }

    func tryAgain() {
        setFlightsFilter(filter: flightsFilter.value)
    }
}
