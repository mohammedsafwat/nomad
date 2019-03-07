//
//  FlightsRepositorySpec.swift
//  NomadTests
//
//  Created by Mohammed Safwat on 07.03.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import RxSwift
import RxBlocking
import Quick
import Nimble
@testable import Nomad

class FlightsRepositorySpec: QuickSpec {
    private let storeUtils = MockStoreUtils(currency: "EUR", lastUpdate: Date())
    private let cachingUtils = CachingUtils(dateUtils: DateUtilsModule.shared.dateUtils)

    override func spec() {
        super.spec()

        describe("flights repository") {
            context("when 'flights' data source method is called and local data source is not empty") {
                let remoteDataSource = MockFlightsDataSource(flightsResponse: Observable.of(MockDataModule.shared.mockFlightsNonEmptyResponse))
                let localDataSource = MockFlightsDataSource(flightsResponse: Observable.of(MockDataModule.shared.mockFlightsNonEmptyResponse))
                let flightsRepository = FlightsRepository(remoteDataSource: remoteDataSource, localDataSource: localDataSource, storeUtils: self.storeUtils, cachingUtils: self.cachingUtils)

                beforeEach {
                    _ = flightsRepository.flights(flightsFilter: MockDataModule.shared.mockFlightsFilter).toBlocking().materialize()
                }

                it("should call 'flights' on local data source and should not call 'flights' on remote data source") {
                    localDataSource.verifyCall(withIdentifier: "flights", arguments: [MockDataModule.shared.mockFlightsFilter])
                    remoteDataSource.verifyCall(withIdentifier: "flights", arguments: [MockDataModule.shared.mockFlightsFilter], mode: .never)

                }
            }

            context("when 'flights' data source method is called and local data source is empty") {
                let remoteDataSource = MockFlightsDataSource(flightsResponse: Observable.of(MockDataModule.shared.mockFlightsNonEmptyResponse))
                let localDataSource = MockFlightsDataSource(flightsResponse: Observable.of(MockDataModule.shared.mockFlightsEmptyResponse))
                let flightsRepository = FlightsRepository(remoteDataSource: remoteDataSource, localDataSource: localDataSource, storeUtils: self.storeUtils, cachingUtils: self.cachingUtils)

                beforeEach {
                    _ = flightsRepository.flights(flightsFilter: MockDataModule.shared.mockFlightsFilter).toBlocking().materialize()
                }

                it("should call 'flights' on local data source and should call 'flights' on remote data source") {
                    localDataSource.verifyCall(withIdentifier: "flights", arguments: [MockDataModule.shared.mockFlightsFilter])
                    remoteDataSource.verifyCall(withIdentifier: "flights", arguments: [MockDataModule.shared.mockFlightsFilter], mode: .times(1))
                }
            }
        }
    }
}
