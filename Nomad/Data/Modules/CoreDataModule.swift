//
//  CoreDataModule.swift
//  Nomad
//
//  Created by Mohammed Safwat on 06.03.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation

class CoreDataModule {

    // MARK: - Properties

    static let shared = CoreDataModule()

    // MARK: - Initializer

    private init() {}

    var coreDataManger: CoreDataManagerProtocol {
        return CoreDataManager(modelName: Constants.CoreData.modelName)
    }
}
