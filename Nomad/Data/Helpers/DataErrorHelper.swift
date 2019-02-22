//
//  DataErrorHelper.swift
//  Nomad
//
//  Created by Mohammed Safwat on 21.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation

class DataErrorHelper {
    class var parseError: DataError {
        let errorMessage = DataErrorMessageFormatter.formatErrorMessage(errorType: .parse, errorMessage: "")
        let dataError = DataError(dataErrorType: .parse, dataErrorMessage: errorMessage)
        return dataError
    }
    
    class var requestFailedError: DataError {
        let errorMessage = DataErrorMessageFormatter.formatErrorMessage(errorType: .requestFailed, errorMessage: "")
        let dataError = DataError(dataErrorType: .requestFailed, dataErrorMessage: errorMessage)
        return dataError
    }
}
