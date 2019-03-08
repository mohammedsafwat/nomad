//
//  FlightsLocalDataSource.swift
//  Nomad
//
//  Created by Mohammed Safwat on 05.03.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation
import RxSwift
import CoreData

class FlightsLocalDataSource: FlightsDataSource {

    // MARK: - Properties

    private let managedObjectContext: NSManagedObjectContext
    private let storeUtils: StoreUtilsProtocol

    // MARK: - Initializer

    init(managedObjectContext: NSManagedObjectContext, storeUtils: StoreUtilsProtocol) {
        self.managedObjectContext = managedObjectContext
        self.storeUtils = storeUtils
    }

    func flights(flightsFilter: FlightsFilter) -> Observable<FlightsResponse> {
        return Observable<FlightsResponse>.create { observer -> Disposable in
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.CoreData.FlightEntityName)
            let filterIdPredicate = NSPredicate(format: Constants.DataSources.FlightsLocalDataSource.predicateFormatWithFilterId, flightsFilter.filterId)
            let priceSortDescriptor = NSSortDescriptor(key: Constants.DataSources.FlightsLocalDataSource.priceSortDescriptorKey, ascending: true)
            fetchRequest.predicate = filterIdPredicate
            fetchRequest.sortDescriptors = [priceSortDescriptor]

            do {
                let flightsManagedObjects = try self.managedObjectContext.fetch(fetchRequest) as? [FlightEntity]
                let flights = flightsManagedObjects?.compactMap { self.createFlight(from: $0) }
                observer.onNext(FlightsResponse(flights: flights, currency: self.storeUtils.loadCurrency()))
                observer.onCompleted()
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }

    func storeFlights(flightsResponse: FlightsResponse, withFilter flightsFilter: FlightsFilter) -> Observable<FlightsResponse> {
        return self.deleteAllFlights(withFlightsFilter: flightsFilter).flatMap { result -> Observable<FlightsResponse> in
            return Observable<FlightsResponse>.create { observer -> Disposable in
                switch result {
                case .success:
                    flightsResponse.flights?.forEach { self.saveFlight(flight: $0, flightsFilter: flightsFilter, completion: { dataError in
                        if let dataError = dataError {
                            observer.onError(dataError)
                        }
                    }) }
                    observer.onNext(flightsResponse)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
                return Disposables.create()
            }
        }
    }
}

// MARK: - Private Methods

extension FlightsLocalDataSource {
    private func saveFlight(flight: Flight, flightsFilter: FlightsFilter, completion: @escaping (DataError?) -> Void) {
        managedObjectContext.perform {
            let flightManagedObject = FlightEntity(context: self.managedObjectContext)

            flightManagedObject.price = Int64(flight.price ?? 0)
            flightManagedObject.deepLink = flight.deepLink
            flightManagedObject.filterId = flightsFilter.filterId
            let routeItems = flight.route?.map { self.createRouteItemManagedObject(from: $0) }
            flightManagedObject.routeItems = NSOrderedSet(array: routeItems ?? [])

            do {
                try self.managedObjectContext.save()
                completion(nil)
            } catch let error {
                let dataError = DataError(dataErrorType: .dbFailed, dataErrorMessage: error.localizedDescription)
                completion(dataError)
            }
        }
    }

    private func createFlight(from flightManagedObject: FlightEntity?) -> Flight {
        let routeItems = flightManagedObject?.routeItems?.array as? [RouteItemEntity]
        let route = routeItems?.compactMap { self.createRouteItem(from: $0) }
        let price = Int(flightManagedObject?.price ?? 0)
        let deepLink = flightManagedObject?.deepLink

        return Flight(route: route, price: price, deepLink: deepLink)
    }

    private func createRouteItem(from routeItemManagedObject: RouteItemEntity?) -> RouteItem {
        let flyTo = routeItemManagedObject?.flyTo
        let flyFrom = routeItemManagedObject?.flyFrom
        let cityTo = routeItemManagedObject?.cityTo
        let cityFrom = routeItemManagedObject?.cityFrom
        let departureTime = routeItemManagedObject?.departureTime
        let arrivalTime = routeItemManagedObject?.arrivalTime
        let flightNumber = Int(routeItemManagedObject?.flightNumber ?? 0)
        let airline = routeItemManagedObject?.airline

        return RouteItem(flyTo: flyTo, flyFrom: flyFrom, cityTo: cityTo, cityFrom: cityFrom, departureTime: departureTime, arrivalTime: arrivalTime, flightNumber: flightNumber, airline: airline)
    }

    private func createRouteItemManagedObject(from routeItem: RouteItem) -> RouteItemEntity {
        let routeItemManagedObject = RouteItemEntity(context: managedObjectContext)
        routeItemManagedObject.flyTo = routeItem.flyTo
        routeItemManagedObject.flyFrom = routeItem.flyFrom
        routeItemManagedObject.cityTo = routeItem.cityTo
        routeItemManagedObject.cityFrom = routeItem.cityFrom
        routeItemManagedObject.departureTime = routeItem.departureTime ?? 0.0
        routeItemManagedObject.arrivalTime = routeItem.arrivalTime ?? 0.0
        routeItemManagedObject.flightNumber = Int64(routeItem.flightNumber ?? 0)
        routeItemManagedObject.airline = routeItem.airline
        return routeItemManagedObject
    }

    private func deleteAllFlights(withFlightsFilter flightsFilter: FlightsFilter) -> Observable<Result<Bool, DataError>> {
        return Observable<Result<Bool, DataError>>.create { observer -> Disposable in
            let fetchRequest: NSFetchRequest<FlightEntity> = FlightEntity.fetchRequest()
            let filterIdPredicate = NSPredicate(format: Constants.DataSources.FlightsLocalDataSource.predicateFormatWithFilterId, flightsFilter.filterId)
            fetchRequest.predicate = filterIdPredicate

            self.managedObjectContext.perform {
                do {
                    let flightsManagedObjects = try fetchRequest.execute()
                    flightsManagedObjects.forEach { self.managedObjectContext.delete($0) }
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
}
