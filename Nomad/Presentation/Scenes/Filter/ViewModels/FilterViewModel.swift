//
//  FilterViewModel.swift
//  Nomad
//
//  Created by Mohammed Safwat on 27.02.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation
import RxCocoa

struct FilterViewModel {

    // MARK: - Properties

    private(set) var flightsFilter = BehaviorRelay<FlightsFilter?>(value: nil)
}
