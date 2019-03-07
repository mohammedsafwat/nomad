//
//  FilterLocalDataSource.swift
//  Nomad
//
//  Created by Mohammed Safwat on 07.03.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation
import CoreData

class FilterLocalDataSource: FilterDataSource {

    // MARK: - Properties

    private let managedObjectContext: NSManagedObjectContext

    // MARK: - Initializer

    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }

    func storeFlightsFilter(flightsFilter: FlightsFilter) {

    }
}

// MARK: - Private Methods

extension FilterLocalDataSource {
    private func saveFlightsFilter(flightsFilter: FlightsFilter, completion: @escaping (DataError?) -> Void) {
        managedObjectContext.perform {
            let flightsFilterManagedObject = FlightsFilterEntity(context: self.managedObjectContext)

            flightsFilterManagedObject.from = self.createLocationManagedObject(from: flightsFilter.from)
            flightsFilterManagedObject.travelInterval = flightsFilter.travelInterval.rawValue
            flightsFilterManagedObject.price = Int64(flightsFilter.price)
            flightsFilterManagedObject.limit = Int16(flightsFilter.limit)
            flightsFilterManagedObject.maxStopovers = Int16(flightsFilter.maxStopovers)

            do {
                try self.managedObjectContext.save()
                completion(nil)
            } catch let error {
                let dataError = DataError(dataErrorType: .dbFailed, dataErrorMessage: error.localizedDescription)
                completion(dataError)
            }
        }
    }

    private func createLocationManagedObject(from location: Location) -> LocationEntity {
        let locationManagedObject = LocationEntity(context: managedObjectContext)
        locationManagedObject.id = location.id
        locationManagedObject.code = location.code
        locationManagedObject.name = location.name
        return locationManagedObject
    }
}
