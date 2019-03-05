//
//  DataErrorMessageFormatter.swift
//  Nomad
//
//  Created by Mohammed Safwat on 22.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation

class DataErrorMessageFormatter {
    static func formatErrorMessage(errorType: DataErrorType, errorMessage: String?) -> String {
        let errorMessage = errorMessage ?? ""
        return errorMessage.isEmpty ? errorType.errorMessage : errorMessage
    }
}
