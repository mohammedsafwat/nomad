//
//  AppUtils.swift
//  Nomad
//
//  Created by Mohammed Safwat on 28.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation

class AppUtils {
    private static let storeUtils = StoreUtils()

    class func formatPrice(price: Int?) -> String {
        guard let price = price else { return "" }
        let currency = storeUtils.loadCurrency()
        return String(format: "%d %@", price, currency)
    }
}
