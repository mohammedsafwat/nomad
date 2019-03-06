//
//  CachingUtils.swift
//  Nomad
//
//  Created by Mohammed Safwat on 06.03.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation

class CachingUtils: CachingUtilsProtocol {

    // MARK: - Properties

    private let dateUtils: DateUtilsProtocol

    // MARK: - Initializer

    init(dateUtils: DateUtilsProtocol) {
        self.dateUtils = dateUtils
    }

    func shouldRefreshContent(lastRefreshDate: Date, cachingHours: Int) -> Bool {
        let hoursDifference = dateUtils.hoursDifference(date1: lastRefreshDate, date2: Date())
        return hoursDifference > cachingHours ? true : false
    }
}
