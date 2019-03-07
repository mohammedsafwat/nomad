//
//  FilterLocalDataSource.swift
//  Nomad
//
//  Created by Mohammed Safwat on 07.03.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

class FilterLocalDataSource: FilterDataSource {

    // MARK: - Properties

    private let managedObjectContext: NSManagedObjectContext

    // MARK: - Initializer

    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }

    func flightsFilter() -> Observable<FlightsFilter> {
        return Observable<FlightsFilter>.create { observer -> Disposable in
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.CoreData.FlightsFilterEntityName)
            do {
                let flightsFilterManagedObjects = try self.managedObjectContext.fetch(fetchRequest) as? [FlightsFilterEntity]
                let flightsFilter = flightsFilterManagedObjects?.isEmpty ?? true ? DataModule.shared.defaultFlightsFilter : self.createFlightsFilter(from: flightsFilterManagedObjects?.first)
                observer.onNext(flightsFilter)
                observer.onCompleted()
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }

    func storeFlightsFilter(flightsFilter: FlightsFilter) -> Observable<FlightsFilter> {
        return self.deleteFlightsFilter().flatMap({ result -> Observable<FlightsFilter> in
            return Observable<FlightsFilter>.create { observer -> Disposable in
                switch result {
                case .success:
                    self.saveFlightsFilter(flightsFilter: flightsFilter) { dataError in
                        if let dataError = dataError {
                            observer.onError(dataError)
                        }
                        observer.onNext(flightsFilter)
                        observer.onCompleted()
                    }
                case .failure(let error):
                    observer.onError(error)
                }
                return Disposables.create()
            }
        })
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

    private func deleteFlightsFilter() -> Observable<Result<Bool, DataError>> {
        return Observable<Result<Bool, DataError>>.create { observer -> Disposable in
            let fetchRequest: NSFetchRequest<FlightsFilterEntity> = FlightsFilterEntity.fetchRequest()

            self.managedObjectContext.perform {
                do {
                    let flightsFilterManagedObjects = try fetchRequest.execute()
                    flightsFilterManagedObjects.forEach { self.managedObjectContext.delete($0) }
                    try self.managedObjectContext.save()
                    observer.onNext(.success(true))
                    observer.onCompleted()
                } catch let error {
                    let dataError = DataError(dataErrorType: .dbFailed, dataErrorMessage: error.localizedDescription)
                    observer.onError(dataError)
                }
            }
            return Disposables.create()
        }
    }

    private func createLocationManagedObject(from location: Location) -> LocationEntity {
        let locationManagedObject = LocationEntity(context: managedObjectContext)
        locationManagedObject.id = location.id
        locationManagedObject.code = location.code
        locationManagedObject.name = location.name
        return locationManagedObject
    }

    private func createFlightsFilter(from flightsFilterManagedObject: FlightsFilterEntity?) -> FlightsFilter {
        let from = createLocation(from: flightsFilterManagedObject?.from)
        let price = Int(flightsFilterManagedObject?.price ?? 0)
        let limit = Int(flightsFilterManagedObject?.limit ?? 0)
        let maxStopovers = Int(flightsFilterManagedObject?.maxStopovers ?? 0)
        let travelIntervalString = flightsFilterManagedObject?.travelInterval ?? ""
        let travelInterval = TravelInterval(rawValue: travelIntervalString) ?? Constants.DefaultFilter.travelInterval
        return FlightsFilter(from: from, travelInterval: travelInterval == .undefined ? Constants.DefaultFilter.travelInterval : travelInterval, price: price, limit: limit, maxStopovers: maxStopovers)
    }

    private func createLocation(from locationManagedObject: LocationEntity?) -> Location {
        let id = locationManagedObject?.id
        let code = locationManagedObject?.code
        let name = locationManagedObject?.name

        return Location(id: id, code: code, name: name)
    }
}
