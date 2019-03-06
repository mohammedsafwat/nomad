//
//  CachingUtilsProtocol.swift
//  Nomad
//
//  Created by Mohammed Safwat on 06.03.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation

protocol CachingUtilsProtocol {
    func shouldRefreshContent(lastRefreshDate: Date, cachingHours: Int) -> Bool
}
