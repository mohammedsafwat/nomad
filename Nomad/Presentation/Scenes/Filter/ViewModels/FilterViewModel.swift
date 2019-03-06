//
//  FilterViewModel.swift
//  Nomad
//
//  Created by Mohammed Safwat on 27.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation
import RxCocoa

struct FilterViewModel {

    // MARK: - Properties

    private let storeUtils: StoreUtilsProtocol
    private(set) var flightsFilter = BehaviorRelay<FlightsFilter?>(value: nil)

    // MARK: - Initializer

    init(storeUtils: StoreUtilsProtocol) {
        self.storeUtils = storeUtils
    }

    var priceSectionTitle: String {
        return String(format: "%@ (%@)",
                      Constants.ViewControllers.Filter.Sections.PriceSection.priceSectionTitle,
                      storeUtils.loadCurrency())
    }
}
