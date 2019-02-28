//
//  LocationsViewModel.swift
//  Nomad
//
//  Created by Mohammed Safwat on 26.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation
import RxSwift

struct LocationsViewModel {

    // MARK: - Properties

    var locationsSearchInput: Observable<String?>?

    private let locationsDataSource: LocationsDataSource
    private let schedulersFacade: SchedulersFacade

    private(set) var requestStatus = BehaviorSubject<RequestStatus>(value: RequestStatus(status: .success))

    var locations: Observable<[Location]> {
        guard let locationsSearchInput = locationsSearchInput else { return Observable<[Location]>.empty() }
        return locationsSearchInput
            .subscribeOn(schedulersFacade.backgroundScheduler())
            .flatMap { input -> Observable<[Location]> in
                guard let input = input else { return Observable<[Location]>.empty() }
                self.requestStatus.onNext(RequestStatus(status: .loading))
                return self.locationsDataSource.locations(name: input)
            }.do(onNext: { _ in
                self.requestStatus.onNext(RequestStatus(status: .success))
            }).catchError { error -> Observable<[Location]> in
                self.requestStatus.onNext(RequestStatus(error: error as? DataError, status: .failed))
                return Observable<[Location]>.empty()
            }
    }

    // MARK: - Initializer

    init(locationsDataSource: LocationsDataSource, schedulersFacade: SchedulersFacade) {
        self.locationsDataSource = locationsDataSource
        self.schedulersFacade = schedulersFacade
    }
}
