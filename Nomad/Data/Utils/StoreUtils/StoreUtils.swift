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
}
