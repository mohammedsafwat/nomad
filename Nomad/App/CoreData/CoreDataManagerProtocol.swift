//
//  CoreDataManagerProtocol.swift
//  Nomad
//
//  Created by Mohammed Safwat on 06.03.19.
//  Copyright © 2019 Mohammed Safwat. All rights reserved.
//

import CoreData

protocol CoreDataManagerProtocol {
    var managedObjectContext: NSManagedObjectContext { get }
}
