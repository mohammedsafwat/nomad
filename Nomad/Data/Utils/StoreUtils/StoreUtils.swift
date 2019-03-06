//
//  StoreUtils.swift
//  Nomad
//
//  Created by Mohammed Safwat on 01.03.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation

struct StoreUtils: StoreUtilsProtocol {
    func loadCurrency() -> String {
        return UserDefaults.standard.string(forKey: StoreUtilsKeys.KEY_CURRENCY) ?? ""
    }

    func storeCurrency(currency: String) {
        UserDefaults.standard.set(currency, forKey: StoreUtilsKeys.KEY_CURRENCY)
    }

    func loadFlightsLastUpdateDate() -> Date {
        return UserDefaults.standard.value(forKey: StoreUtilsKeys.KEY_FLIGHTS_LAST_UPDATE_DATE) as? Date ?? Date()
    }

    func storeFlightsLastUpdateDate(lastUpdate: Date) {
        UserDefaults.standard.set(lastUpdate, forKey: StoreUtilsKeys.KEY_FLIGHTS_LAST_UPDATE_DATE)
    }
}
