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

    private(set) var flightsFilter = BehaviorRelay<FlightsFilter?>(value: nil)
    private(set) var requestStatus = BehaviorSubject<RequestStatus>(value: RequestStatus(status: .success))

    var flights: Observable<[Flight]> {
        return flightsFilter
            .subscribeOn(schedulersFacade.backgroundScheduler())
            .flatMap { _ -> Observable<[Flight]> in
                guard let filter = self.flightsFilter.value else { return Observable<[Flight]>.empty() }
                self.requestStatus.onNext(RequestStatus(status: .loading))
                return self.flightsDataSource.flights(flightsFilter: filter)
            }.do(onNext: { _ in
                self.requestStatus.onNext(RequestStatus(status: .success))
            })
            .catchError { error -> Observable<[Flight]> in
                self.requestStatus.onNext(RequestStatus(error: error as? DataError, status: .failed))
                return Observable<[Flight]>.empty()
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
        self.flightsFilter.accept(filter)
    }
}

// MARK: - NetworkingOperations Protocol

extension FlightsViewModel: NetworkingOperations {
    func refresh() {
        setFlightsFilter(filter: flightsFilter.value)
    }

    func loadMore(itemsCount: Int) {
        flightsFilter.value?.limit += itemsCount
        setFlightsFilter(filter: flightsFilter.value)
    }

    func tryAgain() {
        setFlightsFilter(filter: flightsFilter.value)
    }
}
