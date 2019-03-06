//
//  StoreUtilsModule.swift
//  Nomad
//
//  Created by Mohammed Safwat on 06.03.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation

class StoreUtilsModule {

    // MARK: - Properties

    static let shared = StoreUtilsModule()

    private init() {}

    var storeUtils: StoreUtilsProtocol {
        return StoreUtils()
    }
}
