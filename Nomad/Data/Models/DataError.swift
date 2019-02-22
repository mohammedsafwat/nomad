//
//  DataError.swift
//  Nomad
//
//  Created by Mohammed Safwat on 21.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation

struct DataError: Error {
    let dataErrorType: DataErrorType
    let dataErrorMessage: String?
}
