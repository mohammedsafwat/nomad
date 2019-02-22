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

    private(set) var filter = BehaviorRelay<FlightsFilter?>(value: nil)
    private(set) var requestStatus = BehaviorSubject<RequestStatus>(value: RequestStatus(status: .loading))

    var flights: Observable<[Flight]> {
        return filter
            .subscribeOn(schedulersFacade.backgroundScheduler())
            .flatMap { _ -> Observable<[Flight]> in
                guard let filter = self.filter.value else { return Observable<[Flight]>.empty() }
                return self.flightsDataSource.flights(flightsFilter: filter)
            }.do(onNext: { _ in
                self.requestStatus.onNext(RequestStatus(status: .success))
            }, onError: { error in
                self.requestStatus.onNext(RequestStatus(error: error, status: .failed))
            }, onSubscribe: {
                self.requestStatus.onNext(RequestStatus(status: .loading))
            })
    }

    // MARK: - Initializer

    init(flightsDataSource: FlightsDataSource, schedulersFacade: SchedulersFacade) {
        self.flightsDataSource = flightsDataSource
        self.schedulersFacade = schedulersFacade
    }
}

// MARK: - Helper Methods

extension FlightsViewModel {
    func setFilter(filter: FlightsFilter?) {
        guard let filter = filter, self.filter.value != filter else { return }
        self.filter.accept(filter)
    }
}

// MARK: - NetworkingOperations Protocol

extension FlightsViewModel: NetworkingOperations {
    func refresh() {
        setFilter(filter: filter.value)
    }

    func loadMore(itemsCount: Int) {
        filter.value?.limit += itemsCount
        setFilter(filter: filter.value)
    }

    func tryAgain() {
        setFilter(filter: filter.value)
    }
}
