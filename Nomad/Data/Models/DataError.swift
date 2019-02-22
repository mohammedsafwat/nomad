//
//  DataError.swift
//  Nomad
//
//  Created by Mohammed Safwat on 21.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation

struct DataError: Error {

    // MARK: - Properties

    private let statusCode: Int?
    private let dataErrorType: DataErrorType
    private let dataErrorMessage: String?

    // MARK: - Initializer

    init(statusCode: Int? = nil, dataErrorType: DataErrorType, dataErrorMessage: String?) {
        self.statusCode = statusCode
        self.dataErrorType = dataErrorType
        self.dataErrorMessage = dataErrorMessage
    }
}
