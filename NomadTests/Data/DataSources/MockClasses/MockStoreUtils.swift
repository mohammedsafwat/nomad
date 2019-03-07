//
//  MockStoreUtils.swift
//  NomadTests
//
//  Created by Mohammed Safwat on 07.03.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Mimus
@testable import Nomad

class MockStoreUtils: StoreUtilsProtocol, Mock {
    var storage: [RecordedCall] = []
    private let currency: String
    private let lastUpdate: Date

    init(currency: String, lastUpdate: Date) {
        self.currency = currency
        self.lastUpdate = lastUpdate
    }

    func storeCurrency(currency: String) {
        recordCall(withIdentifier: "storeCurrency", arguments: [currency])
    }

    func loadCurrency() -> String {
        recordCall(withIdentifier: "loadCurrency")
        return self.currency
    }

    func storeFlightsLastUpdateDate(lastUpdate: Date) {
        recordCall(withIdentifier: "storeFlightsLastUpdateDate", arguments: [lastUpdate])
    }

    func loadFlightsLastUpdateDate() -> Date {
        recordCall(withIdentifier: "loadFlightsLastUpdateDate")
        return self.lastUpdate
    }
}
