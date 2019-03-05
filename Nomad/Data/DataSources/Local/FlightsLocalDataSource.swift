//
//  FlightsLocalDataSource.swift
//  Nomad
//
//  Created by Mohammed Safwat on 05.03.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import Foundation
import RxSwift
import RxCoreData
import CoreData

class FlightsLocalDataSource: FlightsDataSource {

    // MARK: - Properties

    private let managedObjectContext: NSManagedObjectContext
    private let storeUtils: StoreUtils

    // MARK: - Initializer

    init(managedObjectContext: NSManagedObjectContext, storeUtils: StoreUtils) {
        self.managedObjectContext = managedObjectContext
        self.storeUtils = storeUtils
    }

    func flights(flightsFilter: FlightsFilter) -> Observable<FlightsResponse> {
        let fetchRequest: NSFetchRequest<FlightEntity> = FlightEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: Constants.DataSources.FlightsLocalDataSource.predicateFormatWithFilterId, flightsFilter.hashValue)
        let priceSortDescriptor = NSSortDescriptor(key: Constants.DataSources.FlightsLocalDataSource.priceSortDescriptorKey, ascending: true)
        fetchRequest.sortDescriptors = [priceSortDescriptor]

        return managedObjectContext.rx.entities(fetchRequest: fetchRequest).asObservable().map { flightsManagedObjects in
            flightsManagedObjects.compactMap { self.createFlight(from: $0) }
        }.flatMap { flights -> Observable<FlightsResponse> in
            let flightsResponse = FlightsResponse(flights: flights, currency: self.storeUtils.loadCurrency())
            return Observable.of(flightsResponse)
        }
    }

    func storeFlights(flights: [Flight], withFilter flightsFilter: FlightsFilter) {

    }
}

// MARK: - Private Methods

extension FlightsLocalDataSource {
    private func createFlight(from flightManagedObject: FlightEntity?) -> Flight {
        let routeItems = flightManagedObject?.routeItems?.allObjects as? [RouteItemEntity]
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

    private func saveFlight(flight: Flight, withFilter flightsFilter: FlightsFilter, completion: @escaping (DataError?) -> Void) {
        let predicate = NSPredicate(format: Constants.DataSources.FlightsLocalDataSource.predicateFormatWithFilterId, flightsFilter.hashValue)

        managedObjectContext.perform {
            self.getFlightManagedObject(withPredicate: predicate, completion: { result in
                switch result {
                case .success(let flightEntity):
                    if let price = flight.price {
                        flightEntity.price = Int64(price)
                    }
                    flightEntity.deepLink = flight.deepLink
                    flightEntity.filterId = Int64(flightsFilter.hashValue)
                    
                    do {
                        try self.managedObjectContext.save()
                        completion(nil)
                    } catch {
                        completion(DataErrorHelper.dbFailedError)
                    }
                case .failure(let dataError):
                    completion(dataError)
                }
            })
        }
    }

    private func getFlightManagedObject(withPredicate predicate: NSPredicate, completion: @escaping (Result<FlightEntity, DataError>) -> Void) {
        let fetchRequest: NSFetchRequest<FlightEntity> = FlightEntity.fetchRequest()
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = []

        do {
            guard let flightManagedObject = try fetchRequest.execute().first else {
                completion(.failure(DataErrorHelper.dbFailedError))
                return
            }
            completion(.success(flightManagedObject))
        } catch {
            completion(.failure(DataErrorHelper.dbFailedError))
        }
    }
}
