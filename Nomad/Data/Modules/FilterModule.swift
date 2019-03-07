//
//  FilterModule.swift
//  Nomad
//
//  Created by Mohammed Safwat on 07.03.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation

class FilterModule {

    // MARK: - Properties

    static let shared = FilterModule()

    private init() {}

    // MARK: - FilterLocalDataSource Methods

    func filterLocalDataSource(coreDataManager: CoreDataManagerProtocol) -> FilterLocalDataSource {
        return FilterLocalDataSource(managedObjectContext: coreDataManager.managedObjectContext)
    }
}
