//
//  RequestStatus.swift
//  Nomad
//
//  Created by Mohammed Safwat on 22.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation

struct RequestStatus {
    var error: DataError?
    var status: LoadingStatus

    init(error: DataError? = nil, status: LoadingStatus = .loading) {
        self.error = error
        self.status = status
    }
}
