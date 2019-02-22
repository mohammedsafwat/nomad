//
//  DataErrorType.swift
//  Nomad
//
//  Created by Mohammed Safwat on 21.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

enum DataErrorType {
    case noConnection
    case timeout
    case serverFailed
    case requestFailed
    case parse
    case unauthorized
    case dbFailed
    case localOperationFailed
    case cancelled
    case unknown
    
    var errorTitle: String {
        switch self {
        case .noConnection:
            return "No internet connection"
        case .timeout:
            return "Internet connection problem"
        case .requestFailed, .serverFailed, .parse, .unauthorized, .cancelled:
            return "Loading failed"
        case .dbFailed, .localOperationFailed:
            return "Error"
        default:
            return "Error"
        }
    }
    
    var errorMessage: String {
        switch self {
        case .noConnection:
            return "Please make sure that your internet connection is active."
        case .timeout:
            return "Please check your internet connection."
        case .requestFailed, .serverFailed, .parse, .unauthorized, .cancelled:
            return "An unxpected errror happend. Please try again later."
        case .dbFailed, .localOperationFailed:
            return "A local error happened. Please try again."
        default:
            return "An unxpected errror happend. Please try again later."
        }
    }
}
