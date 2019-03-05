//
//  AppUtils.swift
//  Nomad
//
//  Created by Mohammed Safwat on 28.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation
import UIKit

class AppUtils {
    private static let storeUtils = StoreUtils()

    class func formatPrice(price: Int?) -> String {
        guard let price = price else { return "" }
        let currency = storeUtils.loadCurrency()
        return String(format: "%d %@", price, currency)
    }

    class func openUrl(urlString: String?){
        guard let urlString = urlString,
            let url = URL(string: urlString),
            UIApplication.shared.canOpenURL(url) else {
                return
        }

        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
