//
//  FlightsFilter+MockEquatable.swift
//  NomadTests
//
//  Created by Mohammed Safwat on 07.03.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Mimus
@testable import Nomad

extension FlightsFilter: MockEquatable {
    public func equalTo(other: Any?) -> Bool {
        if let otherFilter = other as? FlightsFilter {
            return otherFilter.from == self.from &&
                otherFilter.travelInterval == self.travelInterval &&
                otherFilter.price == self.price &&
                otherFilter.limit == self.limit &&
                otherFilter.maxStopovers == self.maxStopovers
        }
        return false
    }
}
