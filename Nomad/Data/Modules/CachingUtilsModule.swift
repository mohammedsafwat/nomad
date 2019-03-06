//
//  CachingUtilsModule.swift
//  Nomad
//
//  Created by Mohammed Safwat on 06.03.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation

class CachingUtilsModule {

    // MARK: - Properties

    static let shared = CachingUtilsModule()

    private init() {}

    func cachingUtils(dateUtils: DateUtilsProtocol) -> CachingUtilsProtocol {
        return CachingUtils(dateUtils: dateUtils)
    }
}
