//
//  RequestStatus.swift
//  Nomad
//
//  Created by Mohammed Safwat on 22.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation

struct RequestStatus {
    var error: Error?
    var status: LoadingStatus

    init(error: Error? = nil, status: LoadingStatus = .loading) {
        self.error = error
        self.status = status
    }
}
