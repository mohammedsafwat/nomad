//
//  DateUtilsModule.swift
//  Nomad
//
//  Created by Mohammed Safwat on 06.03.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation

class DateUtilsModule {

    // MARK: - Properties

    static let shared = DateUtilsModule()

    private init() {}

    var dateUtils: DateUtilsProtocol {
        return DateUtils()
    }
}
